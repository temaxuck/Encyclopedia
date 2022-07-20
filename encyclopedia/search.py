class SearchBase(object):
    session = None
    query : str = None
    limit : int = None
    
    results = []
    searchers = [] # class 

    def __init__(
        self,
        session,
        query : str,
        limit : int = 50,
        *args, **kwargs
        ):

        if not query:
            raise ValueError('Query should not be empty') 

        if not session:
            raise ValueError('Session should not be empty') 

        self.query = query
        self.session = session
        self.limit = limit

    def prepare_searchers(self, *args, **kwargs):
        self.searchers = []

        for arg in args:
            self.searchers += [arg(self)]

    def get_search_results(self):
        return self.results

    def search(self):
        import json

        self.results = []

        for searcher in self.searchers:
            searcher_results = searcher.get_results()

            if not searcher_results:
                continue

            self.results.extend(searcher_results)
        
        results = list(
            map(lambda x: json.loads(x.toJSON()), self.results)
            )

        return results

class DefaultSearch(SearchBase):

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)

        self.prepare_searchers(
                PyramidSearcherBySequenceNumber,
                PyramidSearcherByGeneratingFunction,
                PyramidSearcherByExplicitFormula,
                UserSearcherByUsername
            )

class PyramidDataSearch(SearchBase):

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)

        self.prepare_searchers(
                PyramidSearcherByData
            )

class CustomSearch(SearchBase):

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)


class Searcher(object):
    search_ref : SearchBase = None

    def __init__(self, search : SearchBase):
        self.search_ref = search

    def get_pyramids_by_list_of_id(self, id_list):
        from encyclopedia.models import Pyramid 
        results = []

        for id in id_list:
            results.append(Pyramid.query.filter_by(id=id).first())

        return results

    def get_results(self) -> list:
        # Get results should return 
        raise NotImplementedError

    def prepare_string(self, s) -> str:
        raise NotImplementedError

# 
# Pyramid Searchers
# 
if True:

    class PyramidSearcherBySequenceNumber(Searcher):

        def get_results(self):
            from sqlalchemy.sql import text

            from encyclopedia import db
            
            sql_ex = text('''
                SELECT id FROM pyramid 
                WHERE (CAST (pyramid.sequence_number AS text) LIKE '%%' || :seq_num || '%%') 
                ORDER BY pyramid.sequence_number ASC 
                LIMIT :limit
                ''')
            results = []
            
            with db.engine.connect() as conn:
                op = conn.execute(sql_ex, seq_num=self.search_ref.query, limit=self.search_ref.limit)

            results = self.get_pyramids_by_list_of_id(op.scalars().all())

            return results

    class PyramidSearcherByGeneratingFunction(Searcher):

        def get_results(self):
            from encyclopedia.models import GeneratingFunction
            
            return [gf.pyramid for gf in GeneratingFunction.query.msearch(self.search_ref.query, fields=['expression'], limit=self.search_ref.limit).all()]

    class PyramidSearcherByExplicitFormula(Searcher):
            
        def get_results(self):
            from encyclopedia.models import ExplicitFormula

            return [ef.pyramid for ef in ExplicitFormula.query.msearch(self.search_ref.query, fields=['expression'], limit=self.search_ref.limit).all()]
        
    class PyramidSearcherByData(Searcher):
        # get_results() expects query to be 'x, x, x, x, x, x, x' (actually amount of spaces doesn't matter)
        # Or 'x x x x x x x' (actually amount of spaces doesn't matter)
        # Otherwise return []

        def prepare_string(self, s):
            import re

            p = re.compile(r'[\s*,\s*]+')
            return re.split(p, s.rstrip())

        def get_results(self):
            from sqlalchemy import select, text

            from encyclopedia import db

            query = self.prepare_string(self.search_ref.query)
            
            sql_ex = text('''
                SELECT id 
                FROM pyramid 
                WHERE index_of_subarray(data, (SELECT (:_data)::text[])) IS NOT NULL
                LIMIT :limit;
                ''')
            results = []

            with db.engine.connect() as conn:
                op = conn.execute(sql_ex, _data=query, limit=self.search_ref.limit)
            
            results = self.get_pyramids_by_list_of_id(op.scalars().all())

            return results

# 
# User Searchers
# 
if True:

    class UserSearcherByUsername(Searcher):

        def prepare_string(self, s):
            return s.lower()

        def get_results(self):
            from encyclopedia.models import User

            query = self.prepare_string(self.search_ref.query)

            return User.query.msearch(query, fields=['username'], limit=self.search_ref.limit).all()
