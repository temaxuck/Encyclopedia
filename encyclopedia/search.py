class SearchBase(object):
    session = None
    query: str = None
    limit: int = None

    results = []
    searchers = []  # class

    def __init__(self, session, query: str, limit: int = 50, *args, **kwargs):
        if not query:
            raise ValueError("Query should not be empty")

        if not session:
            raise ValueError("Session should not be empty")

        self.query = query
        self.session = session
        self.limit = limit

    def prepare_searchers(self, *args, **kwargs):
        self.searchers = []

        for arg in args:
            self.searchers += [arg(self)]

    def get_search_results(self):
        return self.results

    def search(self, is_api_search=False):
        # is_api_search parameter needed to convert data for api response,
        #   as frontend needs it's own format (to be fixed)
        import json

        results = {"exact": [], "related": []}

        for searcher in self.searchers:
            searcher_results = searcher.get_results()

            if not searcher_results:
                continue

            results["exact"].extend(searcher_results.get("exact") or [])
            results["related"].extend(searcher_results.get("related") or [])

        results["exact"] = list(
            map(
                lambda x: json.loads(x.json() if is_api_search else x.toJSON()),
                results["exact"],
            )
        )

        results["related"] = list(
            map(
                lambda x: json.loads(x.json() if is_api_search else x.toJSON()),
                results["related"],
            )
        )

        for result in results["exact"]:
            try:
                results["related"].remove(result)
            except:
                ...

        self.results = results

        return results


class DefaultSearch(SearchBase):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)

        self.prepare_searchers(
            PyramidSearcherBySequenceNumber,
            PyramidSearcherByGeneratingFunction,
            PyramidSearcherByExplicitFormula,
            UserSearcherByUsername,
        )


class PyramidDataSearch(SearchBase):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)

        self.prepare_searchers(PyramidSearcherByData)


class CustomSearch(SearchBase):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)


class Searcher(object):
    search_ref: SearchBase = None

    def __init__(self, search: SearchBase):
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
            from encyclopedia.models import Pyramid

            exact = []
            try:
                exact = Pyramid.query.filter_by(
                    sequence_number=int(self.search_ref.query)
                ).all()
            except ValueError:
                ...

            related = []
            sql_ex = text(
                """
                SELECT id FROM pyramid 
                WHERE (CAST (pyramid.sequence_number AS text) LIKE '%%' || :seq_num || '%%') 
                ORDER BY pyramid.sequence_number ASC 
                LIMIT :limit
                """
            )

            with db.engine.connect() as conn:
                op = conn.execute(
                    sql_ex, seq_num=self.search_ref.query, limit=self.search_ref.limit
                )

            related = self.get_pyramids_by_list_of_id(op.scalars().all())
            result = {
                "exact": exact,
                "related": related,
            }
            return result

    class PyramidSearcherByGeneratingFunction(Searcher):
        # sympify to always get the same (sympy) formula format
        def prepare_string(self, s) -> str:
            from sympy import sympify

            try:
                return str(sympify(s))
            except:
                return s

        def get_results(self):
            from encyclopedia.models import GeneratingFunction

            query = self.prepare_string(self.search_ref.query)
            exact = [
                gf.pyramid
                for gf in GeneratingFunction.query.filter_by(expression=query).all()
            ]
            related = [
                gf.pyramid
                for gf in GeneratingFunction.query.msearch(
                    query, fields=["expression"], limit=self.search_ref.limit
                ).all()
            ]
            result = {
                "exact": exact,
                "related": related,
            }
            return result

    class PyramidSearcherByExplicitFormula(Searcher):
        # sympify to always get the same (sympy) formula format
        def prepare_string(self, s) -> str:
            from sympy import sympify

            try:
                return str(sympify(s))
            except:
                return s

        def get_results(self):
            from encyclopedia.models import ExplicitFormula
            from sympy import sympify

            query = self.prepare_string(self.search_ref.query)

            exact = [
                ef.pyramid
                for ef in ExplicitFormula.query.filter_by(expression=query).all()
            ]
            related = [
                ef.pyramid
                for ef in ExplicitFormula.query.msearch(
                    query, fields=["expression"], limit=self.search_ref.limit
                ).all()
            ]
            result = {
                "exact": exact,
                "related": related,
            }

            return result

    class PyramidSearcherByData(Searcher):
        # get_results() expects query to be 'x, x, x, x, x, x, x' (actually amount of spaces doesn't matter)
        # Or 'x x x x x x x' (actually amount of spaces doesn't matter)
        # Otherwise return []

        def prepare_string(self, s):
            import re

            p = re.compile(r"[\s*,\s*]+")
            return re.split(p, s.rstrip())

        def get_results(self):
            from sqlalchemy import select, text

            from encyclopedia import db

            query = self.prepare_string(self.search_ref.query)

            sql_ex = text(
                """
                SELECT id 
                FROM pyramid 
                WHERE index_of_subarray(data, (SELECT (:_data)::text[])) IS NOT NULL
                LIMIT :limit;
                """
            )
            results = []

            with db.engine.connect() as conn:
                op = conn.execute(sql_ex, _data=query, limit=self.search_ref.limit)

            results = self.get_pyramids_by_list_of_id(op.scalars().all())

            return {"related": results}


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

            exact = User.query.filter_by(username=query).all()
            related = User.query.msearch(
                query, fields=["username"], limit=self.search_ref.limit
            ).all()
            result = {
                "exact": exact,
                "related": related,
            }

            return result
