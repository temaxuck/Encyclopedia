--
-- PostgreSQL database dump
--

-- Dumped from database version 12.10 (Ubuntu 12.10-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.10 (Ubuntu 12.10-0ubuntu0.20.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: index_of_subarray(anyarray, anyarray); Type: FUNCTION; Schema: public; Owner: prog
--

CREATE FUNCTION public.index_of_subarray(arr anyarray, sub anyarray) RETURNS integer
    LANGUAGE plpgsql IMMUTABLE
    AS $$                                                               
        begin                  
            if cardinality(arr) IS NULL then 
                return NULL;
            end if;                                         
            for i in 1 .. cardinality(arr)- cardinality(sub)+ 1 loop    
            if arr[i : i + cardinality(sub) - 1] = sub then             
                    return i;                                           
                end if;                                                 
            end loop;                                                   
            return NULL;                                                
        end                                                             
$$;


ALTER FUNCTION public.index_of_subarray(arr anyarray, sub anyarray) OWNER TO prog;

--
-- Name: one(); Type: FUNCTION; Schema: public; Owner: prog
--

CREATE FUNCTION public.one() RETURNS void
    LANGUAGE plpgsql
    AS $_$ 
	BEGIN
   		RAISE NOTICE '%', $1;
	END;
$_$;


ALTER FUNCTION public.one() OWNER TO prog;

--
-- Name: one(text); Type: FUNCTION; Schema: public; Owner: prog
--

CREATE FUNCTION public.one(table_name text) RETURNS void
    LANGUAGE plpgsql
    AS $_$ 
	BEGIN
   		RAISE NOTICE '%', $1;
	END;
$_$;


ALTER FUNCTION public.one(table_name text) OWNER TO prog;

--
-- Name: set_serial_sequence(text); Type: FUNCTION; Schema: public; Owner: prog
--

CREATE FUNCTION public.set_serial_sequence(table_name text) RETURNS text
    LANGUAGE plpgsql
    AS $$ 
	BEGIN
   		
			SELECT PG_GET_SERIAL_SEQUENCE(table_name, 'id');
			SELECT CURRVAL(PG_GET_SERIAL_SEQUENCE(table_name, 'id')) AS "Current Value", MAX("id") AS "Max Value" FROM table_name;
			SELECT SETVAL((SELECT PG_GET_SERIAL_SEQUENCE(table_name, 'id')), (SELECT (MAX("id") + 1) FROM table_name), FALSE);
		
	END;
$$;


ALTER FUNCTION public.set_serial_sequence(table_name text) OWNER TO prog;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: alembic_version; Type: TABLE; Schema: public; Owner: prog
--

CREATE TABLE public.alembic_version (
    version_num character varying(32) NOT NULL
);


ALTER TABLE public.alembic_version OWNER TO prog;

--
-- Name: explicitformula; Type: TABLE; Schema: public; Owner: prog
--

CREATE TABLE public.explicitformula (
    id integer NOT NULL,
    limitation text
);


ALTER TABLE public.explicitformula OWNER TO prog;

--
-- Name: explicitformula_id_seq; Type: SEQUENCE; Schema: public; Owner: prog
--

CREATE SEQUENCE public.explicitformula_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.explicitformula_id_seq OWNER TO prog;

--
-- Name: explicitformula_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: prog
--

ALTER SEQUENCE public.explicitformula_id_seq OWNED BY public.explicitformula.id;


--
-- Name: formula; Type: TABLE; Schema: public; Owner: prog
--

CREATE TABLE public.formula (
    id integer NOT NULL,
    function_name text NOT NULL,
    expression text NOT NULL,
    pyramid_id bigint,
    type text
);


ALTER TABLE public.formula OWNER TO prog;

--
-- Name: formula_id_seq; Type: SEQUENCE; Schema: public; Owner: prog
--

CREATE SEQUENCE public.formula_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.formula_id_seq OWNER TO prog;

--
-- Name: formula_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: prog
--

ALTER SEQUENCE public.formula_id_seq OWNED BY public.formula.id;


--
-- Name: generatingfunction; Type: TABLE; Schema: public; Owner: prog
--

CREATE TABLE public.generatingfunction (
    id integer NOT NULL,
    ismain boolean NOT NULL
);


ALTER TABLE public.generatingfunction OWNER TO prog;

--
-- Name: generatingfunction_id_seq; Type: SEQUENCE; Schema: public; Owner: prog
--

CREATE SEQUENCE public.generatingfunction_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.generatingfunction_id_seq OWNER TO prog;

--
-- Name: generatingfunction_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: prog
--

ALTER SEQUENCE public.generatingfunction_id_seq OWNED BY public.generatingfunction.id;


--
-- Name: pyramid; Type: TABLE; Schema: public; Owner: prog
--

CREATE TABLE public.pyramid (
    id integer NOT NULL,
    sequence_number bigint NOT NULL,
    user_id bigint,
    __special_hashed_value__ text,
    data text[]
);


ALTER TABLE public.pyramid OWNER TO prog;

--
-- Name: pyramid_id_seq; Type: SEQUENCE; Schema: public; Owner: prog
--

CREATE SEQUENCE public.pyramid_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pyramid_id_seq OWNER TO prog;

--
-- Name: pyramid_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: prog
--

ALTER SEQUENCE public.pyramid_id_seq OWNED BY public.pyramid.id;


--
-- Name: relations; Type: TABLE; Schema: public; Owner: prog
--

CREATE TABLE public.relations (
    linked_pyramid_id bigint,
    relatedto_pyramid_id bigint,
    tag character varying(30)
);


ALTER TABLE public.relations OWNER TO prog;

--
-- Name: user; Type: TABLE; Schema: public; Owner: prog
--

CREATE TABLE public."user" (
    id integer NOT NULL,
    username text NOT NULL,
    email text NOT NULL,
    profile_imagefile text NOT NULL,
    password text NOT NULL,
    moderator boolean
);


ALTER TABLE public."user" OWNER TO prog;

--
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: prog
--

CREATE SEQUENCE public.user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_id_seq OWNER TO prog;

--
-- Name: user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: prog
--

ALTER SEQUENCE public.user_id_seq OWNED BY public."user".id;


--
-- Name: variable; Type: TABLE; Schema: public; Owner: prog
--

CREATE TABLE public.variable (
    id integer NOT NULL,
    variable_name text NOT NULL,
    formula_id bigint NOT NULL
);


ALTER TABLE public.variable OWNER TO prog;

--
-- Name: variable_id_seq; Type: SEQUENCE; Schema: public; Owner: prog
--

CREATE SEQUENCE public.variable_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.variable_id_seq OWNER TO prog;

--
-- Name: variable_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: prog
--

ALTER SEQUENCE public.variable_id_seq OWNED BY public.variable.id;


--
-- Name: explicitformula id; Type: DEFAULT; Schema: public; Owner: prog
--

ALTER TABLE ONLY public.explicitformula ALTER COLUMN id SET DEFAULT nextval('public.explicitformula_id_seq'::regclass);


--
-- Name: formula id; Type: DEFAULT; Schema: public; Owner: prog
--

ALTER TABLE ONLY public.formula ALTER COLUMN id SET DEFAULT nextval('public.formula_id_seq'::regclass);


--
-- Name: generatingfunction id; Type: DEFAULT; Schema: public; Owner: prog
--

ALTER TABLE ONLY public.generatingfunction ALTER COLUMN id SET DEFAULT nextval('public.generatingfunction_id_seq'::regclass);


--
-- Name: pyramid id; Type: DEFAULT; Schema: public; Owner: prog
--

ALTER TABLE ONLY public.pyramid ALTER COLUMN id SET DEFAULT nextval('public.pyramid_id_seq'::regclass);


--
-- Name: user id; Type: DEFAULT; Schema: public; Owner: prog
--

ALTER TABLE ONLY public."user" ALTER COLUMN id SET DEFAULT nextval('public.user_id_seq'::regclass);


--
-- Name: variable id; Type: DEFAULT; Schema: public; Owner: prog
--

ALTER TABLE ONLY public.variable ALTER COLUMN id SET DEFAULT nextval('public.variable_id_seq'::regclass);


--
-- Data for Name: alembic_version; Type: TABLE DATA; Schema: public; Owner: prog
--

COPY public.alembic_version (version_num) FROM stdin;
9f3d2ba19c60
\.


--
-- Data for Name: explicitformula; Type: TABLE DATA; Schema: public; Owner: prog
--

COPY public.explicitformula (id, limitation) FROM stdin;
2	
4	
6	
8	
10	
12	
14	m=0
15	m>0
17	
19	
21	
23	
25	
27	
29	
31	
33	
35	
37	
39	
41	
43	
45	
47	
49	
51	
53	
55	
57	
59	(n+k)%2=0
60	(n+k)%2=1
62	
64	
66	
68	
70	
72	
74	
76	
78	
80	
82	
84	
86	
88	
90	
92	
94	
96	
98	
100	
102	
104	
106	
108	
110	
112	
114	
116	
118	
120	
122	
124	
126	
128	
130	
132	
134	
136	
138	
140	
142	
144	
146	
148	
150	
152	
154	
156	
158	
160	
162	
164	
166	
168	
170	
172	
174	
176	
178	
180	
182	
184	
186	
188	
190	
192	
194	
196	
198	
200	
202	
204	
206	
208	
210	
212	
214	
216	
218	
220	
222	
224	
226	
228	
230	
232	
234	
236	
238	
240	
242	
244	
246	
248	
250	
252	
254	
256	
258	
260	
262	
264	
266	
268	
270	
272	
274	
276	
278	
280	
282	
284	
286	
288	
290	
292	
294	
296	
298	
300	
302	
304	
306	
308	
310	
312	
314	
316	
318	
320	
322	 m==0 and n==0
323	
325	  m==0 and n==0  
326	
328	
330	
332	
338	
340	
342	
344	
346	
348	
350	  m==0  
351	
353	  m==0  
354	
356	
358	
360	
366	
368	
370	
372	
374	
376	
378	  n==0 and m==0  
379	  k==0  
380	
382	  n==0 and m==0 and k==0  
383	  k==0  
384	
386	
388	
390	
392	
394	
398	
402	
404	
415	
417	
420	
427	
429	
364	m=0
362	m=0 
396	
400	
406	n=0
413	m=0
419	  n=0,m=0 
425	
422	m>0, n=0
423	
439	
441	
444	
448	
450	
452	
456	
458	
460	
462	
464	
466	
468	
470	
472	  n==0 and m==0  
473	
475	  n==0 and m==0  
476	
478	  n==0 and m==0  
479	
481	  n==0 and m==0  
482	
484	  n==0 and m==0  
485	
487	  n==0 and m==0  
488	
490	  m==0 and n==0  
491	
493	  m==0 and n==0  
494	
496	  n==0 and m==0  
497	
499	  n==0 and m==0  
500	
502	
504	
506	
508	  n==0 and m==0  
509	
513	
515	  m==0 and n==0  
517	
519	  n==0 and m==0  
521	
523	
525	
527	
529	  n==0 and m==0 and k==0  
530	  k==0  
531	
536	
542	
544	
546	
548	
550	
552	  n==0  
553	
555	  n==0  
556	
558	
560	
562	
568	  m+n<k or m+n==0  
569	
571	
573	  n==0 and m==0  
574	  n==0  
576	
578	
580	
592	
594	
596	
604	
606	
608	  m==0 and n==0  
610	
614	
616	
618	  m==0  
619	
623	
625	
627	
631	
633	
636	
646	
648	
650	
658	
660	
662	
664	
666	
668	
671	
680	
682	
684	
688	
690	
692	
694	
696	
698	  n==0 and m==0 and k==0  
699	  k==0  
700	
702	
704	
706	
708	
710	
712	
714	
716	
718	
720	
739	
741	  n==0  
744	
746	
750	
754	
756	
758	
762	
764	
766	
768	
770	
772	
774	
777	
779	
782	
520	  m==0  and n==2
535	  m>0
533	  n=0 and m=0 
534	m=0,n=0,k=0
722	k % 2 = 0
724	k % 2 = 0
726	k % 2 = 0
728	k % 2 = 0
564	n=0
566	n=0
575	
584	
582	m+n<k or m+n=0
586	n=0,m=0,k=0
589	n+k=m
732	k % 2 = 0
734	k % 2 = 0
590	n=0,m=0  
588	
431	n=0
437	n=0,m=0
434	n=0
436	n>0
443	  n=0, m=0  
446	n=0,m=0
454	n=0,m=0
737	k % 2 = 0
742	  m=0 ,n=0
743	m=0,n=1
748	n=0
752	m=0,n=1
760	  n==0 and m==0   
776	n=0,m=0 
781	n=0,m=0
598	  m=0, n=0  
599	  n=0  
600	n>0
602	n=0,m=0
609	 m=0  
612	n=0,m=0
621	n=0,m=0
629	m=0
635	m=0,n=0  
643	  m=0, n=0  
644	 m=4
645	m=3
652	m=0
654	n=0,m=0
656	n=0,m=0
540	 n<m
686	m=0
638	
787	
789	
791	
793	
795	
797	
799	
803	
808	
822	
833	
835	
837	
841	
855	
857	
859	
861	
870	
873	
875	
877	
883	
885	
887	
893	
898	
902	
906	
909	
912	
915	
918	
924	
930	
932	  n==0 and m==0  
937	  n<k  
939	
960	
973	
977	
979	
984	
986	
988	
990	
997	
999	 n==0 and m==0
1019	
1025	
1034	
1038	
1049	
1060	
1062	
1064	
1075	
1091	  n < k  
1098	  n < k  
1099	  m == 0  
1100	
1107	  n<k  
1108	  m==0  
801	  n=0,m=0 
802	  n=1,m=0  
805	  n=0  , m=0
806	  m=1,n=0  
813	 k even
814	k odd
811	k %2=0
810	k %2=1
816	k even
818	n=0
820	m=0
824	k even
827	k even
829	
831	k even
839	m=0
853	n>1
851	m>1
849	n>3
847	m>3
845	n>2
843	m>2
863	m>1
1118	n=0, m=0
872	  m=0,n=0  
1105	n>0,m>0
879	m=0
890	n=0
881	m=0
892	  n<2*k  
889	  n>0
1093	
900	n=0,m=0
901	  m==0  
1092	  n = 1
1102	
908	n=0
911	  n < k
914	 n < k  
917	 n<m  
921	m=0
923	n<m
920	n=0,m=0
926	  m=0  
927	m>0
929	m<k 
933	  m==0,n=0  
935	m>0
938	m<k
941	m=0
943	m=0
945	m=0
947	n=0,m=0
949	n<k
951	
953	
955	
957	 n=0,m=0
958	
962	
964	n=0
965	
967	n=0
969	n=0
971	
975	n=0,m=0
981	n=0,m=0
992	n<k
982	n>0
994	
996	m=0 and n = 0
1000	 n=0,m=0
1003	
1005	
1008	n>0
1007	  n=0
1014	n=0,m=0
1011	 m==0,n=0
1012	n<k
1010	m>0,n>0
1018	n=0
1016	n=0,m=0
1021	n<k
1027	n=0
1023	n=0
1031	n=0,m=0
1133	  n<k  
1134	
1138	
1139	
1162	  n==0 and m==0  
1163	  n==0  
1164	  m==0  
1165	
1167	  n<k  
1168	  m==0  
1169	
1171	
1173	  n<2*k  
1174	  m==0  
1175	
1177	  m==0  
1178	  n==0  
1179	
1180	
1182	  n<2*k  
1183	  m==0  
1184	
1186	
1188	
1190	  m==0  
1191	  n==0  
1192	
1193	
1195	  n<2*k  
1196	  m==0  
1197	
1199	  m==0  
1200	  n==0  
1201	
1202	
1204	  n<2*k  
1205	  m==0  
1206	
1208	
1210	  m==0  
1211	  n==0  
1212	
1213	
1215	  n<2*k  
1216	  m==0  
1217	
1219	  m==0  
1220	  n==0  
1221	
1222	
1224	  n<2*k  
1225	  m==0  
1226	
1228	
1230	
1232	  n==0  
1233	
1235	  n<k  
1236	
1238	  n==0  
1239	  m==0  
1240	
1241	
1243	  n==0  
1244	
1246	
1248	
1250	  n==0  
1251	  m==0  
1252	
1253	
1255	  n<k  
1256	
1258	  n==0  
1259	
1261	  n<k  
1262	
1264	  n==0  
1265	  m==0  
1266	
1267	
1269	  n<k  
1270	
1272	  n==0  
1273	  m==0  
1274	
1275	
1277	  n==0  
1278	
1280	  n==0  
1281	
1283	  n==0  
1284	  m==0  
1285	
1286	
1288	  n==0 and m==0  
1289	  m==0  
1290	  n==0  
1291	
1293	  m==0  
1294	
1296	  n<k  
1297	  m==0  
1298	
1300	  m==0  
1301	
1303	
1305	
1307	  m==0  
1308	  n==0  
1309	
1310	
1312	
1314	
1316	
1318	
1320	
1322	
1324	
1326	
1328	  n==0  
1329	
1332	
1335	
1337	  n==0  
1338	
1340	
1350	
1352	  n==0  
1353	
1355	  n<k  
1356	
1358	
1360	
1362	
1369	
1371	
1373	
1377	
1379	  n==0  
1380	
1382	  n<k  
1383	
1385	
1387	
1389	
1391	  n==0  
1392	
1394	  n<k  
1395	
1397	
1399	  m==0  
1400	
1402	  m==0  
1403	
1405	  m==0  
1406	
1408	
1410	  m==0  
1411	
1413	  m==0  
1414	
1416	  m==0  
1417	  n==0  
1418	  n==0  
1419	
1420	
1422	
1424	 m==0
1126	n<k
1130	m=0,n=0
1144	m=0,n=0
1344	n==0
1346	n==0
1331	
1348	n==0
1364	n==0
1366	  n<k  
1122	 m=0  
1375	n==0
1123	n>0,m>0
1127	m=0
1141	m=0
1128	m>0,n>k
1147	n=0
1137	
1136	
1149	n>0
1148	m=0
1157	m=0
1334	n=0
1142	n=0,m>0
1426	  m==0  
1427	
1429	  m==0  
1430	
1432	  m==0  
1433	  n==0  
1434	  n==0  
1435	
1436	
1438	  n==0  
1439	
1441	  n==0  
1442	
1444	
1446	
1448	  n==0  
1449	
1451	
1453	
1455	
1457	  n==0  
1458	
1460	
1462	
1464	
1466	  n==0  
1467	
1469	
1471	
1473	
1475	  n==0  
1476	
1478	
1480	
1482	
1484	  n==0  
1485	
1487	
1489	
1491	
1493	
1495	
1497	
1499	  n==0  
1500	
1502	
1504	
1506	
1508	  m==0  
1509	
1511	  m==0  
1512	
1514	  m==0  
1515	
1517	  m==0  
1518	  n==0  
1519	  n==0  
1520	
1521	
1531	  n==0  
1532	
1534	  m==0  
1535	  n==0  
1536	  n==0  
1537	
1538	
1540	  n<k  
1541	  m==0  
1542	
1548	
1553	  n==0  
1554	
1556	  n==0  
1557	
1561	  m==0  
1562	  n==0  
1563	
1564	
1566	  m==0  
1567	  n==0  
1568	
1569	
1573	  m==0  
1574	  n==0  
1575	
1576	
1578	  m==0  
1579	  n==0  
1580	
1581	
1583	
1585	  m==0  
1586	  n==0  
1587	
1588	
1590	  m==0  
1591	  n==0  
1592	
1593	
1595	  m==0  
1596	
1598	  m==0  
1599	  n==0  
1600	
1601	
1603	  m==0  
1604	
1606	  m==0  
1607	
1609	  m+n==0  
1610	  n==0  
1611	  m==0  
1612	
1614	  m==0 and n==0  
1615	  n==0 and m>0  
1616	  m==0 and n>0  
1617	
1619	  m==0 and n==0  
1620	  n==0 and m>0  
1621	  m==0 and n>0  
1622	
1624	  m==0 and n==0  
1625	  n==0 and m>0  
1626	  m==0 and n>0  
1627	
1629	  n==0  
1630	
1632	
1634	
1636	
1638	  m==0  
1639	  n==0  
1640	  n==0  
1641	
1642	
1644	
1646	
1648	
1650	  n==0  
1651	
1653	
1655	
1657	
1659	
1661	 n==0
1663	
1665	
1667	 n+m==0
1669	  n+m==0  
1670	
1672	
1674	
1676	  n==0  
1677	
1679	
1681	 n+m==0
1683	 n+m==0
1685	
1687	  m==0  
1688	
1690	  m==0  
1691	  n==0  
1692	
1693	
1695	  m==0  
1696	
1698	 n+m==0
1700	 n+m==0
1702	  m+n==0  
1703	
1705	  m==0  
1706	
1708	  m==0  
1709	  n==0  
1710	
1711	
1713	 n+m==0
1715	 n+m==0
1717	
1719	
1721	
1723	
1725	
1727	
1731	
1733	
1735	
1740	
1745	
2153	
1737	
1742	
1523	m=0 
1525	m=0 
1529	m=0,n=0
1544	  n=0  
1547	n < k
1550	  n=0  
1551	n > 0
1559	n = 0
1571	n = 0
1527	m>0
1750	
1755	
1757	
1765	
1767	
1769	
1771	
1773	
1775	
1777	
1779	
1781	
1783	
1785	
1787	
1789	
1791	
1793	
1795	
1797	
1799	
1801	
1803	
1811	
1813	
1819	
1821	
1827	 n+m==0
1829	
1831	
1833	
1835	
1837	
1839	
1841	
1843	
1845	
1847	
1849	
1851	
1853	
1855	
1857	
1859	
1861	
1863	
1865	
1867	
1869	
1875	
1879	
1885	
1889	
1891	
1893	
1895	
1897	
1899	
1901	
1903	
1905	
1907	
1911	
1915	
1927	
1931	
1935	
1940	
1945	
1947	
1949	
1951	
1953	
1955	  m==0  
1956	
1958	
1960	  m==0  
1961	
1963	
1965	
1967	
1969	  m==0 and n==0  
1970	  m==0 and n>0  
1971	
1973	  n==0  
1974	
1976	  n==0  
1977	
1979	  n==0  
1980	
1982	
1984	
1986	
1988	  n+m<2*k  
1989	
1991	  n+m < 3*k  
1992	
1994	  n+m<4*k  
1995	
1997	
1999	
2001	
2003	
2005	
2007	
2009	
2011	
2013	  n<m  
2014	  m==0  
2015	
2017	  n==0  
2018	
2020	  n==0  
2021	
2023	  n==0  
2024	
2026	  n==0  
2027	
2029	
2031	
2033	
2035	
2037	
2039	
2041	
2043	
2045	
2047	
2049	  m==0  
2050	
2052	  m==0  
2053	
2055	
2057	
2059	
2061	
2063	
2065	
2067	
2069	
2071	
2073	
2075	
2077	
2079	
2081	
2083	
2085	
2087	
2089	
2091	
2093	
2095	
2097	
2099	
2101	
2103	
2105	
2107	
2109	
2111	
2113	
2115	
2117	
2119	
2121	
2123	
2125	
2127	
2129	
2131	
2133	
2135	
2137	
2139	
2141	
2143	
2145	
2147	
2149	
2151	
1752	
1759	
1762	
1807	
1817	n=0,m=0
1815	
1944	0
1823	k % 2 = 0
1871	
1873	
1877	
1883	n=0, m=0
1881	n = 0
1887	n=0
1909	 n=0,m=0, k=0
1917	n=0
1913	n=0
1919	
1921	n=0
1923	
1925	n=0
1929	n=0
1825	k % 2 = 0 
1933	n=0
1805	n>0
1809	n>0
1942	n==0, m==0
1937	.
1938	.
1939	.
2155	
2157	
2159	
2161	
2163	
2165	
2167	
2169	
2171	
2173	
2175	
2177	
2179	
2181	
2183	
2185	
2187	
2189	
2191	
2193	
2195	
2197	
2199	
2201	
2203	
2205	
2207	
2209	
2211	
2213	
2215	
2217	
2219	
2221	
2223	
2225	
2227	
2229	
2231	
2233	
2235	
2237	
2239	
2241	
2243	
2245	
2247	
2249	
2251	
2253	
2255	
2257	
2259	
2261	
2263	
2265	
2267	
2269	
2271	
2273	
2275	
2277	
2279	
2281	
2283	
2285	
2287	
2289	
2291	
2293	
2295	
2297	
2299	
2301	
2303	
2305	
2307	
2309	
2311	
2313	
2315	
2317	
2319	
2321	
2323	
2325	
2327	
2329	
2331	
2333	
2335	
2337	
2339	
2341	
2343	
2345	
2347	
2349	
2351	
2353	
2355	
2357	
2359	
2361	
2363	
2365	
2367	
2369	
2371	
2373	
2375	
2377	
2379	
2381	
2383	
2385	
2387	
2391	
2393	
2395	
2397	
2399	
2401	
2403	
2405	
2407	
2409	
2411	
2413	
2415	
2417	
2419	
2421	
2423	
2425	
2427	
2429	
2431	
2433	
2435	
2437	
2439	
2441	
2443	
2445	
2447	
2449	
2451	
2453	
2455	
2457	
2459	
2461	
2463	
2465	
2467	
2475	
2477	
2479	
2481	
2483	
2485	
2497	
2499	
2501	
2503	
2505	
2507	
2513	k even
2514	k odd,n>k
2515	k odd,n<k
2521	k even
2522	k odd,n>k
2523	k odd,n<k
2525	k even
2526	k odd,n>k
2527	k odd,n<k
2529	k even
2531	k even
2532	k odd,n>k
2533	k odd,n<k
2535	k even
2536	k odd,n>k
2537	k odd,n<k
2539	n+k even
2540	n+k odd
2542	n+k even
2543	n+k odd
2545	n+k even
2546	n+k odd
2551	
2553	k odd
2554	k even
2556	
2558	
2560	n=0
2566	
2568	
2570	n=0
2571	n>0
2573	n=0,m=0
2517	
2564	m=0
2389	n=0,m=0
2561	n>0
2469	n=0,m=0
2471	n=0,m=0
2473	n=0,m=0
2487	n=0,m=0
2489	n=0,m=0
2491	n=0,m=0
2493	n=0,m=0
2495	n=0,m=0
2509	n=0,m=0
2511	n=0,m=0
2581	
2583	
2585	n=0
2586	n>0
2588	
2590	
2592	
2594	
2596	
2598	
2600	
2602	
2604	
2606	
2608	
2610	
2612	
2614	
2616	
2618	
2620	
2622	
2624	
2626	
2628	
2630	
2632	
2634	
2636	
2638	
2640	
2642	
2644	
2646	
2648	
2650	
2652	
2654	
2656	
2658	
2660	
2662	
2664	
2666	
2668	
2670	
2672	
2674	
2676	
2678	
2680	
2682	
2684	
2686	
2688	
2690	
2692	
2694	m=0 
2695	m>0
2697	 n = 0, m = 0
2698	m = 0, n > 0
2699	m > 0
2701	n = 0
2702	n > 0
2713	n=n
2719	
2721	
2723	
2727	
2729	
2731	
2733	
2739	
2741	
2743	
2745	
2747	
2749	
2751	
2753	m>0
2754	m=0
2756	
2758	n=0,m=0 ,k=0
2759	k even
2760	k odd
2762	m>0
2763	m=0
2765	
2767	
2769	
2771	
2773	
2781	
2799	k % 2 = 1
2801	
2802	
511	n=0,m=0
2786	
516	  m==3 and n==3
2548	m=0 and n= 0
2549	m>0,n>0
2787	m==0 or n= 0
675	
2803	
2777	n=0, m=0
2789	m=0
585	
2804	k % 2 = 1
2788	m>0
334	n=0,m=0
2791	
2790	k % 2 = 1
336	n=0,m=0
2792	
2793	k % 2 = 1
2805	k % 2 = 1
2806	n>0
409	
2796	k % 2 = 1
2807	
2808	n>0
433	  n>0
2809	
2810	
736	k % 2 = 1
2811	
2812	
761	  n==0 and m==1  
784	m==1,n=0
785	
2814	
807	n=2,m=0
2815	k odd
2797	
2798	k % 2 = 1
2563	m>0
2795	n=0, m=0, k=0
2820	
2817	k<m
2821	
2839	n=0
2775	m=0,n=0
2800	
825	k odd
730	k % 2 = 0
2822	k odd
2823	k odd
2818	n=0
2819	n>0
2840	
2837	n=0,m=0
2824	
2825	
2826	
2827	
2828	
2829	
2830	
2831	
2725	m=0
2844	n=0
866	
2735	m=0
2845	n>0
2833	n=0,m=0
2834	n=0,m>0
2835	
2841	
2736	
2846	m=0
2737	m>1, n>0
2842	
2843	
2847	
2848	m=0
2849	
2850	
2851	
2852	m=0
2853	m>0
2854	m>0
2855	m=0
2856	
2794	
2858	n=0
2859	m=0
2860	
538	n<2*k
2717	n=0
2862	n=0,m=0
2863	m=0
2866	n=0
2867	
2868	m<k
2870	m=0
2871	n>0,m>0
2872	n=0
2873	n>0,m>0
934	  m=0  
2874	
2875	
2876	
2877	m=0
2878	n=0
2879	n>0,m>0
2880	m=0
2881	m>0
2882	
2883	m=0
2884	m>0,n>0
2885	n=0
2886	m=0
2887	n>0,m>0
2888	
1001	
2889	n=0
2890	m=0
2891	n>0,m>0
2892	
2893	
2894	n=0
2895	
2896	
2898	n<k
2899	
1030	 m=0
1029	
1036	 n==0,m=0
1037	 m==0,n=0
1033	n=0,m=0
1040	
1042	n=0,m=0
2901	n>0,m>0
3034	
2900	n=0
2903	n=0,m=0
2904	m>0,n=0
2905	m>0,n>0
2907	
2909	
2911	
2913	
2915	
2917	
2919	
2921	
2923	
2925	
2927	
1044	 n<k
2928	
1047	n>0
1046	n=0
2932	
2930	n=0
2933	
1051	m=0, n = 0
2934	n=0
2935	n>0
1053	n=0
2936	n>0
1055	n<k
2937	
1057	m=0,n=0
2938	n=0
2939	n>0
2941	
2943	
1066	n=0
2944	n>0
1068	n<k
2945	
1070	m=0, n = 0
1071	n=0
1073	  n =0,m=0
1074	  m == 0  ,n=0
2947	n=0
2948	n>0
1077	n<k
2949	
1079	m=0 and n = 0
1729	
2951	n=0
2950	n>0
1081	m=0 and n = 0
3036	
3038	
2952	n=0
2953	n>0
1083	n<k
1084	 m=0
1085	m>0 
2864	n=0
3040	
3042	
3044	
3046	
3048	
3050	
2955	n=0 
2956	n>0
2958	n<k
2959	m=0
2960	
2715	m=0 and n = 0
2716	n>0
2964	
2962	n=0
2965	n>0
2966	
2967	
2968	
2969	
2970	
2971	
2972	
2973	
2974	
2975	
2976	
2978	n=0
2979	n>0
2981	n=0
2982	n>0
2984	n=0
2985	n>0
2987	n=0
2988	n>0
2990	n=0
2991	n>0
2993	
2995	
2997	n=0
2998	n>0
3000	
3002	
3004	
3006	
3008	
3010	
3012	
3014	
3016	
3018	
3020	
3022	
3024	
3026	
3028	
3030	
3032	
3052	
3054	
3056	
3058	
3060	
1342	n==0
3062	n>0
3070	n=0
3063	n>m
1109	n>0,m>0
1116	m=0,n=0
3066	m=0
3067	
1089	m=0
1088	  m>0
3068	m=0
3069	
1096	m=0 and n = 0
1095	
1131	m=0
1145	m=0
3071	n>0
3073	m=0 
3074	m>0
3075	m>0
3076	m>0
1545	n > 0
3079	m=0 
3080	m>0
3082	m=0 
3083	m>0
3085	m=0 
3086	m>0
3088	m=0 
3089	m>0
3091	m=0
3092	m>0
3093	n > 0
3094	n > 0
3095	n>0
3097	n>0
3096	n>0
3098	n>0
1112	m=0
3065	n>0,m>0
1111	n<k
3077	m=0 
1367	n>=0
3099	n>0
3101	
3103	
3105	
3107	
3109	
3111	
3113	
3115	
3117	
3119	
3121	
3123	
3127	k even
3128	k odd, n>k
3129	k odd, n<k
3131	n+k%2=0
3132	n+k%2=1
3135	k even
3136	k odd
3134	n=0, m=0, k=0
3138	n=0 , m ,  k=0
3139	k even
3140	k odd
3142	
3144	
3145	
3147	n=0, m, k=0
3148	k even
3149	k odd
3151	n=0 , m=0, k=0
3152	k even
3153	k odd
3156	k even
3157	k odd
3155	n=0,m=0,k=0
3159	
3161	
3163	
3165	
3167	
3169	
3171	
3173	
1103	m=0
1104	m=0,n=0
1113	n>0,m>0
1114	
1121	
1120	  n=0,m=0
3179	k % 2 = 0
3180	k % 2 = 1
3182	k % 2 = 0
3183	k % 2 = 1
3185	k % 2 = 0
3186	k % 2 = 1
3187	k % 2 = 1
3198	
3197	m=0,n=0
3200	
3202	
3203	n > 0
3204	
3205	
3207	
3209	
3211	
3213	
3216	k even
3215	k odd
3218	k even
3219	k odd
3221	k even
3222	k odd
3223	
3224	k even
3225	k odd
3226	
3227	
3228	
3229	
3231	
3233	
3234	
3236	
3237	
3238	k % 2 = 1, n>k
3239	k % 2 = 1, n<k
3240	n=0
3241	n=0
3242	
3125	n=0,m=0
3243	
3175	n=0,m=0
3244	
3177	n=0,m=0
3245	
3189	n=0,m=0
3246	
3191	n=0,m=0
3247	
3193	n=0,m=0
3248	
3251	n>0, m>0
3249	2*n-k==0, m==0
3250	2*n-k==0, m>0
1125	
1150	
3252	
3256	m=0,n=0
3257	m=0,n>0
3258	m>0,n>0
3259	m=0
3260	m=0,n=0
3261	m = 0,n > 0
3262	n = 0,m > 0
3263	n > 0,m > 0
1087	  m>0
3264	n>0,m>0
3267	m=0,n=0
\.


--
-- Data for Name: formula; Type: TABLE DATA; Schema: public; Owner: prog
--

COPY public.formula (id, function_name, expression, pyramid_id, type) FROM stdin;
2	T	delta(k, n+m) * binomial(n+m, m)	1	explicitformula
3	U	x * (y + 1)	2	generatingfunction
4	T	delta(k, n) * binomial(n, m)	2	explicitformula
5	U	y* ( x+1)	3	generatingfunction
6	T	delta(k, m) * binomial(m, n)	3	explicitformula
7	U	x+y/(1-x)	4	generatingfunction
8	T	binomial(k,m)*binomial(n+2*m-k-1,n+m-k)	4	explicitformula
9	U	x / (1 - y) + y	5	generatingfunction
10	T	binomial(k,n)*binomial(2*n+m-k-1,n+m-k)	5	explicitformula
11	U	((x*((-2*y)-sqrt(1-4*y)+1)**2) / (4*y**4)+1)**3	6	generatingfunction
12	T	(2*binomial(3*k,n) * n * binomial(4*n+2*m,m)) / (2*n+m)	6	explicitformula
13	U	(4*y**2)/((1-sqrt(1-4*y))**2*(1-(x*(1-sqrt(1-4*y))) /(2*y)))	7	generatingfunction
14	T	binomial(n+k-1,n)	7	explicitformula
15	T	binomial(n+k-1 ,n)*(n-2*k)*binomial(2*m+n-2*k-1,m-1)/m	7	explicitformula
16	U	(x+1)*(y+1)^3	8	generatingfunction
17	T	binomial(k,n)*binomial(3*k,m)	8	explicitformula
18	U	((x*((-2*y)-sqrt(1-4*y)+1)**3)/(8*y**6)+1)**3	9	generatingfunction
19	T	(3*binomial(3*k, n) *n * binomial(6*n+2*m,m)) / (3*n+m)	9	explicitformula
20	U	(x+1)/(1-y)**3	10	generatingfunction
21	T	binomial(k,n)*binomial(m+3*k-1,m)	10	explicitformula
22	U	 ((x+1)*(1-sqrt(1-4*y))**3)/(8*y**3)	11	generatingfunction
23	T	(3*k*binomial(k,n)*binomial(2*m+3*k-1,m))/(m+3*k)	11	explicitformula
24	U	 ((1+x)*(1-sqrt(1-4*y)-2*y)^2)/(4*y^4)	12	generatingfunction
25	T	 (2*k*binomial(k,n)*binomial(2*m+4*k,m))/(m+2*k)	12	explicitformula
26	U	((-2*y)-sqrt(1-4*y)+1)**2/(4*(1-(x*((-2*y)-sqrt(1-4*y)+1)**2)/(4*y**4))**2*y**4)	13	generatingfunction
27	T	(2*(n+k)*binomial(n+2*k-1,n)*binomial(4*(n+k)+2*m,m))/(2*(n+k)+m)	13	explicitformula
28	U	((1+x)*(1-sqrt(1-4*y)-2*y)**3)/(8*y**6)	14	generatingfunction
29	T	 (3*k*binomial(k,n)*binomial(2*m+6*k,m))/(m+3*k)	14	explicitformula
30	U	((-2*y)-sqrt(1-4*y)+1)**3/(8*(1-(x*((-2*y)-sqrt(1- 4*y)+1)**3)/(8*y**6))**2*y**6)	15	generatingfunction
31	T	(3*(n+k)*binomial(n+2*k-1,n)*binomial(6*(n+k)+2*m ,m))/(3*(n+k)+m)	15	explicitformula
32	U	(1+x)**2*(1+y)**2	16	generatingfunction
33	T	binomial(2*k,m)*binomial(2*k,n)	16	explicitformula
34	U	 (1+x)^2*(1+y)^3	17	generatingfunction
35	T	binomial(2*k,n)*binomial(3*k,m)	17	explicitformula
36	U	(1+x)**2/(1-y)**2	18	generatingfunction
37	T	 binomial(2*k,n)*binomial(m+2*k-1,m)	18	explicitformula
38	U	1/(1-x/(1-y)**3)	19	generatingfunction
39	T	binomial(n+k-1,n)*binomial(3*n+m-1,m)	19	explicitformula
40	U	(1+x)**2/(1-y)**3	20	generatingfunction
41	T	binomial(2*k,n)*binomial(m+3*k-1,m)	20	explicitformula
42	U	((x+1)**2*(1-sqrt(1-4*y)))/(2*y)	21	generatingfunction
43	T	 (k*binomial(2*k,n)*binomial(2*m+k-1,m))/(m+k)	21	explicitformula
44	U	 ((1+x)**2*(1-sqrt(1-4*y))**2)/(4*y**2)	22	generatingfunction
45	T	 (2*k*binomial(2*k,n)*binomial(2*m+2*k-1,m))/(m+2* k)	22	explicitformula
46	U	((x+1)**2*(1-sqrt(1-4*y))**3)/(8*y**3)	23	generatingfunction
47	T	 (3*k*binomial(2*k,n)*binomial(2*m+3*k-1,m))/(m+3* k)	23	explicitformula
48	U	((1+x)**2*((-2*y)-sqrt(1-4*y)+1)**2)/(4*y**4)	24	generatingfunction
49	T	 (2*k*binomial(2*k,n)*binomial(2*m+4*k,m))/(m+2*k)	24	explicitformula
50	U	(y+1)**3/(1-x*(y+1)**3)**3	25	generatingfunction
51	T	binomial(3*(n+k),m)*binomial(n+3*k-1,n)	25	explicitformula
52	U	1/((1-x/(1-y))**3*(1-y))	26	generatingfunction
53	T	binomial(n+3*k-1,n)*binomial(n+m+k-1,m)	26	explicitformula
54	U	1/((1-x/(1-y)**2)**3*(1-y)**2)	27	generatingfunction
55	T	binomial(n+3*k-1,n)*binomial(2*(n+k)+m-1,m)	27	explicitformula
56	U	((1-x/(1-y)**3)**3*(1-y)**3)	28	generatingfunction
57	T	binomial(n+3*k-1,n)*binomial(3*(n+k)+m-1,m)	28	explicitformula
58	U	 (y+1)**3*sqrt(4*x**2*(y+1)**6+1)+2*x*(y+1)**6	29	generatingfunction
59	T	((k*binomial(n+(n+k)/2,n)*binomial(2*n+n+k,n+(n+k)/2))/(binomial(n+k,(n+k)/2)*(n+k)))*binomial(3*n+3*k,m)	29	explicitformula
60	T	((k*binomial(n+(n+k+1)/2,n)*binomial(2*n+n+k+1,n+(n+k+1)/2))/(binomial(n+k+1,(n+k+1)/2)*(n+k)))*binomial(3*n+3*k,m)	29	explicitformula
61	U	(1-sqrt(1-4*y))/(2*(1-(x*(1-sqrt(1-4*y)))/(2*y))** 3*y)	30	generatingfunction
62	T	((n+k)*binomial(n+3*k-1,n)*binomial(n+2*m+k-1,m)) /(n+m+k)	30	explicitformula
63	U	(1-sqrt(1-4*y))**2/(4*(1-(x*(1-sqrt(1-4*y))**2)/(4* y**2))**3*y**2)	31	generatingfunction
64	T	(2*(n+k)*binomial(n+3*k-1,n)*binomial(2*(n+k)+2*m -1,m))/(2*(n+k)+m)	31	explicitformula
65	U	(1-sqrt(1-4*y))**3/(8*(1-(x*(1-sqrt(1-4*y))**3)/(8* y**3))**3*y**3)	32	generatingfunction
66	T	(3*(n+k)*binomial(n+3*k-1,n)*binomial(3*(n+k)+2*m -1,m))/(3*(n+k)+m)	32	explicitformula
67	U	((-2*y)-sqrt(1-4*y)+1)**2/(4*(1-(x*((-2*y)-sqrt(1- 4*y)+1)**2)/(4*y**4))**3*y**4)	33	generatingfunction
68	T	(2*(n+k)*binomial(n+3*k-1,n)*binomial(4*(n+k)+2*m ,m))/(2*(n+k)+m)	33	explicitformula
69	U	((-2*y)-sqrt(1-4*y)+1)**3/(8*(1-(x*((-2*y)-sqrt(1- 4*y)+1)**3)/(8*y**6))**3*y**6)	34	generatingfunction
70	T	(3*(n+k)*binomial(n+3*k-1,n)*binomial(6*(n+k)+2*m ,m))/(3*(n+k)+m)	34	explicitformula
71	U	(1-sqrt(1-(4*x)/(1-y)**3))/(2*x)	35	generatingfunction
200	T	 binomial(3*k,n)*binomial(m+k-1,m)	99	explicitformula
72	T	(k*binomial(2*n+k-1,n)*binomial(3*(n+k)+m-1,m))/( n+k)	35	explicitformula
73	U	(1-sqrt(1-(x*(1-sqrt(1-4*y))**3)/(2*y**3)))/(2*x)	36	generatingfunction
522	U	sqrt(4*x*y+4*x**2+1)+y+2*x	245	generatingfunction
74	T	(3*k*binomial(2*n+k-1,n)*binomial(3*(n+k)+2*m-1,m ))/(3*(n+k)+m)	36	explicitformula
75	U	(1-sqrt(1-(x*((-2*y)-sqrt(1-4*y)+1)**2)/y**4))/(2*x)	37	generatingfunction
76	T	(2*k*binomial(2*n+k-1,n)*binomial(4*(n+k)+2*m,m)) /(2*(n+k)+m)	37	explicitformula
77	U	(1-sqrt(1-(x*((-2*y)-sqrt(1-4*y)+1)**3)/(2*y**6)))/ (2*x)	38	generatingfunction
78	T	(3*k*binomial(2*n+k-1,n)*binomial(6*(n+k)+2*m,m)) /(3*(n+k)+m)	38	explicitformula
79	U	(1-sqrt(1-4*x*(y+1)**3))**2/(4*x**2*(y+1)**3)	39	generatingfunction
80	T	(2*k*binomial(3*(n+k),m)*binomial(2*n+2*k-1,n))/( n+2*k)	39	explicitformula
81	U	((1-sqrt(1-(4*x)/(1-y)**3))**2*(1-y)**3)/(4*x**2)	40	generatingfunction
82	T	(2*k*binomial(2*n+2*k-1,n)*binomial(3*(n+k)+m-1,m ))/(n+2*k)	40	explicitformula
83	U	((1-sqrt(1-(x*(1-sqrt(1-4*y))**2)/y**2))**2*y**2)/(x** 2*(1-sqrt(1-4*y))**2)	41	generatingfunction
84	T	(4*k*(n+k)*binomial(2*n+2*k-1,n)*binomial(2*(n+k) +2*m-1,m))/((n+2*k)*(2*(n+k)+m))	41	explicitformula
85	U	(2*(1-sqrt(1-(x*(1-sqrt(1-4*y))**3)/(2*y**3)))**2*y** 3)/(x**2*(1-sqrt(1-4*y))**3)	42	generatingfunction
86	T	(6*k*(n+k)*binomial(2*n+2*k-1,n)*binomial(3*(n+k) +2*m-1,m))/((n+2*k)*(3*(n+k)+m))	42	explicitformula
87	U	((1-sqrt(1-(x*((-2*y)-sqrt(1-4*y)+1)**2)/y**4))**2*y **4)/(x**2*((-2*y)-sqrt(1-4*y)+1)**2)	43	generatingfunction
88	T	(4*k*(n+k)*binomial(2*n+2*k-1,n)*binomial(4*(n+k) +2*m,m))/((n+2*k)*(2*(n+k)+m))	43	explicitformula
89	U	(2*(1-sqrt(1-(x*((-2*y)-sqrt(1-4*y)+1)**3)/(2*y**6) ))**2*y**6)/(x**2*((-2*y)-sqrt(1-4*y)+1)**3)	44	generatingfunction
90	T	(6*k*(n+k)*binomial(2*n+2*k-1,n)*binomial(6*(n+k) +2*m,m))/((n+2*k)*(3*(n+k)+m))	44	explicitformula
91	U	(1-sqrt(1-4*x*(y+1)**3))**3/(8*x**3*(y+1)**6)	45	generatingfunction
92	T	(3*k*binomial(3*(n+k),m)*binomial(2*n+3*k-1,n))/( n+3*k)	45	explicitformula
93	U	((1-sqrt(1-(4*x)/(1-y)**3))**3*(1-y)**6)/(8*x**3)	46	generatingfunction
94	T	(3*k*binomial(2*n+3*k-1,n)*binomial(3*(n+k)+m-1,m ))/(n+3*k)	46	explicitformula
95	U	(8*(1-sqrt(1-(x*(1-sqrt(1-4*y))**3)/(2*y**3)))**3*y** 6)/(x**3*(1-sqrt(1-4*y))**6)	47	generatingfunction
96	T	(9*k*(n+k)*binomial(2*n+3*k-1,n)*binomial(3*(n+k) +2*m-1,m))/((n+3*k)*(3*(n+k)+m))	47	explicitformula
97	U	(2*(1-sqrt(1-(x*((-2*y)-sqrt(1-4*y)+1)**2)/y**4))**3 *y**8)/(x**3*((-2*y)-sqrt(1-4*y)+1)**4)	48	generatingfunction
98	T	(6*k*(n+k)*binomial(2*n+3*k-1,n)*binomial(4*(n+k) +2*m,m))/((n+3*k)*(2*(n+k)+m))	48	explicitformula
99	U	(8*(1-sqrt(1-(x*((-2*y)-sqrt(1-4*y)+1)**3)/(2*y**6) ))**3*y**12)/(x**3*((-2*y)-sqrt(1-4*y)+1)**6)	49	generatingfunction
100	T	(9*k*(n+k)*binomial(2*n+3*k-1,n)*binomial(6*(n+k) +2*m,m))/((n+3*k)*(3*(n+k)+m))	49	explicitformula
101	U	((-sqrt(1-4*x*(y+1)**2))-2*x*(y+1)**2+1)**2/(4*x**4*( y+1)**6)	50	generatingfunction
102	T	(2*k*binomial(2*(n+k),m)*binomial(2*n+4*k,n))/(n+ 2*k)	50	explicitformula
103	U	((-sqrt(1-4*x*(y+1)**3))-2*x*(y+1)**3+1)**2/(4*x**4*( y+1)**9)	51	generatingfunction
104	T	(2*k*binomial(3*(n+k),m)*binomial(2*n+4*k,n))/(n+ 2*k)	51	explicitformula
105	U	(((-(2*x)/(1-y))-sqrt(1-(4*x)/(1-y))+1)**2*(1-y)**3 )/(4*x**4)	52	generatingfunction
106	T	(2*k*binomial(n+m+k-1,m)*binomial(2*n+4*k,n))/(n+ 2*k)	52	explicitformula
107	U	(((-(2*x)/(1-y)**2)-sqrt(1-(4*x)/(1-y)**2)+1)**2*(1- y)**6)/(4*x**4)	53	generatingfunction
108	T	(2*k*binomial(2*n+4*k,n)*binomial(2*(n+k)+m-1,m)) /(n+2*k)	53	explicitformula
109	U	(((-(2*x)/(1-y)**3)-sqrt(1-(4*x)/(1-y)**3)+1)**2*(1- y)**9)/(4*x**4)	54	generatingfunction
110	T	(2*k*binomial(2*n+4*k,n)*binomial(3*(n+k)+m-1,m)) /(n+2*k)	54	explicitformula
111	U	(2*((-(x*(1-sqrt(1-4*y)))/y)-sqrt(1-(2*x*(1-sqrt( 1-4*y)))/y)+1)**2*y**3)/(x**4*(1-sqrt(1-4*y))**3)	55	generatingfunction
112	T	(2*k*(n+k)*binomial(n+2*m+k-1,m)*binomial(2*n+4*k ,n))/((n+2*k)*(n+m+k))	55	explicitformula
113	U	(16*((-(x*(1-sqrt(1-4*y))**2)/(2*y**2))-sqrt(1-(x*( 1-sqrt(1-4*y))**2)/y**2)+1)**2*y**6)/(x**4*(1-sqrt(1-4 *y))**6)	56	generatingfunction
114	T	(4*k*(n+k)*binomial(2*n+4*k,n)*binomial(2*(n+k)+2 *m-1,m))/((n+2*k)*(2*(n+k)+m))	56	explicitformula
115	U	(128*((-(x*(1-sqrt(1-4*y))**3)/(4*y**3))-sqrt(1-(x*(1-sqrt(1-4*y))**3)/(2*y**3))+1)**2*y**9)/(x**4*(1-sqrt(1-4*y))**9)	57	generatingfunction
116	T	(6*k*(n+k)*binomial(2*n+4*k,n)*binomial(3*(n+k)+2 *m-1,m))/((n+2*k)*(3*(n+k)+m))	57	explicitformula
117	U	(16*((-(x*((-2*y)-sqrt(1-4*y)+1)**2)/(2*y**4))-sqrt (1-(x*((-2*y)-sqrt(1-4*y)+1)**2)/y**4)+1)**2*y**12)/( x**4*((-2*y)-sqrt(1-4*y)+1)**6)	58	generatingfunction
118	T	(4*k*(n+k)*binomial(2*n+4*k,n)*binomial(4*(n+k)+2 *m,m))/((n+2*k)*(2*(n+k)+m))	58	explicitformula
119	U	(128*((-(x*((-2*y)-sqrt(1-4*y)+1)**3)/(4*y**6))-sqrt(1-(x*((-2*y)-sqrt(1-4*y)+1)**3)/(2*y**6))+1)**2*y**18)/(x**4*((-2*y)-sqrt(1-4*y)+1)**9)	59	generatingfunction
120	T	(6*k*(n+k)*binomial(2*n+4*k,n)*binomial(6*(n+k)+2 *m,m))/((n+2*k)*(3*(n+k)+m))	59	explicitformula
121	U	((-sqrt(1-4*x*(y+1)))-2*x*(y+1)+1)**3/(8*x**6*(y+1) **5)	60	generatingfunction
122	T	(3*k*binomial(n+k,m)*binomial(2*n+6*k,n))/(n+3*k)	60	explicitformula
123	U	((-sqrt(1-4*x*(y+1)**2))-2*x*(y+1)**2+1)**3/(8*x**6*( y+1)**10)	61	generatingfunction
124	T	(3*k*binomial(2*(n+k),m)*binomial(2*n+6*k,n))/(n+ 3*k)	61	explicitformula
125	U	((-sqrt(1-4*x*(y+1)**3))-2*x*(y+1)**3+1)**3/(8*x**6*( y+1)**15)	62	generatingfunction
126	T	(3*k*binomial(3*(n+k),m)*binomial(2*n+6*k,n))/(n+ 3*k)	62	explicitformula
127	U	(((-(2*x)/(1-y))-sqrt(1-(4*x)/(1-y))+1)**3*(1-y)**5 )/(8*x**6)	63	generatingfunction
128	T	(3*k*binomial(n+m+k-1,m)*binomial(2*n+6*k,n))/(n+ 3*k)	63	explicitformula
129	U	(((-(2*x)/(1-y)**2)-sqrt(1-(4*x)/(1-y)**2)+1)**3*(1- y)**10)/(8*x**6)	64	generatingfunction
130	T	(3*k*binomial(2*n+6*k,n)*binomial(2*(n+k)+m-1,m)) /(n+3*k)	64	explicitformula
131	U	(((-(2*x)/(1-y)**3)-sqrt(1-(4*x)/(1-y)**3)+1)**3*(1- y)**15)/(8*x**6)	65	generatingfunction
132	T	(3*k*binomial(2*n+6*k,n)*binomial(3*(n+k)+m-1,m)) /(n+3*k)	65	explicitformula
133	U	(4*((-(x*(1-sqrt(1-4*y)))/y)-sqrt(1-(2*x*(1-sqrt( 1-4*y)))/y)+1)**3*y**5)/(x**6*(1-sqrt(1-4*y))**5)	66	generatingfunction
134	T	(3*k*(n+k)*binomial(n+2*m+k-1,m)*binomial(2*n+6*k ,n))/((n+3*k)*(n+m+k))	66	explicitformula
135	U	(128*((-(x*(1-sqrt(1-4*y))**2)/(2*y**2))-sqrt(1-(x* (1-sqrt(1-4*y))**2)/y**2)+1)**3*y**10)/(x**6*(1-sqrt(1 -4*y))*10)	67	generatingfunction
136	T	(6*k*(n+k)*binomial(2*n+6*k,n)*binomial(2*(n+k)+2 *m-1,m))/((n+3*k)*(2*(n+k)+m))	67	explicitformula
137	U	(4096*((-(x*(1-sqrt(1-4*y))**3)/(4*y**3))-sqrt(1-(x *(1-sqrt(1-4*y))**3)/(2*y**3))+1)**3*y**15)/(x**6*(1-sqrt(1-4*y))**15)	68	generatingfunction
138	T	(9*k*(n+k)*binomial(2*n+6*k,n)*binomial(3*(n+k)+2 *m-1,m))/((n+3*k)*(3*(n+k)+m))	68	explicitformula
139	U	(128*((-(x*((-2*y)-sqrt(1-4*y)+1)**2)/(2*y**4))-sqrt(1-(x*((-2*y)-sqrt(1-4*y)+1)**2)/y**4)+1)**3*y**20)/ (x**6*((-2*y)-sqrt(1-4*y)+1)**10)	69	generatingfunction
140	T	(6*k*(n+k)*binomial(2*n+6*k,n)*binomial(4*(n+k)+2 *m,m))/((n+3*k)*(2*(n+k)+m))	69	explicitformula
141	U	(4096*((-(x*((-2*y)-sqrt(1-4*y)+1)**3)/(4*y**6))-sqrt(1-(x*((-2*y)-sqrt(1-4*y)+1)**3)/(2*y**6))+1)**3*y **30)/(x**6*((-2*y)-sqrt(1-4*y)+1)**15)	70	generatingfunction
142	T	(9*k*(n+k)*binomial(2*n+6*k,n)*binomial(6*(n+k)+2 *m,m))/((n+3*k)*(3*(n+k)+m))	70	explicitformula
143	U	(y+1)**5/((-x*y)-x+1)	71	generatingfunction
144	T	binomial(n+k-1,n)*binomial(n+5*k,m)	71	explicitformula
145	U	(1-sqrt((-4*x*y**6)-24*x*y**5-60*x*y**4-80*x*y**3-60* x*y**2-24*x*y-4*x+1))/(2*x*y+2*x)	72	generatingfunction
146	T	(k*binomial(2*n+k-1,n)*binomial(6*n+5*k,m))/(n+k)	72	explicitformula
147	U	(y**2+y)**2+x*y**2+x*y	73	generatingfunction
148	T	binomial(k,n)*binomial(2*k-n,n+m-2*k)	73	explicitformula
149	U	x/(1-y)+1/(1-y)**2	74	generatingfunction
150	T	binomial(k,n)*binomial((-n)+m+2*k-1,m)	74	explicitformula
151	U	1/(1-y)**3+x	75	generatingfunction
152	T	binomial(k,n)*binomial((-3*n)+m+3*k-1,m)	75	explicitformula
153	U	1/(1-y)**4+x	76	generatingfunction
154	T	binomial(k,n)*binomial((-4*n)+m+4*k-1,m)	76	explicitformula
155	U	1/(1-y)**5+x	77	generatingfunction
156	T	binomial(k,n)*binomial((-5*n)+m+5*k-1,m)	77	explicitformula
157	U	x/(1-y)+1/(1-y)**5	78	generatingfunction
158	T	binomial(k,n)*binomial((-4*n)+m+5*k-1,m)	78	explicitformula
159	U	x/(1-y)**2+1/(1-y)**4	79	generatingfunction
160	T	binomial(k,n)*binomial((-2*n)+m+4*k-1,m)	79	explicitformula
161	U	(y+1)**5+x	80	generatingfunction
162	T	binomial(k,n)*binomial(5*k-5*n,m)	80	explicitformula
163	U	(y+1)**3+x	81	generatingfunction
164	T	binomial(k,n)*binomial(3*k-3*n,m)	81	explicitformula
165	U	(1-sqrt((-4*x*y**3)-12*x*y**2-12*x*y-4*x+1))/(2*x)	82	generatingfunction
166	T	(k*binomial(2*n+k,n)*binomial(3*n+3*k,m))/(2*n+k)	82	explicitformula
167	U	(y+1)**4+x	83	generatingfunction
168	T	binomial(k,n)*binomial(4*k-4*n,m)	83	explicitformula
169	U	(y+1)**4/(1-x)	84	generatingfunction
170	T	binomial(4*k,m)*binomial(n+k-1,n)	84	explicitformula
171	U	(1-sqrt((-4*x*y**4)-16*x*y**3-24*x*y**2-16*x*y-4*x+1 ))/(2*x)	85	generatingfunction
172	T	(k*binomial(4*(n+k),m)*binomial(2*n+k-1,n))/(n+k)	85	explicitformula
173	U	(y+1)*5/(1-x)	86	generatingfunction
174	T	binomial(5*k,m)*binomial(n+k-1,n)	86	explicitformula
175	U	(1-sqrt((-4*x*y**5)-20*x*y**4-40*x*y**3-40*x*y**2-20* x*y-4*x+1))/(2*x)	87	generatingfunction
176	T	(k*binomial(5*(n+k),m)*binomial(2*n+k-1,n))/(n+k)	87	explicitformula
177	U	x*(y+1)**4+1	88	generatingfunction
178	T	binomial(k,n)*binomial(4*n,m)	88	explicitformula
179	U	1/(1-x*(y+1)**4)	89	generatingfunction
180	T	binomial(4*n,m)*binomial(n+k-1,n)	89	explicitformula
181	U	(1-sqrt(1-4*x*(y+1)**4))/(2*x*(y+1)**4)	90	generatingfunction
182	T	(k*binomial(4*n,m)*binomial(2*n+k-1,n))/(n+k)	90	explicitformula
183	U	x**2/(1-4*y)+1	91	generatingfunction
184	T	(binomial(k,n/2)*4**m*binomial(n/2+m-1,m)*((-1)**n+ 1))/2	91	explicitformula
185	U	1/(1-4*y)**(3/2)+x	92	generatingfunction
186	T	binomial(k,n)*4**m*binomial((3*(k-n))/2+m-1,m)	92	explicitformula
187	U	1/((1-x)*(1-4*y)**(3/2))	93	generatingfunction
188	T	4**m*binomial(m+(3*k)/2-1,m)*binomial(n+k-1,n)	93	explicitformula
189	U	(1-sqrt(1-4*y))**3/(8*y**3)+x	94	generatingfunction
190	T	(3*binomial(k-1,n)*k*binomial((-3*n)+2*m+3*k-1,m- 1))/m	94	explicitformula
191	U	((1+x)**2*(1-2*y-sqrt(1-4*y))**3)/(8*y**6)	95	generatingfunction
192	T	 (3*k*binomial(2*k,n)*binomial(2*m+6*k,m))/(m+3*k)	95	explicitformula
193	U	(1+x)^3*(1+y)	96	generatingfunction
194	T	binomial(k,m)*binomial(3*k,n)	96	explicitformula
195	U	(1+x)**3*(1+y)**2	97	generatingfunction
196	T	 binomial(2*k,m)*binomial(3*k,n)	97	explicitformula
197	U	 (1+x)**3*(1+y)**3	98	generatingfunction
198	T	binomial(3*k,m)*binomial(3*k,n)	98	explicitformula
199	U	(1+x)**3/(1-y)	99	generatingfunction
201	U	(1+x)**3/(1-y)**2	100	generatingfunction
202	T	 binomial(3*k,n)*binomial(m+2*k-1,m)	100	explicitformula
203	U	(1+x)**3/(1-y)**3	101	generatingfunction
204	T	 binomial(3*k,n)*binomial(m+3*k-1,m)	101	explicitformula
205	U	((1+x)**3*(1-sqrt(1-4*y)))/(2*y)	102	generatingfunction
206	T	 (k*binomial(3*k,n)*binomial(2*m+k-1,m))/(m+k)	102	explicitformula
207	U	 ((1+x)**3*(1-sqrt(1-4*y))**2)/(4*y**2)	103	generatingfunction
208	T	(2*k*binomial(3*k,n)*binomial(2*m+2*k-1,m))/(m+2*k)	103	explicitformula
3151	T	1	1285	explicitformula
209	U	((1+x)**3*(1-sqrt(1-4*y))**3)/(8*y**3)	104	generatingfunction
210	T	(3*k*binomial(3*k,n)*binomial(2*m+3*k-1,m))/(m+3*k)	104	explicitformula
211	U	((1+x)**3*(1-2*y-sqrt(1-4*y))**2)/(4*y**4)	105	generatingfunction
212	T	 (2*k*binomial(3*k,n)*binomial(2*m+4*k,m))/(m+2*k)	105	explicitformula
213	U	((1+x)**3*(1-sqrt(1-4*y)-2*y)**3)/(8*y**6)	106	generatingfunction
214	T	 (3*k*binomial(3*k,n)*binomial(2*m+6*k,m))/(m+3*k)	106	explicitformula
215	U	 (1+y)**3/(1-x)	107	generatingfunction
216	T	binomial(3*k,m)*binomial(n+k-1,n)	107	explicitformula
217	U	1/((1-x)*(1-y)**3)	108	generatingfunction
218	T	 binomial(m+3*k-1,m)*binomial(n+k-1,n)	108	explicitformula
219	U	(1-sqrt(1-4*y))**3/(8*(1-x)*y**3)	109	generatingfunction
220	T	(3*k*binomial(2*m+3*k-1,m)*binomial(n+k-1,n))/(m+ 3*k)	109	explicitformula
221	U	(1-sqrt(1-4*y)-2*y)**2/(4*(1-x)*y**4)	110	generatingfunction
222	T	(2*k*binomial(2*m+4*k,m)*binomial(n+k-1,n))/(m+2* k)	110	explicitformula
223	U	 (1-sqrt(1-4*y)-2*y)**3/(8*(1-x)*y**6)	111	generatingfunction
224	T	 (3*k*binomial(2*m+6*k,m)*binomial(n+k-1,n))/(m+3* k)	111	explicitformula
225	U	(1+y)**3/(1-x)**2	112	generatingfunction
226	T	 binomial(3*k,m)*binomial(n+2*k-1,n)	112	explicitformula
227	U	(1-sqrt(1-4*y))**2/(4*(1-x)**2*y**2)	113	generatingfunction
228	T	(2*k*binomial(2*m+2*k-1,m)*binomial(n+2*k-1,n))/( m+2*k)	113	explicitformula
229	U	(1-sqrt(1-4*y))**3/(8*(1-x)**2*y**3)	114	generatingfunction
230	T	(3*k*binomial(2*m+3*k-1,m)*binomial(n+2*k-1,n))/( m+3*k)	114	explicitformula
231	U	(1-sqrt(1-4*y)-2*y)**2/(4*(1-x)**2*y**4)	115	generatingfunction
232	T	(2*k*binomial(2*m+4*k,m)*binomial(n+2*k-1,n))/(m+ 2*k)	115	explicitformula
233	U	 (1-sqrt(1-4*y)-2*y)**3/(8*(1-x)**2*y**6)	116	generatingfunction
234	T	 (3*k*binomial(2*m+6*k,m)*binomial(n+2*k-1,n))/(m+3*k)	116	explicitformula
235	U	 (1+y)/(1-x)**3	117	generatingfunction
236	T	binomial(k,m)*binomial(n+3*k-1,n)	117	explicitformula
237	U	 (1+y)**2/(1-x)**3	118	generatingfunction
238	T	binomial(2*k,m)*binomial(n+3*k-1,n)	118	explicitformula
239	U	 (1+y)**3/(1-x)**3	119	generatingfunction
240	T	binomial(3*k,m)*binomial(n+3*k-1,n)	119	explicitformula
241	U	 1/((1-x)**3*(1-y))	120	generatingfunction
242	T	 binomial(m+k-1,m)*binomial(n+3*k-1,n)	120	explicitformula
243	U	 1/((1-x)**3*(1-y)**2)	121	generatingfunction
244	T	 binomial(m+2*k-1,m)*binomial(n+3*k-1,n)	121	explicitformula
245	U	 1/((1-x)**3*(1-y)**3)	122	generatingfunction
246	T	 binomial(m+3*k-1,m)*binomial(n+3*k-1,n)	122	explicitformula
247	U	 (1-sqrt(1-4*y))/(2*(1-x)**3*y)	123	generatingfunction
248	T	(k*binomial(2*m+k-1,m)*binomial(n+3*k-1,n))/(m+k)	123	explicitformula
249	U	(1-sqrt(1-4*y))**2/(4*(1-x)**3*y**2)	124	generatingfunction
250	T	(2*k*binomial(2*m+2*k-1,m)*binomial(n+3*k-1,n))/(m+2*k)	124	explicitformula
251	U	 (1-sqrt(1-4*y))**3/(8*(1-x)**3*y**3)	125	generatingfunction
252	T	 (3*k*binomial(2*m+3*k-1,m)*binomial(n+3*k-1,n))/( m+3*k)	125	explicitformula
253	U	 (1-sqrt(1-4*y)-2*y)**2/(4*(1-x)**3*y**4)	126	generatingfunction
254	T	 (2*k*binomial(2*m+4*k,m)*binomial(n+3*k-1,n))/(m+ 2*k)	126	explicitformula
255	U	(1-sqrt(1-4*y)-2*y)**3/(8*(1-x)**3*y**6)	127	generatingfunction
256	T	(3*k*binomial(2*m+6*k,m)*binomial(n+3*k-1,n))/(m+ 3*k)	127	explicitformula
257	U	 ((1-sqrt(1-4*x))*(y+1)**3)/(2*x)	128	generatingfunction
258	T	 (k*binomial(3*k,m)*binomial(2*n+k-1,n))/(n+k)	128	explicitformula
259	U	((1-sqrt(1-4*x))*(1-sqrt(1-4*y))**2)/(8*x*y**2)	129	generatingfunction
260	T	(2*k**2*binomial(2*m+2*k-1,m)*binomial(2*n+k-1,n)) /((m+2*k)*(n+k))	129	explicitformula
261	U	((1-sqrt(1-4*x))*(1-sqrt(1-4*y))**3)/(16*x*y**3)	130	generatingfunction
262	T	 (3*k**2*binomial(2*m+3*k-1,m)*binomial(2*n+k-1,n)) /((m+3*k)*(n+k))	130	explicitformula
263	U	x*y+y+x	131	generatingfunction
265	U	(x+1)*(y+x)	132	generatingfunction
267	U	(y+1)*(y+x)	133	generatingfunction
269	U	y+x**2+x	134	generatingfunction
271	U	(x+1)*(y+1)	135	generatingfunction
273	U	(x+1)/(1-(x+1)*y)	136	generatingfunction
275	U	(y+1)/((-x*y)-x+1)	137	generatingfunction
277	U	(1-sqrt(((-4*x**2)-8*x-4)*y+1))/((2*x+2)*y)	138	generatingfunction
279	U	((-sqrt(y**2+((-2*x)-2)*y+x**2-2*x+1))-y-x+1)/(2*x*y)	139	generatingfunction
281	U	1/((x+1)*(y+1))	140	generatingfunction
283	U	(1-sqrt((-4*x*y**2)-8*x*y-4*x+1))/(2*x*(y+1))	141	generatingfunction
285	U	(x+1)/(1-y)	142	generatingfunction
266	T	 binomial(k,m)*binomial(k,n+m-k)	132	explicitformula
270	T	binomial(k,m)*binomial(k-m,n+m-k)	134	explicitformula
268	T	binomial(k,n)*binomial(k,n+m-k)	133	explicitformula
272	T	 binomial(k,m)*binomial(k,n)	135	explicitformula
274	T	 (k*binomial(m+k,m)*binomial(m+k,n))/(m+k)	136	explicitformula
276	T	 (k*binomial(n+k,m)*binomial(n+k,n))/(n+k)	137	explicitformula
278	T	(k*binomial(2*m+k,m)*binomial(2*m+k,n))/(2*m+k)	138	explicitformula
280	T	 (k*binomial(n+m+k,m)*binomial(n+m+k,n))/(n+m+k)	139	explicitformula
282	T	 binomial(m+k-1,m)*(-1)^(n+m)*binomial(n+k-1,n)	140	explicitformula
284	T	(k*binomial(2*n+k,m)*binomial(2*n+k,n))/(2*n+k)	141	explicitformula
287	U	(1-sqrt(((-4*x)-4)*y+1))/(2*y)	143	generatingfunction
289	U	-1/(y+x-1)	144	generatingfunction
291	U	(1-sqrt(1-4*(y+x)))/(2*(y+x))	145	generatingfunction
293	U	((-sqrt((-4*y)+x**2-2*x+1))-x+1)/(2*y)	146	generatingfunction
295	U	((-sqrt(y**2-2*y-4*x+1))-y+1)/(2*x)	147	generatingfunction
297	U	(x+1)*(x*y+1)	148	generatingfunction
299	U	((-x)-1)/((x**2+x)*y-1)	149	generatingfunction
301	U	((-sqrt(x**2*y**2+((-2*x**2)-2*x)*y+x**2-2*x+1))-x*y-x+1)/(2*x**2*y)	150	generatingfunction
303	U	(1-sqrt(((-4*x**3)-8*x**2-4*x)*y+1))/(x*(2*x+2)*y)	151	generatingfunction
305	U	((-sqrt(1-4*(y+x)))-2*(y+x)+1)/(2*(y+x)**2)	152	generatingfunction
307	U	(x+1)/(1-x*y)	153	generatingfunction
309	U	(1-sqrt(((-4*x**2)-4*x)*y+1))/(2*x*y)	154	generatingfunction
311	U	((-sqrt((-4*x*y)+x**2-2*x+1))-x+1)/(2*x*y)	155	generatingfunction
313	U	y/(1-x)**3+1/(1-x)	156	generatingfunction
315	U	(1-x)**2/((1-x)**3-y)	157	generatingfunction
317	U	((x-1)*sqrt((-4*y)+x**4-4*x**3+6*x**2-4*x+1)-x**3+3*x**2-3*x+1)/(2*y)	158	generatingfunction
319	U	y+x+1	159	generatingfunction
321	U	(y+1)/(1-x)	160	generatingfunction
322	T	 1	160	explicitformula
324	U	(1-sqrt(x*((-4*y)-4)+1))/(2*x)	161	generatingfunction
325	T	( 1  )	161	explicitformula
327	U	x*y+x+1	162	generatingfunction
329	U	1/((-x*y)-x+1)	163	generatingfunction
331	U	(1-sqrt((-4*x*y)-4*x+1))/(x*(2*y+2))	164	generatingfunction
333	U	(sqrt(y**2+2*y+4*x+1)+y+1)/2	165	generatingfunction
335	U	(sqrt(4*y+x**2+2*x+1)+x+1)/2	166	generatingfunction
337	U	(y+1)**2/(1-x*(y+1))	167	generatingfunction
339	U	y+1/(1-x)	168	generatingfunction
341	U	1/((1-x)*(1-y))	169	generatingfunction
343	U	((-sqrt(x**2*y**2-2*x*y-4*x+1))+x*y+1)/(2*x)	170	generatingfunction
345	U	(sqrt((4*x-4)*y+x**2-2*x+1)+x-1)/(2*(x-1)*y)	171	generatingfunction
347	U	(sqrt(y**2+(4*x-2)*y-4*x+1)+y-1)/(2*x*(y-1))	172	generatingfunction
349	U	(x-1)/(y-(1-x)**2)	173	generatingfunction
352	U	((-sqrt((4*x-4)*y+x**4-4*x**3+6*x**2-4*x+1))+x**2-2*x+1)/(2*y)	174	generatingfunction
355	U	1/(1-y)+x	175	generatingfunction
357	U	((-sqrt(x**2*y**2+((-2*x)-4)*y+1))+x*y+1)/(2*y)	176	generatingfunction
359	U	(y-x+1)/(1-x)**2	177	generatingfunction
361	U	((-sqrt(4*y+1))-1)/(2*x-2)	178	generatingfunction
363	U	(1-sqrt((-2*x*sqrt(4*y+1))-2*(x+1)+3))/(2*x)	179	generatingfunction
288	T	 (k*binomial(m+k,n)*binomial(2*m+k-1,m))/(m+k)	143	explicitformula
290	T	 binomial(n+k-1,n)*binomial(n+m+k-1,m)	144	explicitformula
292	T	 (k*binomial(n+m,m)*binomial(2*n+2*m+k-1,n+m))/(n+ m+k)	145	explicitformula
294	T	(k*binomial(n+m+k,n)*binomial(n+2*m+k-1,m))/(n+m+k)	146	explicitformula
296	T	 (k*binomial(2*n+k,n)*binomial(2*n+m+k-1,m))/(2*n+k)	147	explicitformula
298	T	binomial(k,m)*binomial(k,n-m)	148	explicitformula
300	T	 (k*binomial(m+k,m)*binomial(m+k,n-m))/(m+k)	149	explicitformula
302	T	(k*binomial(n+k,m)*binomial(n+k,n-m))/(n+k)	150	explicitformula
304	T	 (k*binomial(2*m+k,m)*binomial(2*m+k,n-m))/(2*m+k)	151	explicitformula
306	T	 (k*binomial(n+m,n)*binomial(2*n+2*m+2*k,n+m))/(n+ m+k)	152	explicitformula
308	T	 binomial(k,n-m)*binomial(m+k-1,m)	153	explicitformula
310	T	(k*binomial(m+k,n-m)*binomial(2*m+k-1,m))/(m+k)	154	explicitformula
312	T	(k*binomial(n+k,n-m)*binomial(n+m+k-1,m))/(n+k)	155	explicitformula
314	T	 binomial(k,m)*binomial(n+2*m+k-1,n)	156	explicitformula
316	T	 (k*binomial(m+k,m)*binomial(n+3*m+k-1,n))/(m+k)	157	explicitformula
318	T	(k*binomial(2*m+k,m)*binomial(n+4*m+k-1,n))/(2*m+k)	158	explicitformula
320	T	 binomial(k,n+m)*binomial(n+m,n)	159	explicitformula
323	T	binomial(k,m)*binomial(n+k-1,n)	160	explicitformula
326	T	(k*binomial(n+k,m)*binomial(2*n+k-1,n))/(n+k)	161	explicitformula
328	T	binomial(k,n)*binomial(n,m)	162	explicitformula
330	T	 binomial(n+k-1,m)*binomial(n-m+k-1,k-1)	163	explicitformula
332	T	(k*binomial(2*n+k-1,m)*binomial(2*n-m+k-1,n+k-1)) /(n+k)	164	explicitformula
336	T	1	166	explicitformula
334	T	1	165	explicitformula
338	T	binomial(n+k-1,n)*binomial(n+2*k,m)	167	explicitformula
340	T	 binomial(k,m)*binomial(n-m+k-1,n)	168	explicitformula
342	T	binomial(m+k-1,m)*binomial(n+k-1,n)	169	explicitformula
344	T	(k*binomial(n+k,m)*binomial(2*n-m+k-1,n))/(n+k)	170	explicitformula
346	T	 (k*binomial(2*m+k,m)*binomial(n+m+k-1,n))/(2*m+k)	171	explicitformula
348	T	(k*binomial(n+m+k,m)*binomial(2*n+k-1,n))/(n+m+k)	172	explicitformula
350	T	1	173	explicitformula
351	T	binomial(m+k-1,m)*binomial(n+2*m+k-1,n)	173	explicitformula
353	T	1	174	explicitformula
354	T	 (k*binomial(2*m+k-1,m)*binomial(n+3*m+k-1,n))/(m+ k)	174	explicitformula
356	T	binomial(k,n)*binomial((-n)+m+k-1,m)	175	explicitformula
358	T	 (k*binomial(m+k,n)*binomial((-n)+2*m+k-1,m))/(m+k)	176	explicitformula
360	T	 binomial(k,m)*binomial(n+m+k-1,n)	177	explicitformula
362	T	1	178	explicitformula
365	U	y+1/(1-x)**2	180	generatingfunction
367	U	1/((1-x)**2*(1-y))	181	generatingfunction
369	U	(sqrt((-4*y)+x**2-2*x+1)+x-1)/(2*(x-1)*y)	182	generatingfunction
371	U	y+(x+1)**2	183	generatingfunction
373	U	((-x**2)-2*x-1)/(y-1)	184	generatingfunction
375	U	((-sqrt((-4*x**2*y)-4*x+1))-2*x+1)/(2*x**2)	185	generatingfunction
377	U	(1-sqrt(((-4*x**2)-8*x-4)*y+1))/(2*y)	186	generatingfunction
378	T	( 1  )	186	explicitformula
379	T	( 0  )	186	explicitformula
381	U	((1-sqrt(1-4*x))*(y+1))/(2*x)	187	generatingfunction
382	T	( 1  )	187	explicitformula
383	T	( 0  )	187	explicitformula
385	U	(1-sqrt(1-4*x))/((sqrt(1-4*x)-1)*y+2*x)	188	generatingfunction
387	U	(sqrt((4*x-2)*y+2*sqrt(1-4*x)*y+x**2)-x)/((sqrt(1-4*x)-1)*y)	189	generatingfunction
389	U	((x+1)*(1-sqrt(1-4*y)))/(2*y)	190	generatingfunction
391	U	(1-sqrt(1-4*y))/(2*y+x*sqrt(1-4*y)-x)	191	generatingfunction
393	U	(sqrt(y**2+4*x*y+2*x*sqrt(1-4*y)-2*x)-y)/(x*(sqrt(1-4*y)-1))	192	generatingfunction
395	U	(1-sqrt(1-4*x))/(2*x*(1-y))	193	generatingfunction
397	U	(x-sqrt(2*sqrt(1-4*x)*x*y-2*x*y+x**2))/(2*x*y)	194	generatingfunction
399	U	1/((1-y)**2-x)	195	generatingfunction
401	U	((-sqrt(y**4-4*y**3+6*y**2-4*y-4*x+1))+y**2-2*y+1)/(2*x)	196	generatingfunction
403	U	(x+1)/(1-y)**2	197	generatingfunction
405	U	(sqrt(4*x*y**2-8*x*y+4*x+1)+1)/(2*y**2-4*y+2)	198	generatingfunction
412	U	(sqrt((4*x**2-8*x+4)*y+1)+1)/(2*x**2-4*x+2)	200	generatingfunction
414	U	1/((1-x)**2-y)	201	generatingfunction
416	U	((-sqrt((-4*y)+x**4-4*x**3+6*x**2-4*x+1))+x**2-2*x+1)/(2*y)	202	generatingfunction
418	U	(x+1)**2*(y+1)	203	generatingfunction
421	U	((x+1)*sqrt(4*y+x**2+2*x+1)+x**2+2*x+1)/2	204	generatingfunction
424	U	((-x**2)-2*x-1)/((x**2+2*x+1)*y-1)	205	generatingfunction
426	U	((-sqrt((-4*x*y)-4*x+1))-2*x*y-2*x+1)/(2*x**2*(y+1))	206	generatingfunction
428	U	(1-sqrt(((-4*x**4)-16*x**3-24*x**2-16*x-4)*y+1))/(2*(x+1)**2*y)	207	generatingfunction
430	U	((sqrt(4*x+1)+1)*(y+1))/2	208	generatingfunction
432	U	((-sqrt(4*x+1))-1)/((sqrt(4*x+1)+1)*y-2)	209	generatingfunction
435	U	(1-sqrt((-2*sqrt(4*x+1)*y)+((-4*x)-2)*y+1))/((sqrt(4*x+1)+1)*y)	210	generatingfunction
438	U	(y+1)/sqrt(1-4*x)	211	generatingfunction
440	U	-1/(y-sqrt(1-4*x))	212	generatingfunction
366	T	binomial(k,m)*binomial(n-2*m+2*k-1,n)	180	explicitformula
368	T	binomial(m+k-1,m)*binomial(n+2*k-1,n)	181	explicitformula
370	T	 (k*binomial(2*m+k,m)*binomial(n+2*m+2*k-1,n))/(2* m+k)	182	explicitformula
372	T	 binomial(k,m)*binomial(2*k-2*m,n)	183	explicitformula
374	T	(k*binomial(2*k,n)*binomial(m+k,m))/(m+k)	184	explicitformula
376	T	(k*binomial(n+k,m)*binomial(2*n-2*m+2*k,n))/(n+k)	185	explicitformula
380	T	(k*binomial(2*m+k,m)*binomial(2*m+2*k,n))/(2*m+k)	186	explicitformula
384	T	(k*binomial(k,m)*binomial(2*n+k-1,n))/(n+k)	187	explicitformula
386	T	(k*binomial(m+k,m)*binomial(2*n+m+k-1,n))/(n+m+k)	188	explicitformula
388	T	(k*binomial(2*m+k,m)*binomial(2*n+2*m+k-1,n))/(n+ 2*m+k)	189	explicitformula
390	T	 (k*binomial(k,n)*binomial(2*m+k-1,m))/(m+k)	190	explicitformula
392	T	 (k* (binomial(n+k,n))*(binomial(n+2*m+k-1,m)))/(n+m+k)	191	explicitformula
394	T	(k*(binomial(2*n+k,n))*(binomial(2*n+2*m+k-1, m)))/(2*n+m+k)	192	explicitformula
396	T	 (k*binomial(m+k-1,m)*binomial(2*n+k-1,n))/(n+k)	193	explicitformula
398	T	(k*binomial(2*m+k-1,m)*binomial(2*n+m+k-1,n))/(n+ m+k)	194	explicitformula
400	T	binomial(n+k-1,n)*binomial(2*n+m+2*k-1,m)	195	explicitformula
402	T	 (k*binomial(2*n+k-1,n)*binomial(4*n+m+2*k-1,m))/( n+k)	196	explicitformula
404	T	 binomial(k,n)*binomial(m+2*k-1,m)	197	explicitformula
409	T	binomial(k,m)*binomial(n+2*k-1,n)	199	explicitformula
406	T	m+1	198	explicitformula
415	T	binomial(m+k-1,m)*binomial(n+2*(m+k)-1,n)	201	explicitformula
413	T	n+1	200	explicitformula
417	T	(k*binomial(2*m+k-1,m)*binomial(n+2*(2*m+k)-1,n)) /(m+k)	202	explicitformula
419	T	1	203	explicitformula
420	T	 binomial(k,m)*binomial(2*k,n)	203	explicitformula
425	T	 binomial(m+k-1,m)*binomial(2*(m+k),n)	205	explicitformula
427	T	(k*binomial(n+k,m)*binomial(2*(n+k),n))/(n+k)	206	explicitformula
422	T	 k/m*binomial(2*m-k -1,m-1)*(-1)**(m-1)	204	explicitformula
423	T	 (2*k*(binomial(k-m,m))*(binomial(2*(k-m)-1,n-1)))/(n)	204	explicitformula
429	T	 (k*binomial(2*m+k-1,m)*binomial(2*(2*m+k),n))/(m+k)	207	explicitformula
439	T	binomial(k,m)*4**n*binomial(n+k/2-1,n)	211	explicitformula
431	T	binomial(k,m)	208	explicitformula
441	T	binomial(m+k-1,m)*4^n*binomial(n+(m+k)/2-1,n)	212	explicitformula
434	T	binomial((m+k-1),m)	209	explicitformula
433	T	 (m+k)/n*binomial(2*n-(m+k)-1,n-1)*(-1)**(n-1)*binomial((m+k-1) ,m)	209	explicitformula
437	T	1	210	explicitformula
436	T	(k*(2*m+k)*binomial(2*m+k-1,m)*(-1)**(n-1)*binomial(2*n-2*m-k-1,n-1))/((m+k)*n)	210	explicitformula
442	U	(sqrt(1-4*x)-sqrt((-4*y)-4*x+1))/(2*y)	213	generatingfunction
445	U	(1-sqrt((-4*y)-4*x+1))/2	214	generatingfunction
447	U	(y+x)/((-y)-x+1)	215	generatingfunction
449	U	(y+x)/((-y)-x+1)**2	216	generatingfunction
451	U	(y+x)**2+y+x	217	generatingfunction
453	U	((-2*(y+x))-sqrt((-4*y)-4*x+1)+1)/(2*(y+x))	218	generatingfunction
455	U	(y+x)/sqrt(1-4*(y+x))	219	generatingfunction
457	U	(y+x)/((-y)-x+1)**3	220	generatingfunction
459	U	(y+x)/(1-9*(y+x))**(1/3)	221	generatingfunction
461	U	1/sqrt(1-4*(y+x))	222	generatingfunction
463	U	1/((-y)-x+1)**2	223	generatingfunction
465	U	1/sqrt((y-1)**2-4*x**2)	224	generatingfunction
467	U	1/sqrt((x-1)^2-4*y^2)	225	generatingfunction
469	U	1/sqrt((y-1)^2-4*x)	226	generatingfunction
471	U	1/sqrt((x-1)**2-4*y)	227	generatingfunction
472	T	( 1  )	227	explicitformula
474	U	(sqrt(4*y**2+x**2-2*x+1)+2*y)/(x**2-2*x+1)	228	generatingfunction
475	T	( 1  )	228	explicitformula
477	U	(sqrt(y**2-2*y+4*x**2+1)+2*x)/(y**2-2*y+1)	229	generatingfunction
478	T	( 1  )	229	explicitformula
480	U	((y+x-1)*sqrt(y**2+((-2*x)-2)*y+x**2-2*x+1)+y**2-2*y+x**2-2*x+1)/(2*x**2*y**2)	230	generatingfunction
481	T	( 1  )	230	explicitformula
483	U	((y-x-1)*sqrt(y**2+((-2*x)-2)*y+x**2-2*x+1)+y**2+((-2*x)-2)*y+x**2+1)/(2*x**2)	231	generatingfunction
484	T	( 1  )	231	explicitformula
486	U	(x-1)/(y+x-1)	232	generatingfunction
487	T	( 1  )	232	explicitformula
489	U	((-sqrt((4*x-4)*y+x**2-2*x+1))-x+1)/(2*y)	233	generatingfunction
490	T	( 1  )	233	explicitformula
492	U	((-sqrt(y**2+((-2*x)-2)*y+x**2-2*x+1))-y+x+1)/(2*x)	234	generatingfunction
493	T	( 1  )	234	explicitformula
495	U	((-sqrt(y**2-2*y+x*((-2*y)-2)+x**2+1))+y-x+1)/(2*y)	235	generatingfunction
496	T	( 1  )	235	explicitformula
498	U	2/(sqrt((-4*y)+x**2-2*x+1)+x+1)	236	generatingfunction
499	T	( 1  )	236	explicitformula
501	U	2/(sqrt(y**2-2*y-4*x+1)+y+1)	237	generatingfunction
503	U	(y-1)/(y+x-1)	238	generatingfunction
505	U	((-sqrt(y**2+x*(4*y-4)-2*y+1))-y+1)/(2*x)	239	generatingfunction
507	U	2/((y+1)*sqrt(y**2-2*y-4*x+1)+y**2-2*x+1)	240	generatingfunction
508	T	( 1  )	240	explicitformula
510	U	2/((y-x+1)*sqrt((y-x+1)**2-4*y)+y**2-2*x*y+(x-1)**2)	241	generatingfunction
512	U	y+sqrt(4*x+1)	242	generatingfunction
514	U	sqrt(4*y+1)+x	243	generatingfunction
515	T	( 1  )	243	explicitformula
516	T	( 0  )	243	explicitformula
518	U	-sqrt(4*x+1)/(y-1)	244	generatingfunction
519	T	( 1  )	244	explicitformula
520	T	( 0  )	244	explicitformula
470	T	4**n*binomial((2*n+k-2)/2,n)*binomial(2*n+m+k-1,m)	226	explicitformula
473	T	4**m*binomial((2*m+k-2)/2,m)*binomial(n+2*m+k-1,n)	227	explicitformula
476	T	(k*4**m*binomial((m+k)/2,(k-m)/2)*binomial(n+m+k-1 ,n))/(m+k)	228	explicitformula
482	T	(2*k*binomial(n+m+2*k,m)*binomial(n+m+2*k,m+2*k)) /(n+m+2*k)	230	explicitformula
485	T	(2*k*binomial(n+m-1,n)*binomial(n+m+2*k,m))/(n+m+ 2*k)	231	explicitformula
488	T	(k*(binomial(m+k-1,k) )*(binomial(n+m,m)))/(n+m)	232	explicitformula
491	T	k*binomial(2*m+k-1,m+k )*binomial(n+m,m)/(n+m)	233	explicitformula
494	T	(k*(binomial(n+m-1,m-1 ))*(binomial(n+m+k,m)))/(n+m+k)	234	explicitformula
497	T	(k*(binomial(n+m-1,n-1 ))*(binomial(n+m+k,n)))/(n+m+k)	235	explicitformula
502	T	(k*(binomial(n+m,n))*( binomial(2*n+m+k-1,n-1)))/(n+m)	237	explicitformula
500	T	k*(binomial(n+m,m)*binomial(n+2*m+k-1,m-1))/(n+m)	236	explicitformula
504	T	(k*(binomial(n+k-1,k)) *(binomial(n+m,n)))/(n+m)	238	explicitformula
506	T	(k*(binomial(n+m,n))*( binomial(2*n+k-1,n+k)))/(n+m)	239	explicitformula
509	T	(2*k*(binomial(n+m,n)) *(binomial(2*n+m+2*k-1,n-1)))/(n+m)	240	explicitformula
511	T	1	241	explicitformula
517	T	binomial(k,n)*4**m*binomial((k-n)/2,m)	243	explicitformula
513	T	binomial(k,m)*binomial((k-m)/2,n)*4**n	242	explicitformula
521	T	binomial(k/2,n)*binomial(m+k-1,m)*4**n	244	explicitformula
443	T	1	213	explicitformula
450	T	 binomial(n+m,m)*binomial(n+m+k-1,n+m-k)	216	explicitformula
444	T	(k*binomial(2*m+k-1,m)*4**n*binomial(n+(2*m+k)/2-1 ,n))/(m+k)	213	explicitformula
446	T	1	214	explicitformula
448	T	binomial(n+m,m)*binomial(n+m-1,n+m-k)	215	explicitformula
452	T	binomial(k,n+m-k)*binomial(n+m,m)	217	explicitformula
458	T	binomial(n+m,m)*binomial(n+m+2*k-1,n+m-k)	220	explicitformula
454	T	0	218	explicitformula
456	T	4**(n+m-k)*binomial(n+m,m)*binomial(n+m-k/2-1,n+m-k)	219	explicitformula
460	T	9**(n+m-k)*binomial(n+m,m)*binomial(n+m-(2*k)/3-1, n+m-k)	221	explicitformula
462	T	4**(n+m)*binomial(n+m,n)*binomial(n+m+k/2-1,n+m)	222	explicitformula
464	T	 binomial(n+m,n)*binomial(n+m+2*k-1,n+m)	223	explicitformula
466	T	2**(n-1)*((-1)**n+1)*binomial((n+k-2)/2,n/2)*binomial(n+m+k-1,m)	224	explicitformula
524	U	(1-sqrt(1-4*sqrt(4*x+1)*y))/(2*y)	246	generatingfunction
526	U	1/(sqrt(1-4*x)*sqrt(1-4*y))	247	generatingfunction
528	U	sqrt(4*x*y+1)+y	248	generatingfunction
529	T	( 1  )	248	explicitformula
530	T	( 0  )	248	explicitformula
532	U	(sqrt((4*x**2+1)*y**2-2*y+1)+2*x*y)/(1-y)**2	249	generatingfunction
533	T	( 1  )	249	explicitformula
534	T	( 0  )	249	explicitformula
537	U	((-sqrt(1-4*x)*sqrt(1-4*x*y))-2*x*y-2*x+1)/(2*x**2*(1-y)**2)	250	generatingfunction
539	U	(sqrt(1-4*x*y)-sqrt(1-4*x))/(2*(x-x*y))	251	generatingfunction
541	U	(y+x)**2	252	generatingfunction
543	U	(y+x)**3	253	generatingfunction
545	U	(y+x)**4	254	generatingfunction
547	U	((-sqrt(y**2+(4*x+2)*y+4*x+1))+y+2*x+1)/(2*x**2)	255	generatingfunction
549	U	(sqrt(4*y+4*x+1)-2*x-1)/(2*y-2*x**2)	256	generatingfunction
551	U	(sqrt((-4*y)-4*x+1)+2*x-1)/((-2*y)-2*x**2)	257	generatingfunction
552	T	( binomial(m+k-1,m)  )	257	explicitformula
554	U	((-sqrt(y**2-(2-4*x)*y-4*x+1))-y-2*x+1)/(2*x**2)	258	generatingfunction
555	T	( k/(m+k)*binomial(2*m+k-1,m)  )	258	explicitformula
557	U	(sqrt(y**2+(4*x+2)*y+4*x+1)-y-1)/(2*x*y+2*x)	259	generatingfunction
559	U	(sqrt((4*x+4)*y+x**2+2*x+1)-x-1)/((2*x+2)*y)	260	generatingfunction
561	U	1/(y+1)-x	261	generatingfunction
563	U	(sqrt(4*x+1)+1)/(2*(1-y))	262	generatingfunction
565	U	(1-sqrt((-2*sqrt(4*x+1)*y)-2*y+1))/(2*y)	263	generatingfunction
567	U	(y+1)*(x*y+x+1)	264	generatingfunction
568	T	( 0  )	264	explicitformula
570	U	(y+1)/(1-x*(y+1)**2)	265	generatingfunction
572	U	1/(1-x*(y+1)**2)	266	generatingfunction
573	T	( 1  )	266	explicitformula
574	T	( 0  )	266	explicitformula
577	U	x*y**2+2*x*y+x+1	267	generatingfunction
579	U	((-sqrt((-4*x*y**2)-4*x*y+1))-2*x*y+1)/(2*x*y**2)	268	generatingfunction
581	U	((-sqrt((-4*x*y)-4*x+1))-2*x+1)/(2*x)	269	generatingfunction
583	U	(1-sqrt((-4*x*y**2)-8*x*y-4*x+1))/(2*x*(y+1)**2)	270	generatingfunction
587	U	((-sqrt(4*x*y**2+4*x*y+1))-2*x*y-1)/(2*x-2)	271	generatingfunction
591	U	x*(y+1)**3+1	272	generatingfunction
593	U	-1/(x*y**3+3*x*y**2+3*x*y+x-1)	273	generatingfunction
595	U	(1-sqrt((-4*x*y**3)-12*x*y**2-12*x*y-4*x+1))/(2*x*(y+1)**3)	274	generatingfunction
597	U	(sqrt(4*x*y**3+12*x*y**2+12*x*y+4*x+1)+1)/2	275	generatingfunction
598	T	( 1  )	275	explicitformula
599	T	( 0  )	275	explicitformula
601	U	(sqrt(4*x*y**2+8*x*y+4*x+1)+1)/2	276	generatingfunction
527	T	binomial(m+k/2-1,m)*4**(n+m)*binomial(n+k/2-1,n)	247	explicitformula
531	T	binomial(k,n-m+k)*4**n*binomial((n-m+k)/2,n)	248	explicitformula
536	T	(k*binomial(m+k,n+k)*4**n*binomial((n+k)/2,n))/(m+ k)	249	explicitformula
535	T	( 0 )	249	explicitformula
544	T	delta(3*k,n+m)*binomial(n+m,m)	253	explicitformula
538	T	0	250	explicitformula
542	T	delta(2*k,n+m)*binomial(n+m,m)	252	explicitformula
546	T	delta(4*k,n+m)*binomial(n+m,m)	254	explicitformula
548	T	(k*(-1)**(n+m)*binomial(n+m+k,m)*binomial(2*n+2*k, n))/(n+m+k)	255	explicitformula
550	T	(k*(-1)**(n+m)*binomial(n+2*m+k,m)*binomial(2*n+2* (m+k),n))/(n+2*m+k)	256	explicitformula
553	T	(k*binomial(n+2*m+k,m)*binomial(2*n+2*(m+k),n))/( n+2*m+k)	257	explicitformula
556	T	(k*binomial(n+m+k,m)*binomial(2*n+2*k,n))/(n+m+k)	258	explicitformula
558	T	(k*(-1)**(n+m)*binomial(n+m+k-1,m)*binomial(2*n+k- 1,n))/(n+k)	259	explicitformula
560	T	(k*binomial(2*m+k-1,m)*(-1)**(n+m)*binomial(n+m+k- 1,n))/(m+k)	260	explicitformula
562	T	binomial(k,n)*binomial((-n)+m+k-1,m)*(-1)**(n+m)	261	explicitformula
564	T	binomial(m+k-1,m)	262	explicitformula
566	T	k/(m+k)*binomial(2*m+k-1,m)	263	explicitformula
569	T	binomial(k,n)*binomial(n+k,m)	264	explicitformula
571	T	binomial(n+k-1,n)*binomial(2*n+k,m)	265	explicitformula
576	T	binomial(2*n,m)*binomial(n+k-1,n)	266	explicitformula
575	T	0	266	explicitformula
578	T	binomial(k,n)*binomial(2*n,m)	267	explicitformula
580	T	(k*binomial(m+k,n)*binomial(2*n,m))/(m+k)	268	explicitformula
584	T	(k*binomial(2*n,m)*binomial(2*n+k-1,n))/(n+k)	270	explicitformula
582	T	0	269	explicitformula
588	T	(k*(binomial(2*n,m))*(binomial(n-m+k,n)))/(n-m+ k)	271	explicitformula
586	T	(1)	270	explicitformula
589	T	k/n*(binomial(2*n,n-k))*(-1)**(n-1)	271	explicitformula
585	T	(0)	270	explicitformula
590	T	1	271	explicitformula
592	T	binomial(k,n)*binomial(3*n,m)	272	explicitformula
594	T	(k*binomial(3*n,m)*binomial(n+k,n))/(n+k)	273	explicitformula
596	T	(k*binomial(3*n,m)*binomial(2*n+k,n))/(2*n+k)	274	explicitformula
600	T	k/ n*binomial(2*n-k-1,n-1)*(-1)**(n-1)*binomial(3*(n) ,m)	275	explicitformula
540	T	0	251	explicitformula
603	U	y/(1-x)**2+1	277	generatingfunction
605	U	(1-x)**2/((1-x)**2-y)	278	generatingfunction
607	U	((x-1)*sqrt((-4*y)+x**2-2*x+1)+x**2-2*x+1)/(2*y)	279	generatingfunction
608	T	( 1  )	279	explicitformula
609	T	( 0  )	279	explicitformula
611	U	((-sqrt(4*y+x**2-2*x+1))+x-1)/(2*x-2)	280	generatingfunction
613	U	y/(1-x)**3+1	281	generatingfunction
615	U	(1-x)**3/((1-x)**3-y)	282	generatingfunction
617	U	((x-1)*sqrt((4*x-4)*y+x**4-4*x**3+6*x**2-4*x+1)-x**3+3*x**2-3*x+1)/(2*y)	283	generatingfunction
618	T	( binomial(k,n)  )	283	explicitformula
620	U	(sqrt((4-4*x)*y+x**4-4*x**3+6*x**2-4*x+1)+x**2-2*x+1)/(2*x**2-4*x+2)	284	generatingfunction
622	U	(x+1)*((x+1)*y+1)	285	generatingfunction
624	U	((-x)-1)/((x**2+2*x+1)*y-1)	286	generatingfunction
626	U	(1-sqrt(((-4*x**3)-12*x**2-12*x-4)*y+1))/(2*(x+1)**2*y)	287	generatingfunction
628	U	((x+1)*sqrt(4*y+1)+x+1)/2	288	generatingfunction
630	U	((-sqrt((-4*x*y)+x**2-2*x+1))-2*x*y-x+1)/(2*x**2*y)	289	generatingfunction
632	U	1/((x-1)*y+x**2-2*x+1)	290	generatingfunction
634	U	(sqrt((4*x-4)*y+x**4-4*x**3+6*x**2-4*x+1)-x**2+2*x-1)/(2*(x-1)*y)	291	generatingfunction
637	U	(1-(x-1)*y)/(1-x)**2	292	generatingfunction
642	U	(x+1)*((x+1)**2*y+1)	293	generatingfunction
643	T	( 1  )	293	explicitformula
647	U	((-x)-1)/((x**3+3*x**2+3*x+1)*y-1)	294	generatingfunction
649	U	(1-sqrt(1-4*(x+1)**4*y))/(2*(x+1)**3*y)	295	generatingfunction
653	U	(sqrt(y**2+2*y+4*x+1)+y+2*x+1)/2	297	generatingfunction
655	U	((-sqrt(x**2*y**2-2*x*y+4*x+1))+x*y-2*x-1)/(2*y-2)	298	generatingfunction
657	U	((-sqrt((x+1)*(4*y+x**3+3*x**2+3*x+1)))+x**2+2*x+1)/(2*(x+1)*y)	299	generatingfunction
659	U	(-y)-x+1	300	generatingfunction
661	U	(1-x)/(y+1)	301	generatingfunction
663	U	(1-y)/(x+1)	302	generatingfunction
665	U	1/(y+x+1)	303	generatingfunction
667	U	(sqrt(4*y+x**2+2*x+1)-x-1)/(2*y)	304	generatingfunction
669	U	(sqrt(y**2+2*y+4*x+1)-y-1)/(2*x)	305	generatingfunction
672	U	(sqrt(4*y+4*x+1)-1)/(2*y+2*x)	306	generatingfunction
677	U	-1/((x**2-2*x+1)*y+x-1)	307	generatingfunction
604	T	binomial(k,m)*binomial(n+2*m-1,n)	277	explicitformula
606	T	binomial(m+k-1,m)*binomial(n+2*m-1,n)	278	explicitformula
610	T	 (k*binomial(2*m+k-1,m)*binomial(n+2*m-1,n))/(m+k)	279	explicitformula
614	T	 binomial(k,m)*binomial(n+3*m-1,n)	281	explicitformula
612	T	1	280	explicitformula
616	T	binomial(m+k-1,m)*binomial(n+3*m-1,n)	282	explicitformula
619	T	(k*binomial(2*m+k-1,m)*binomial(n+3*m-1,n))/(m+k)	283	explicitformula
623	T	 binomial(k,m)*binomial(m+k,n)	285	explicitformula
621	T	1	284	explicitformula
625	T	binomial(m+k-1,m)*binomial(2*m+k,n)	286	explicitformula
627	T	 (k*binomial(2*m+k-1,m)*binomial(3*m+k,n))/(m+k)	287	explicitformula
629	T	 binomial(k,n)	288	explicitformula
631	T	 (k*binomial(n+k,m)*binomial(n+m+k,n))/(n+k)	289	explicitformula
633	T	 binomial(m+k-1,m)*binomial(n+m+2*k-1,n)	290	explicitformula
635	T	1	291	explicitformula
636	T	(k*binomial(2*m+k-1,m)*binomial(n+2*(m+k)+m-1,n)) /(m+k)	291	explicitformula
638	T	binomial(k,m)*binomial(n-m+2*k-1,n)	292	explicitformula
675	T	(k*(-1)**(n-m)*binomial(2*n+m+k-1,n)*binomial(2*n+ 2*m+k-1,m))/(n+m+k)	306	explicitformula
644	T	0	293	explicitformula
645	T	0	293	explicitformula
646	T	binomial(k,m)*binomial(2*m+k,n)	293	explicitformula
648	T	(k*binomial(m+k,m)*binomial(3*m+k,n))/(m+k)	294	explicitformula
650	T	(k*binomial(2*m+k,m)*binomial(4*m+k,n))/(2*m+k)	295	explicitformula
651	U	 ((x+1)*sqrt((4*x+4)*y+1)+x+1)/2	296	generatingfunction
652	T	binomial(k,n)	296	explicitformula
654	T	1	297	explicitformula
656	T	1	298	explicitformula
660	T	binomial(k,n+m)*(-1)**(n-m)*binomial(n+m,n)	300	explicitformula
658	T	(k*binomial(2*m+k-1,m)*(-1)**(n-m-k)*binomial(n+2* (m+k)+m-1,n))/(m+k)	299	explicitformula
662	T	(k*binomial(m+k,n+m)*(-1)**(n-m)*binomial(n+m,n))/ (m+k)	301	explicitformula
664	T	(k*(-1)**(n-m)*binomial(n+k,n+m)*binomial(n+m,n))/ (n+k)	302	explicitformula
668	T	 (k*(-1)**(n-m)*binomial(n+m+k-1,n)*binomial(n+2*m+ k-1,m))/(m+k)	304	explicitformula
666	T	(-1)**(n-m)*binomial(n+k-1,n)*binomial(n+m+k-1,m)	303	explicitformula
671	T	(k*(-1)**(n-m)*binomial(2*n+k-1,n)*binomial(2*n+m+ k-1,m))/(n+k)	305	explicitformula
681	U	(1-sqrt(1-4*y))/(2*(1-x)*y)	308	generatingfunction
683	U	(y-sqrt(y**2+2*x*sqrt(1-4*y)*y-2*x*y))/(2*x*y)	309	generatingfunction
685	U	(2*x*y-sqrt(1-4*y)+1)/(2*y)	310	generatingfunction
687	U	1/((x**2+2*x+1)*y-x-1)	311	generatingfunction
689	U	-1/((1-x)**3*y+x-1)	312	generatingfunction
691	U	(1-sqrt((4*x-4)*y+1))/((2*x**2-4*x+2)*y)	313	generatingfunction
693	U	((x-1)**3*y-1)/(x-1)	314	generatingfunction
695	U	((x-1)**2*y-1)/(x-1)	315	generatingfunction
697	U	(y+(x-1)**2)/(1-x)	316	generatingfunction
698	T	( 1  )	316	explicitformula
699	T	( 0  )	316	explicitformula
701	U	1/(1/(1-x)-y/(1-x)**2)	317	generatingfunction
705	U	((-sqrt(((-4*x**2)-4*x)*y+1))+2*x+1)/(2*x**2+2*x)	319	generatingfunction
707	U	y/(1-x)**2-x+1	320	generatingfunction
709	U	(1-sqrt(1-4*y))/(2*(1-x)**2*y)	321	generatingfunction
711	U	-1/((x**4-4*x**3+6*x**2-4*x+1)*y-x**2+2*x-1)	322	generatingfunction
713	U	((x**4-4*x**3+6*x**2-4*x+1)*y+1)/(x**2-2*x+1)	323	generatingfunction
715	U	(x+1)*y+(x+1)**2	324	generatingfunction
717	U	((-x**2)-2*x-1)/((x+1)*y-1)	325	generatingfunction
719	U	(1-sqrt(((-4*x**3)-12*x**2-12*x-4)*y+1))/((2*x+2)*y)	326	generatingfunction
721	U	1/sqrt((1-x)**4-4*y)	327	generatingfunction
723	U	1/sqrt(1-(4*y)/(1-x))	328	generatingfunction
725	U	1/sqrt(1-4*(x+1)*y)	329	generatingfunction
727	U	1/sqrt(1-4*(x+1)**2*y)	330	generatingfunction
729	U	1/((1-x)*sqrt(1-4*y))	331	generatingfunction
731	U	(sqrt(1-4*y)-sqrt((-4*y)-4*x*sqrt(1-4*y)+1))/(2*x*sqrt(1-4*y))	332	generatingfunction
733	U	1/((1-x)**2*sqrt(1-4*y))	333	generatingfunction
735	U	(1-sqrt(1-4*x))/(2*x*sqrt(1-4*y))	334	generatingfunction
738	U	(((-2*x)-sqrt(1-4*x)+1)*(y+1))/(2*x**2)	335	generatingfunction
740	U	((-2*x)-sqrt(1-4*x)+1)/((2*x+sqrt(1-4*x)-1)*y+2*x**2)	336	generatingfunction
741	T	( 1  )	336	explicitformula
745	U	((-2*x)-sqrt(1-4*x)+1)/(2*x**2*(1-y))	337	generatingfunction
747	U	(2*x**2*y-2*x-sqrt(1-4*x)+1)/(2*x**2)	338	generatingfunction
749	U	(x-sqrt((4*x-2)*y+2*sqrt(1-4*x)*y+x**2))/(2*x*y)	339	generatingfunction
751	U	(((-2*x)-sqrt(1-4*x)+1)*y)/(2*x**2)+x	340	generatingfunction
702	T	 (k*binomial(m+k,m)*binomial(n+m-k-1,n))/(m+k)	317	explicitformula
704	T	 binomial(k,m)*binomial(4*m-k,n)*(-1)^(n+m)	318	explicitformula
703	U	((x-1)^4*y-1)/(x-1)	318	generatingfunction
708	T	 binomial(k,m)*binomial(n+3*m-k-1,n)	320	explicitformula
710	T	 binomial(n+2*k-1,n)*(k)*binomial(2*(m)+k-1,m )/(m+k)	321	explicitformula
712	T	binomial(m+k-1,m)*binomial(n+2*(k-m)-1,n)	322	explicitformula
714	T	binomial(k,m)*binomial(n+2*(k-2*m)-1,n)	323	explicitformula
716	T	binomial(k,m)*binomial(2*k-m,n)	324	explicitformula
718	T	 binomial(m+k-1,m)*binomial(2*(m+k)-m,n)	325	explicitformula
720	T	 (k*binomial(2*m+k-1,m)*binomial(3*m+2*k,n))/(m+k)	326	explicitformula
732	T	k*binomial(2*n+k-1,n)/(n+k)*binomial(m+(n+k)/2,m)*binomial(2*m+n+k,m+(n+k)/2)/binomial((n+k),(n+k)/2)	332	explicitformula
722	T	binomial(n+4*m+2*k-1,n)*(binomial(m+k/2, m)*binomial(2*m+k, m+k/2)/binomial(k, k/2))	327	explicitformula
724	T	binomial(n+m-1,n)*(binomial(m+k/2,m)*binomial(2*m+k,m+k/2)/binomial(k,k/2))	328	explicitformula
726	T	binomial(m,n)*(binomial(m+k/2,m)*binomial(2*m+k,m+k/2)/binomial(k,k/2))	329	explicitformula
728	T	binomial(2*m,n)*(binomial(m+k/2,m)*binomial(2*m+k,m+k/2)/binomial(k,k/2))	330	explicitformula
730	T	binomial(m+k-1,m)*((binomial(m+k/2,m)*binomial(2*m+k,m+k/2))/binomial(k,k/2))	331	explicitformula
734	T	binomial(n+2*k-1,n)*binomial(m+k/2,m)*binomial(2*m+k,m+k/2)/binomial(k,k/2)	333	explicitformula
739	T	(k*binomial(k,m)*binomial(2*n+2*k,n))/(n+k)	335	explicitformula
737	T	k*binomial(2*n+k-1,n)*binomial(m+k/2,m)*binomial(2*m+k,m+k/2)/binomial(k,k/2)/(n+k)	334	explicitformula
736	T	k*binomial(2*n+k-1,n)*binomial(m+(k-1)/2,m)*binomial(2*m+k-1,m+(k-1)/2)/binomial(k-1,(k-1)/2)/(n+k)	334	explicitformula
742	T	1	336	explicitformula
743	T	2	336	explicitformula
744	T	(k*binomial(m+k,m)*binomial(2*n+2*(m+k),n))/(n+m+ k)	336	explicitformula
746	T	 (k*binomial(m+k-1,m)*binomial(2*n+2*k,n))/(n+k)	337	explicitformula
750	T	(k*binomial(2*m+k-1,m)*binomial(2*n+2*(m+k),n))/( n+m+k)	339	explicitformula
748	T	binomial(k,m)	338	explicitformula
688	T	binomial(m+k-1,m)*(-1)**(n-k)*binomial(n-m+k-1,n)	311	explicitformula
752	T	1	340	explicitformula
680	T	binomial(m+k-1,m)*binomial(n-m+k-1,n)	307	explicitformula
682	T	 (k*binomial(2*m+k-1,m)*binomial(n+k-1,n))/(m+k)	308	explicitformula
684	T	(k*binomial(n+2*m+k-1,m)*binomial(2*n+k-1,n))/(n+ m+k)	309	explicitformula
686	T	 binomial(k,n)	310	explicitformula
690	T	 binomial(m+k-1,m)*binomial(n-2*m+k-1,n)	312	explicitformula
692	T	(k*binomial(2*m+k-1,m)*binomial(n-m+k-1,n))/(m+k)	313	explicitformula
694	T	binomial(k,m)*binomial(3*m-k,n)*(-1)**n	314	explicitformula
696	T	binomial(k,m)*binomial(2*m-k,n)*(-1)**(n+m)	315	explicitformula
753	U	y/(1-x)**2+x	341	generatingfunction
755	U	y/(1-x)**3+x	342	generatingfunction
757	U	(x+1)*y+x*(x+1)**2	343	generatingfunction
759	U	(x+1)**2*y+x*(x+1)	344	generatingfunction
763	U	(x+1)**3*y+x*(x+1)	345	generatingfunction
765	U	(x+1)**3*y+x*(x+1)**2	346	generatingfunction
767	U	(x+1)**2*y+x	347	generatingfunction
769	U	(x+1)**3*y+x	348	generatingfunction
771	U	(y+x)/(1-x)	349	generatingfunction
773	U	(y+x)/(1-x)**2	350	generatingfunction
775	U	y/(1-x)**2+x/(1-x)	351	generatingfunction
776	T	( 0  )	351	explicitformula
778	U	y/(1-x)+x/(1-x)**2	352	generatingfunction
780	U	y/(1-x)+x/(1-x)**3	353	generatingfunction
781	T	( 0  )	353	explicitformula
783	U	y/(1-x)**2+x/(1-x)**3	354	generatingfunction
784	T	 1	354	explicitformula
786	U	1/((-y**2)-x**2+1)	355	generatingfunction
788	U	(y**2+x**2)/(1-y)	356	generatingfunction
790	U	((-sqrt((-4*x**2*y**2)+4*x**2+1))-1)/(2*y**2-2)	357	generatingfunction
792	U	y**2+x	358	generatingfunction
794	U	y+x**2	359	generatingfunction
796	U	1/((-y**2)-x+1)	360	generatingfunction
798	U	1/((-y)-x**2+1)	361	generatingfunction
800	U	((-sqrt(y**4-2*y**2-4*x+1))-y**2+1)/(2*x)	362	generatingfunction
804	U	((-sqrt((-4*y)+x**4-2*x**2+1))-x**2+1)/(2*y)	363	generatingfunction
805	T	( 1  )	363	explicitformula
809	U	1/sqrt((-4*y**2)-4*x**2+1)	364	generatingfunction
812	U	1/sqrt((-4*y**2)-4*x+1)	365	generatingfunction
815	U	1/sqrt((-4*y)-4*x**2+1)	366	generatingfunction
817	U	((-sqrt(y**2-4*x*y+2*y+1))+2*x*y-y-1)/(2*x-2)	367	generatingfunction
819	U	((-2*y)-sqrt(1-4*y)+1)/(2*y**2)+x	368	generatingfunction
821	U	((-2*y)-sqrt(1-4*y)+1)/(2*(1-x)*y**2)	369	generatingfunction
823	U	1/sqrt(1-4*y)+x	370	generatingfunction
826	U	y+1/sqrt(1-4*x)	371	generatingfunction
828	U	1/(sqrt(1-4*x)*(1-y))	372	generatingfunction
830	U	(sqrt(1-4*x)-sqrt((-4*sqrt(1-4*x)*y)-4*x+1))/(2*sqrt(1-4*x)*y)	373	generatingfunction
758	T	binomial(k,m)*binomial(2*k-m,n+m-k)	343	explicitformula
760	T	0	344	explicitformula
761	T	1	344	explicitformula
764	T	binomial(k,m)*binomial(2*m+k,n+m-k)	345	explicitformula
766	T	binomial(k,m)*binomial(m+2*k,n+m-k)	346	explicitformula
768	T	binomial(k,m)*binomial(2*m,n+m-k)	347	explicitformula
770	T	binomial(k,m)*binomial(3*m,n+m-k)	348	explicitformula
772	T	 binomial(k,m)*binomial(n+m-1,n+m-k)	349	explicitformula
774	T	binomial(k,m)*binomial(n+m+k-1,n+m-k)	350	explicitformula
777	T	 binomial(k,m)*binomial(n+2*m-1,n+m-k)	351	explicitformula
779	T	binomial(k,m)*binomial(n+k-1,n+m-k)	352	explicitformula
782	T	binomial(k,m)*binomial(n-m+2*k-1,n+m-k)	353	explicitformula
785	T	 binomial(k,m)*binomial(n+2*k-1,n+m-k)	354	explicitformula
787	T	 (((-1)**m+1)*binomial(n/2+m/2,n/2)*((-1)**n+1)*binomial((n+m)/2+k-1,(n+m)/2))/4	355	explicitformula
789	T	(((-1)**n+1)*(binomial(k,k-n/2))*(binomial(n+m-k-1,n+m-2*k)))/2	356	explicitformula
791	T	 (k*((-1)**m+1)*binomial(n/2+m/2,n/2)*((-1)**n+1)*(- 1)**((n+m)/2+1)*binomial(n-k-1,(n+m)/2-1))/(2*(n+m ))	357	explicitformula
797	T	(((-1)**m+1)*binomial(n+m/2,n)*binomial(n+m/2+k-1, n+m/2))/2	360	explicitformula
795	T	(delta(k,n/2+m)*binomial(n/2+m,m)*((-1)**n+1) )/2	359	explicitformula
793	T	(delta(k,n+m/2)*((-1)**m+1)*binomial(n+m/2,n) )/2	358	explicitformula
799	T	(binomial(n/2+m,m)*binomial(n/2+m+k-1,n/2+m)*((-1 )**n+1))/2	361	explicitformula
801	T	1	362	explicitformula
802	T	1	362	explicitformula
803	T	(k*((-1)**m+1)*binomial(n+m/2,n)*binomial(2*n+m/2+ k-1,n+m/2))/(2*(n+k))	362	explicitformula
806	T	1	363	explicitformula
807	T	1	363	explicitformula
808	T	(k*binomial(n/2+m,m)*binomial(n/2+2*m+k-1,n/2+m)* ((-1)**n+1))/(2*(m+k))	363	explicitformula
822	T	(k*binomial(2*m+2*k,m)*binomial(n+k-1,n))/(m+k)	369	explicitformula
810	T	(((-1)**n+1)*((-1)**m+1)*binomial(n/2+m/2,n/2)*binomial((n+m)/2+(k-1)/2,(n+m)/2)*binomial(2*((n+m)/2)+k-1,(n+m)/2+(k-1)/2))/(binomial(k-1,(k-1)/2)*4)	364	explicitformula
813	T	((-1)**m+1)*binomial(n+m/2,n)*binomial(n+m/2+k/2,n+m/2)*binomial(2*(n+m/2)+k,n+m/2+k/2)/(binomial(k,k/2)*2)	365	explicitformula
816	T	((-1)**n+1)*binomial(m+n/2,m)*binomial(m+n/2+k/2,m+n/2)*binomial(2*(m+n/2)+k,m+n/2+k/2)/(binomial(k,k/2)*2)	366	explicitformula
811	T	(((-1)**n+1)*((-1)**m+1)*binomial(n/2+m/2,n/2)*binomial((n+m)/2+k/2,(n+m)/2)*binomial(2*((n+m)/2)+k,(n+m)/2+k/2))/(binomial(k,k/2)*4)	364	explicitformula
818	T	binomial(k,m)	367	explicitformula
820	T	 binomial(k,n)	368	explicitformula
824	T	binomial(k,n)*binomial(m+(k-n)/2,m)*binomial(2*m+k-n,m+(k-n)/2)/binomial(k-n,(k-n)/2)	370	explicitformula
825	T	binomial(k,n)*binomial(m+(k-n-1)/2,m)*binomial(2*m+k-n-1,m+(k-n-1)/2)/binomial(k-n-1,(k-n-1)/2)	370	explicitformula
827	T	binomial(k,m)*binomial(n+(k-m)/2,n)*binomial(2*n+k-m,n+(k-m)/2)/binomial(k-m,(k-m)/2)	371	explicitformula
829	T	(binomial(m+k-1,m)*binomial(n+(k-1)/2,n)*binomial (2*n+k-1,n+(k-1)/2))/binomial(k-1,(k-1)/2)	372	explicitformula
832	U	1/(1-x)-y	374	generatingfunction
834	U	(1-sqrt((-4*y**2)-4*x+1))/(2*(y**2+x))	375	generatingfunction
836	U	(1-sqrt((-4*y)-4*x**2+1))/(2*(y+x**2))	376	generatingfunction
838	U	(sqrt(y**2+(2-2*x)*y+x**2+2*x+1)+y+x+1)/2	377	generatingfunction
840	U	(y+x+1)**2	378	generatingfunction
842	U	y**2+x**2+x	379	generatingfunction
844	U	y**2+y+x**2	380	generatingfunction
846	U	y**3+x**2+x	381	generatingfunction
848	U	y**2+y+x**3	382	generatingfunction
850	U	y+x**3+x	383	generatingfunction
852	U	y**3+y+x	384	generatingfunction
854	U	(x**2+1)/(1-y)	385	generatingfunction
856	U	(y**2+1)/(1-x)	386	generatingfunction
858	U	((-sqrt(y**2-2*y-4*x**2+1))-y+1)/(2*x**2)	387	generatingfunction
860	U	(1-sqrt(((-4*x**2)-4)*y+1))/(2*y)	388	generatingfunction
862	U	y+x**2+1	389	generatingfunction
864	U	y**2+x+1	390	generatingfunction
869	U	(1-sqrt((-4*x*y**2)-4*x+1))/(2*x)	391	generatingfunction
871	U	(1-sqrt((-4*x*y**3)-12*x*y**2-12*x*y-4*x+1))/(2*x*y+2*x)	392	generatingfunction
874	U	((-sqrt((-4*y**2)+x**2-2*x+1))-x+1)/(2*y**2)	393	generatingfunction
876	U	((1-sqrt(1-4*x))*(1-sqrt(1-4*y)))/(4*x*y)	394	generatingfunction
878	U	-(1-sqrt(1-4*y))**2/(4*(x-(1-sqrt(1-4*y))/(2*y))*y**2)	395	generatingfunction
880	U	((-2*x*y**2)+2*y+sqrt(1-4*y)-1)/((sqrt(1-4*y)-1)*y)	396	generatingfunction
882	U	-1/(x*y**2+(1-2*x)*y+x-1)	397	generatingfunction
884	U	((-x*y**2)+2*x*y-x-1)/(y-1)	398	generatingfunction
886	U	1/((1-x)**2*(1-y)**2)	399	generatingfunction
888	U	(1/(1-y)**2+sqrt((4*x)/(1-y)**2+1/(1-y)**4)+2*x)/2	400	generatingfunction
891	U	(1/(1-y)**2-sqrt((4*x)/(1-y)**2+1/(1-y)**4)+2*x)/2	401	generatingfunction
892	T	( 0  )	401	explicitformula
894	U	(1-sqrt(1-4*x))/(2*x*(1-y)**2)	402	generatingfunction
899	U	-1/((x-1/(1-y)**2)*(1-y)**4)	403	generatingfunction
903	U	x*(1-y)**2+1/(1-y)**2	404	generatingfunction
833	T	 binomial(k,m)*(-1)**(n+m)*binomial(n-m+k-1,n)	374	explicitformula
837	T	 (k*binomial(n/2+m,m)*((-1)**n+1)*binomial(n+2*m+k-1,n/2+m))/(2*(n/2+m+k))	376	explicitformula
835	T	k*((-1)**m+1)/2*(binomial(n+m/2,n))*binomial(k+2*n+m-1,n+m/2)/(k+n+m/2)	375	explicitformula
841	T	binomial(2*k,n+m)*binomial(n+m,n)	378	explicitformula
839	T	binomial(k,n)	377	explicitformula
855	T	 (binomial(k,n/2)*binomial(m+k-1,m)*((-1)**n+1))/2	385	explicitformula
843	T	0	379	explicitformula
845	T	0	380	explicitformula
847	T	0	381	explicitformula
849	T	0	382	explicitformula
851	T	0	383	explicitformula
853	T	0	384	explicitformula
857	T	 (binomial(k,m/2)*((-1)**m+1)*binomial(n+k-1,n))/2	386	explicitformula
859	T	(k*((-1)**n+1)*binomial(n+k,n/2)*binomial(n+m+k-1, m))/(2*(n+k))	387	explicitformula
861	T	(k*binomial(m+k,n/2)*binomial(2*m+k-1,m)*((-1)**n+ 1))/(2*(m+k))	388	explicitformula
870	T	(k*((-1)**m+1)*binomial(n+k,m/2)*binomial(2*n+k-1, n))/(2*(n+k))	391	explicitformula
863	T	0	389	explicitformula
872	T	1	392	explicitformula
866	T	 (binomial(k,n)*((-1)**m+1)*binomial(k-n,m/2))/2	390	explicitformula
873	T	(k*binomial(2*n+k-1,n)*binomial(3*n+2*k,m))/(n+k)	392	explicitformula
877	T	(k**2*binomial(2*m+k-1,m)*binomial(2*n+k-1,n))/((m +k)*(n+k))	394	explicitformula
881	T	binomial(k,n)	396	explicitformula
879	T	binomial(n+k-1,n)	395	explicitformula
883	T	binomial((-n)+m+k-1,m)*binomial(n+k-1,n)	397	explicitformula
885	T	 binomial(k,n)*binomial((-2*n)+m+k-1,m)	398	explicitformula
887	T	binomial(m+2*k-1,m)*binomial(n+2*k-1,n)	399	explicitformula
889	T	(2*k*binomial(2*(k-n)+m-1,m)*(-1)**(n-1)*binomial( 2*n-2*k-1,n-1))/n	400	explicitformula
893	T	 2*k*(binomial(2*(k-n)+m-1,m) )*(-1)**(n)*(binomial(2*n-2*k-1,n-1))/n	401	explicitformula
890	T	m+1	400	explicitformula
898	T	 (k*binomial(m+2*k-1,m)*binomial(2*n+k-1,n))/(n+k)	402	explicitformula
900	T	1	403	explicitformula
901	T	1	403	explicitformula
902	T	 binomial(2*(k-n)+m-1,m)*binomial(n+k-1,n)	403	explicitformula
906	T	binomial(k,n)*binomial(2*(k-2*n)+m-1,m)	404	explicitformula
1044	T	0	459	explicitformula
907	U	(sqrt(4*x*y**6-24*x*y**5+60*x*y**4-80*x*y**3+60*x*y**2-24*x*y+4*x+1)+1)/(2*y**2-4*y+2)	405	generatingfunction
910	U	(1-sqrt(4*x*y**6-24*x*y**5+60*x*y**4-80*x*y**3+60*x*y**2-24*x*y+4*x+1))/(2*y**2-4*y+2)	406	generatingfunction
911	T	( 0  )	406	explicitformula
913	U	(1-sqrt(4*x*y**3+12*x*y**2+12*x*y+4*x+1))/2	407	generatingfunction
914	T	( 0  )	407	explicitformula
916	U	1/((x+1)*(x*y+1))	408	generatingfunction
919	U	(sqrt(x**2*y**2+((-2*x**2)-2*x)*y+x**2-2*x+1)-x*y-x+1)/2	409	generatingfunction
922	U	(sqrt((4*x**2+4*x)*y+x**2+2*x+1)-x-1)/((2*x**2+2*x)*y)	410	generatingfunction
925	U	(sqrt((4*x**2+8*x+4)*y+1)+1)/(2*x+2)	411	generatingfunction
928	U	(1-sqrt((4*x**2+8*x+4)*y+1))/(2*x+2)	412	generatingfunction
931	U	(sqrt(y**2+(2*x+2)*y+x**2-2*x+1)+y-x+1)/2	413	generatingfunction
932	T	( 1  )	413	explicitformula
936	U	((-sqrt(y**2+(2*x+2)*y+x**2-2*x+1))+y-x+1)/2	414	generatingfunction
937	T	( 0  )	414	explicitformula
940	U	((1-sqrt(1-4*x))*(sqrt(4*y+1)+1))/(4*x)	415	generatingfunction
942	U	-(sqrt(4*y+1)+1)**2/(4*(x-(sqrt(4*y+1)+1)/2))	416	generatingfunction
944	U	(2*((sqrt(4*y+1)+1)**2/4+x))/(sqrt(4*y+1)+1)	417	generatingfunction
946	U	(sqrt((sqrt(4*y+1)+1)**4/16+2*x*(sqrt(4*y+1)+1))+(sqrt(4*y+1)+1)**2/4)/(sqrt(4*y+1)+1)	418	generatingfunction
948	U	((sqrt(4*y+1)+1)**2/4-sqrt((sqrt(4*y+1)+1)**4/16+2*x*(sqrt(4*y+1)+1)))/(sqrt(4*y+1)+1)	419	generatingfunction
950	U	(1/(1-y)+x)**2*(1-y)	420	generatingfunction
952	U	((-sqrt(((-4*x)-4)*y+1))-((-2*x**2)-2*x)*y+1)/(2*x**2*y**2+2*y)	421	generatingfunction
954	U	(y+x+1)**2/(y+1)	422	generatingfunction
956	U	((-sqrt((4*x**2+4*x)*y+1))-(2*x+2)*y+1)/(2*y**2-2*y)	423	generatingfunction
959	U	(((-2*x)-sqrt(1-4*x)+1)*(1-sqrt(1-4*y)))/(4*x**2*y)	424	generatingfunction
961	U	(2*((1-sqrt(1-4*y))/(2*y)+x)**2*y)/(1-sqrt(1-4*y))	425	generatingfunction
963	U	((x*sqrt(x*(4*(y+1)**2+27*x)))/(2*3**(3/2)*(y+1))+(y+1)**3/27+((3*x**2)/(y+1)+2*x*(y+1))/6)**(1/3)-((-(y+1)**2/9)-(2*x)/3)/((x*sqrt(x*(4*(y+1)**2+27*x)))/(2*3**(3/2)*(y+1))+(y+1)**3/27+((3*x**2)/(y+1)+2*x*(y+1))/6)**(1/3)+(y+1)/3	426	generatingfunction
966	U	1/(3*(1-y))+((x*sqrt(x*(4/(1-y)**2+27*x))*(1-y))/(2*3**(3/2))+(3*x**2*(1-y)+(2*x)/(1-y))/6+1/(27*(1-y)**3))**(1/3)+(1/(9*(1-y)**2)+(2*x)/3)/((x*sqrt(x*(4/(1-y)**2+27*x))*(1-y))/(2*3**(3/2))+(3*x**2*(1-y)+(2*x)/(1-y))/6+1/(27*(1-y)**3))**(1/3)	427	generatingfunction
968	U	(((6*x**2*y)/(1-sqrt(1-4*y))+(x*(1-sqrt(1-4*y)))/y)/6+(x*sqrt(x*((1-sqrt(1-4*y))**2/y**2+27*x))*y)/(3**(3/2)*(1-sqrt(1-4*y)))+(1-sqrt(1-4*y))**3/(216*y**3))**(1/3)-((-(1-sqrt(1-4*y))**2/(36*y**2))-(2*x)/3)/(((6*x**2*y)/(1-sqrt(1-4*y))+(x*(1-sqrt(1-4*y)))/y)/6+(x*sqrt(x*((1-sqrt(1-4*y))**2/y**2+27*x))*y)/(3**(3/2)*(1-sqrt(1-4*y)))+(1-sqrt(1-4*y))**3/(216*y**3))**(1/3)+(1-sqrt(1-4*y))/(6*y)	428	generatingfunction
970	U	(((-2*x)-sqrt(1-4*x)+1)*((-2*y)-sqrt(1-4*y)+1))/(4*x**2*y**2)	429	generatingfunction
972	U	(2*(((-2*y)-sqrt(1-4*y)+1)/(2*y**2)+x)**2*y**2)/((-2*y)-sqrt(1-4*y)+1)	430	generatingfunction
912	T	(-1)*k*((binomial(2*(k-3*n)+m-1,m))*(binomial(k-n-1,n-1)))/n	406	explicitformula
915	T	(k*(-1)**n*binomial(3*n,m)*binomial(2*n-k-1,n-1))/n	407	explicitformula
917	T	0	408	explicitformula
918	T	binomial(m+k-1,m)*(-1)**n*binomial(n-m+k-1,n-m)	408	explicitformula
921	T	(-1)**n*binomial(k,n)	409	explicitformula
920	T	1	409	explicitformula
923	T	0	410	explicitformula
924	T	 (k*binomial(2*m+k-1,m)*(-1)**n*binomial(n+k-1,n-m))/(m+k)	410	explicitformula
926	T	 (-1)**n*binomial(n+k-1,n)	411	explicitformula
927	T	(k*(binomial(k-m-1,m-1))*(-1)**n*(binomial(n-2*m+k-1,n))) /(m)	411	explicitformula
929	T	0	412	explicitformula
930	T	-(k*binomial((-m)+k-1,m-1)*( -1)**n*binomial(n-2*m+k-1,n))/m	412	explicitformula
933	T	1	413	explicitformula
934	T	 (-1)**n*binomial(k,n)	413	explicitformula
935	T	(k*(binomial(-m+k-1,n))*(binomial(k-n-1,m-1))*(-1)**n)/m	413	explicitformula
938	T	0	414	explicitformula
939	T	-(k*binomial((-m)+k -1,n)*binomial((-n)+k-1,m-1)*(-1)**n)/m	414	explicitformula
941	T	k/(n+k)*binomial(2*n+k-1,n)	415	explicitformula
943	T	 binomial(n+k-1,n)	416	explicitformula
945	T	binomial(k,n)	417	explicitformula
947	T	1	418	explicitformula
949	T	0	419	explicitformula
951	T	 binomial((-n)+m+k-1,m)*binomial(2*n+2*(k-n),n)	420	explicitformula
953	T	 (k*binomial(2*m+2*k,n)*binomial((-n)+2*m+k-1,m))/ (m+k)	421	explicitformula
955	T	binomial(2*k,n)*binomial(k-n,m)	422	explicitformula
957	T	1	423	explicitformula
958	T	(k*binomial(2*(m+k),n)*binomial((-n)+m+k,m))/(m+k)	423	explicitformula
960	T	(k**2*binomial(2*m+k-1,m)*binomial(2*n+2*k,n))/((m +k)*(n+k))	424	explicitformula
962	T	 (binomial(2*k,n)*(-1)^(m-1)*(k-n)*binomial(n-m-k-1,m-1))/m	425	explicitformula
964	T	binomial(k,m)	426	explicitformula
965	T	(2*k*binomial(2*(k-n)-1,n-1)*binomial(k-2*n,m))/n	426	explicitformula
971	T	(k**2*binomial(2*m+2*k,m)*binomial(2*n+2*k,n))/((m+k)*(n+k))	429	explicitformula
967	T	1	427	explicitformula
969	T	k/(m+k)*binomial(2*m+k-1,m)	428	explicitformula
973	T	(2*binomial((-2*n)+2*m+2*k-1,m-1)*(k-n)*binomial(2*n+2*(k-n),n))/m	430	explicitformula
974	U	(((6*x**2*y**2)/((-2*y)-sqrt(1-4*y)+1)+(x*((-2*y)-sqrt(1-4*y)+1))/y**2)/6+(x*sqrt(x*(((-2*y)-sqrt(1-4*y)+1)**2/y**4+27*x))*y**2)/(3**(3/2)*((-2*y)-sqrt(1-4*y)+1))+((-2*y)-sqrt(1-4*y)+1)**3/(216*y**6))**(1/3)-((-((-2*y)-sqrt(1-4*y)+1)**2/(36*y**4))-(2*x)/3)/(((6*x**2*y**2)/((-2*y)-sqrt(1-4*y)+1)+(x*((-2*y)-sqrt(1-4*y)+1))/y**2)/6+(x*sqrt(x*(((-2*y)-sqrt(1-4*y)+1)**2/y**4+27*x))*y**2)/(3**(3/2)*((-2*y)-sqrt(1-4*y)+1))+((-2*y)-sqrt(1-4*y)+1)**3/(216*y**6))**(1/3)+((-2*y)-sqrt(1-4*y)+1)/(6*y**2)	431	generatingfunction
976	U	((-2*x)-sqrt(1-4*x)+1)/(2*x**2*(1-y)**2)	432	generatingfunction
978	U	(x*(1-y)+1/(1-y))**2	433	generatingfunction
980	U	1/(3*(1-y)**2)+((3*x**2*(1-y)**2+(2*x)/(1-y)**2)/6+(x*sqrt(x*(4/(1-y)**4+27*x))*(1-y)**2)/(2*3**(3/2))+1/(27*(1-y)**6))**(1/3)+(1/(9*(1-y)**4)+(2*x)/3)/((3*x**2*(1-y)**2+(2*x)/(1-y)**2)/6+(x*sqrt(x*(4/(1-y)**4+27*x))*(1-y)**2)/(2*3**(3/2))+1/(27*(1-y)**6))**(1/3)	434	generatingfunction
983	U	((-2*x)-sqrt(1-4*x)+1)/(2*x**2*(1-y)**3)	435	generatingfunction
985	U	(1/(1-y)**3+x)**2*(1-y)**3	436	generatingfunction
987	U	(1-sqrt(1-4*x))/(2*x*(1-y)**3)	437	generatingfunction
989	U	-1/((x-1/(1-y)**3)*(1-y)**6)	438	generatingfunction
991	U	((-sqrt((y+1)**2+4*x))+y+1)/2	439	generatingfunction
993	U	(y+1)**2/(1-x)	440	generatingfunction
995	U	(1-sqrt((-4*x*y**2)-8*x*y-4*x+1))/(2*x)	441	generatingfunction
998	U	((-sqrt((4*x-4)*y+x**2-2*x+1))-2*y-x+1)/(2*y**2)	442	generatingfunction
999	T	 (1)	442	explicitformula
1002	U	y**2+2*y+x+1	443	generatingfunction
1004	U	((-sqrt((-4*x*y**2)-4*y+1))-2*y+1)/(2*y**2)	444	generatingfunction
1006	U	(sqrt(y**4+4*y**3+6*y**2+4*y+4*x+1)+y**2+2*y+1)/2	445	generatingfunction
1009	U	((-sqrt(y**4+4*y**3+6*y**2+4*y+4*x+1))+y**2+2*y+1)/2	446	generatingfunction
1013	U	(sqrt(x*(4*(y+1)**6+27*x))/(2*3**(3/2))+(y+1)**6/27+x/2)**(1/3)+(y+1)**4/(9*(sqrt(x*(4*(y+1)**6+27*x))/(2*3**(3/2))+(y+1)**6/27+x/2)**(1/3))+(y+1)**2/3	447	generatingfunction
1015	U	(sqrt(x*(4*(y+1)**3+27*x))/(2*3**(3/2))+(y+1)**3/27+x/2)**(1/3)+(y+1)**2/(9*(sqrt(x*(4*(y+1)**3+27*x))/(2*3**(3/2))+(y+1)**3/27+x/2)**(1/3))+(y+1)/3	448	generatingfunction
1017	U	(1/(1-y)+sqrt(1/(1-y)**2+4*x))/2	449	generatingfunction
1020	U	(1/(1-y)-sqrt(1/(1-y)**2+4*x))/2	450	generatingfunction
1022	U	1/(3*(1-y))+1/(9*(1/(27*(1-y)**3)+sqrt(x*(4/(1-y)**3+27*x))/(2*3**(3/2))+x/2)**(1/3)*(1-y)**2)+(1/(27*(1-y)**3)+sqrt(x*(4/(1-y)**3+27*x))/(2*3**(3/2))+x/2)**(1/3)	451	generatingfunction
1024	U	1/(1-y)**2+x	452	generatingfunction
1026	U	(sqrt(4*x*y**4-16*x*y**3+24*x*y**2-16*x*y+4*x+1)+1)/(2*y**2-4*y+2)	453	generatingfunction
1028	U	(sqrt(4*x**4*y-16*x**3*y+24*x**2*y-16*x*y+4*y+1)+1)/(2*x**2-4*x+2)	454	generatingfunction
1032	U	((1-sqrt(1-4*x))*(y+1)**2)/(2*x)	455	generatingfunction
1035	U	-(y+1)**2/((-y)+x-1)	456	generatingfunction
1036	T	 1	456	explicitformula
1039	U	-1/((x-1/sqrt(1-4*y))*(1-4*y))	457	generatingfunction
1041	U	((-4*x*y)+x+1)/sqrt(1-4*y)	458	generatingfunction
1043	U	(1-sqrt(sqrt(1-4*y)*(4*x-16*x*y)+1))/(2*sqrt(1-4*y))	459	generatingfunction
977	T	(k*binomial(m+2*k-1,m)*binomial(2*n+2*k,n))/(n+k)	432	explicitformula
979	T	binomial(2*k,n)*binomial(2*(k-n)+m-1,m)	433	explicitformula
981	T	1	434	explicitformula
984	T	(k*binomial(m+3*k-1,m)*binomial(2*n+2*k,n))/(n+k)	435	explicitformula
986	T	 binomial(2*k,n)*binomial(3*(k-n)+m-1,m)	436	explicitformula
988	T	(k*binomial(m+3*k-1,m)*binomial(2*n+k-1,n))/(n+k)	437	explicitformula
990	T	binomial(3*(k-n)+m-1,m)*binomial(n+k-1,n)	438	explicitformula
992	T	0	439	explicitformula
994	T	 binomial(2*k,m)*binomial(n+k-1,n)	440	explicitformula
996	T	1	441	explicitformula
997	T	 (k*binomial(2*(n+k),m)*binomial(2*n+k-1,n))/(n+k)	441	explicitformula
1000	T	1	442	explicitformula
1001	T	(k*binomial(2*(m+k),m)*binomial(n+m+k-1,n))/(m+k)	442	explicitformula
1003	T	 binomial(k,n)*binomial(2*k-2*n,m)	443	explicitformula
1005	T	(k*binomial(m+k,n)*binomial(2*(m+k)-2*n,m))/(m+k)	444	explicitformula
1014	T	1	447	explicitformula
1008	T	(k*binomial(2*k-4*n,m)*binomial((-n)+k-1,n-1))/n	445	explicitformula
1007	T	binomial(2*k,m) 	445	explicitformula
1011	T	0	446	explicitformula
1010	T	  -(k*binomial(2*k-4*n,m)*binomial((-n)+k-1,n-1))/n 	446	explicitformula
1018	T	1	449	explicitformula
1016	T	1	448	explicitformula
1019	T	(k*binomial((-2*n)+m+k-1,m)*binomial((-n)+k-1,n-1 ))/n	449	explicitformula
1021	T	0	450	explicitformula
1023	T	1	451	explicitformula
1025	T	binomial(k,n)*binomial((-2*n)+m+2*k-1,m)	452	explicitformula
1037	T	1	456	explicitformula
1027	T	binomial(m+2*k-1,m)	453	explicitformula
1040	T	4**m*binomial((k-n)/2+m-1,m)*binomial(n+k-1,n)	457	explicitformula
1034	T	(k*binomial(2*k,m)*binomial(2*n+k-1,n))/(n+k)	455	explicitformula
1031	T	1	454	explicitformula
1030	T	  binomial(n+2*k-1,n) 	454	explicitformula
1029	T	(k*binomial((-m)+k-1,m-1)*binomial(n-4*m+2*k-1,n) )/m	454	explicitformula
1033	T	1	455	explicitformula
1038	T	 binomial(k-n,m)*binomial(n+k-1,n)	456	explicitformula
1042	T	1	458	explicitformula
1045	U	1/(3*sqrt(1-4*y))+1/(9*((sqrt(x*(4/(1-4*y)**2+27*x))*sqrt(1-4*y))/(2*3**(3/2))+(x*sqrt(1-4*y))/2+1/(27*(1-4*y)**(3/2)))**(1/3)*(1-4*y))+((sqrt(x*(4/(1-4*y)**2+27*x))*sqrt(1-4*y))/(2*3**(3/2))+(x*sqrt(1-4*y))/2+1/(27*(1-4*y)**(3/2)))**(1/3)	460	generatingfunction
1048	U	((-sqrt((y+1)**2+4*x*(y+1)))+y+1)/(2*x)	461	generatingfunction
1050	U	(((y+1)*sqrt(x*(4*(y+1)**2+27*x)))/(2*3**(3/2))+(y+1)**3/27+(x*(y+1))/2)**(1/3)+(y+1)**2/(9*(((y+1)*sqrt(x*(4*(y+1)**2+27*x)))/(2*3**(3/2))+(y+1)**3/27+(x*(y+1))/2)**(1/3))+(y+1)/3	462	generatingfunction
1052	U	(1/(1-y)+sqrt((4*x)/(1-y)+1/(1-y)**2))/2	463	generatingfunction
1054	U	(1/(1-y)-sqrt((4*x)/(1-y)+1/(1-y)**2))/2	464	generatingfunction
1056	U	1/(3*(1-y))+1/(9*(sqrt(x*(4/(1-y)**2+27*x))/(2*3**(3/2)*(1-y))+x/(2*(1-y))+1/(27*(1-y)**3))**(1/3)*(1-y)**2)+(sqrt(x*(4/(1-y)**2+27*x))/(2*3**(3/2)*(1-y))+x/(2*(1-y))+1/(27*(1-y)**3))**(1/3)	465	generatingfunction
1058	U	(x+1)*(y+1)**2	466	generatingfunction
1061	U	((-y**2)-2*y-1)/(x*y**2+2*x*y+x-1)	467	generatingfunction
1063	U	(1-sqrt((-4*x*y**4)-16*x*y**3-24*x*y**2-16*x*y-4*x+1))/(2*x*y**2+4*x*y+2*x)	468	generatingfunction
1065	U	(sqrt((y+1)**4+4*x*(y+1)**2)+(y+1)**2)/2	469	generatingfunction
1067	U	((y+1)**2-sqrt((y+1)**4+4*x*(y+1)**2))/2	470	generatingfunction
1069	U	(((y+1)**2*sqrt(x*(4*(y+1)**4+27*x)))/(2*3**(3/2))+(y+1)**6/27+(x*(y+1)**2)/2)**(1/3)+(y+1)**4/(9*(((y+1)**2*sqrt(x*(4*(y+1)**4+27*x)))/(2*3**(3/2))+(y+1)**6/27+(x*(y+1)**2)/2)**(1/3))+(y+1)**2/3	471	generatingfunction
1072	U	(sqrt(1-4*y)-sqrt((-4*y)-4*x+1))/(2*x)	472	generatingfunction
1076	U	(1/sqrt(1-4*y)-sqrt((4*x)/sqrt(1-4*y)+1/(1-4*y)))/2	473	generatingfunction
1078	U	1/(3*sqrt(1-4*y))+1/(9*(sqrt(x*(4/(1-4*y)+27*x))/(2*3**(3/2)*sqrt(1-4*y))+x/(2*sqrt(1-4*y))+1/(27*(1-4*y)**(3/2)))**(1/3)*(1-4*y))+(sqrt(x*(4/(1-4*y)+27*x))/(2*3**(3/2)*sqrt(1-4*y))+x/(2*sqrt(1-4*y))+1/(27*(1-4*y)**(3/2)))**(1/3)	474	generatingfunction
1080	U	((1-sqrt(1-4*y))/(2*y)+sqrt((2*x*(1-sqrt(1-4*y)))/y+(1-sqrt(1-4*y))**2/(4*y**2)))/2	475	generatingfunction
1082	U	((1-sqrt(1-4*y))/(2*y)-sqrt((2*x*(1-sqrt(1-4*y)))/y+(1-sqrt(1-4*y))**2/(4*y**2)))/2	476	generatingfunction
1090	U	((-2*y)-sqrt(1-4*y)+1)/(2*y**2+x*(2*y+sqrt(1-4*y)-1))	478	generatingfunction
1091	T	( 0  )	478	explicitformula
1094	U	(((-2*y)-sqrt(1-4*y)+1)/(2*y**2)+sqrt((2*x*((-2*y)-sqrt(1-4*y)+1))/y**2+((-2*y)-sqrt(1-4*y)+1)**2/(4*y**4)))/2	479	generatingfunction
1097	U	(((-2*y)-sqrt(1-4*y)+1)/(2*y**2)-sqrt((2*x*((-2*y)-sqrt(1-4*y)+1))/y**2+((-2*y)-sqrt(1-4*y)+1)**2/(4*y**4)))/2	480	generatingfunction
1098	T	( 0  )	480	explicitformula
1101	U	((-2*y)-sqrt(1-4*y)+1)/(6*y**2)+((-2*y)-sqrt(1-4*y)+1)**2/(36*((sqrt(x*(((-2*y)-sqrt(1-4*y)+1)**2/y**4+27*x))*((-2*y)-sqrt(1-4*y)+1))/(4*3**(3/2)*y**2)+(x*((-2*y)-sqrt(1-4*y)+1))/(4*y**2)+((-2*y)-sqrt(1-4*y)+1)**3/(216*y**6))**(1/3)*y**4)+((sqrt(x*(((-2*y)-sqrt(1-4*y)+1)**2/y**4+27*x))*((-2*y)-sqrt(1-4*y)+1))/(4*3**(3/2)*y**2)+(x*((-2*y)-sqrt(1-4*y)+1))/(4*y**2)+((-2*y)-sqrt(1-4*y)+1)**3/(216*y**6))**(1/3)	481	generatingfunction
1049	T	(k*(-1)**(n+m+k)*binomial(n+m-1,m)*binomial(2*n+k-1,n))/(n+k)	461	explicitformula
1046	T	k*4**m*(binomial((3*n-k)/2-1,m-1)*(-1)**(m-1))/(2*m)	460	explicitformula
1051	T	1	462	explicitformula
1053	T	binomial(m+k-1,m)	463	explicitformula
1055	T	0	464	explicitformula
1057	T	1	465	explicitformula
1086	U	(1-sqrt(1-4*y))/(6*y)+(1-sqrt(1-4*y))**2/(36*((x*( 1-sqrt(1-4*y)))/(4*y)+((1-sqrt(1-4*y))*sqrt(x*((1 -sqrt(1-4*y))^2/y**2+27*x)))/(4*3^(3/2)*y)+(1-sqrt (1-4*y))**3/(216*y^3))**(1/3)*y**2)+((x*(1-sqrt(1-4*y)))/(4*y)+((1-sqrt(1-4*y))*sqrt(x*((1-sqrt(1-4*y ))**2/y**2+27*x)))/(4*3**(3/2)*y)+(1-sqrt(1-4*y))**3/ (216*y**3))**(1/3)	477	generatingfunction
1060	T	 binomial(k,n)*binomial(2*k,m)	466	explicitformula
1062	T	binomial(n+k-1,n)*binomial(2*(n+k),m)	467	explicitformula
1064	T	(k*binomial(2*n+k-1,n)*binomial(2*(2*n+k),m))/(n+ k)	468	explicitformula
1068	T	0	470	explicitformula
1066	T	binomial(2*k,m)	469	explicitformula
1070	T	1	471	explicitformula
1071	T	2*binomial(2*(k-n)-1,m-1)*k/m	471	explicitformula
1073	T	1	472	explicitformula
1074	T	1	472	explicitformula
1077	T	0	473	explicitformula
1075	T	 (k*4**m*binomial(2*n+k-1,n)*binomial((2*n+k)/2+m-1 ,m))/(n+k)	472	explicitformula
1079	T	1	474	explicitformula
1081	T	1	475	explicitformula
1083	T	 0	476	explicitformula
1084	T	-(k*(-1)**(n-1 )*binomial(2*n-k-1,n-1))/n	476	explicitformula
1089	T	k*((binomial(3*n-k-1,n-1))*(-1)**(n-1))/n	477	explicitformula
1085	T	-(k*(-1)**(m-1)*binomial(k-n,n)*binomial(n-m-k-1,m-1)/m)	476	explicitformula
1093	T	(k*binomial(n+k,n)*binomial(2*(n+k)+2*m,m))/(n+m+ k)	478	explicitformula
1096	T	1	479	explicitformula
1105	T	2*binomial(k-2*n,n)*binomial(2*m+2*k-4*n-1,m-1)*k/m	481	explicitformula
1092	T	0	478	explicitformula
1099	T	-(k*(-1)**(n-1 )*binomial(2*n-k-1,n-1))/n	480	explicitformula
1095	T	(2*k*binomial((-2*n)+2*m+2*k-1,m-1)*binomial(k-n, n))/m	479	explicitformula
1100	T	-2*binomial(k-n,n)*binomial(2*m+2*k-2*n-1,m-1)*k/m	480	explicitformula
1104	T	1	481	explicitformula
1102	T	(2*k*binomial((-4*n)+2*m+2*k-1,m-1)*binomial(k-2* n,n))/m	481	explicitformula
1087	T	(k*(-1)^(m-1)*binomial(k-2*n,n)*binomial(2*n-m-k- 1,m-1))/m	477	explicitformula
1103	T	(k*((binomial(3*n-k-1,n-1))*(-1)^(n-1))	481	explicitformula
1088	T	(k*(-1)**(m-1)*binomial(k-2*n,n)*binomial(2*n-m-k- 1,m-1))/m	477	explicitformula
1106	U	(sqrt((sqrt(4*y+1)+1)**2/4+2*x*(sqrt(4*y+1)+1))+(sqrt(4*y+1)+1)/2)/2	482	generatingfunction
1107	T	( 0  )	482	explicitformula
1110	U	((sqrt(4*y+1)+1)/2-sqrt((sqrt(4*y+1)+1)**2/4+2*x*(sqrt(4*y+1)+1)))/2	483	generatingfunction
1115	U	(((sqrt(4*y+1)+1)*sqrt(x*((sqrt(4*y+1)+1)**2+27*x)))/(4*3**(3/2))+(sqrt(4*y+1)+1)**3/216+(x*(sqrt(4*y+1)+1))/4)**(1/3)+(sqrt(4*y+1)+1)**2/(36*(((sqrt(4*y+1)+1)*sqrt(x*((sqrt(4*y+1)+1)**2+27*x)))/(4*3**(3/2))+(sqrt(4*y+1)+1)**3/216+(x*(sqrt(4*y+1)+1))/4)**(1/3))+(sqrt(4*y+1)+1)/6	484	generatingfunction
1117	U	(sqrt(4*y+1)+1)/2+x	485	generatingfunction
1119	U	(sqrt((sqrt(4*y+1)+1)**2/4+4*x)+(sqrt(4*y+1)+1)/2)/2	486	generatingfunction
1124	U	((sqrt(4*y+1)+1)/2-sqrt((sqrt(4*y+1)+1)**2/4+4*x))/2	487	generatingfunction
1129	U	(sqrt(x*((sqrt(4*y+1)+1)**3/2+27*x))/(2*3**(3/2))+(sqrt(4*y+1)+1)**3/216+x/2)**(1/3)+(sqrt(4*y+1)+1)**2/(36*(sqrt(x*((sqrt(4*y+1)+1)**3/2+27*x))/(2*3**(3/2))+(sqrt(4*y+1)+1)**3/216+x/2)**(1/3))+(sqrt(4*y+1)+1)/6	488	generatingfunction
1132	U	1/((1-x)*(1-y)**2)	489	generatingfunction
1135	U	(sqrt(y**2-2*y-4*x+1)+y-1)/(2*x*y-2*x)	490	generatingfunction
1140	U	((-sqrt((4-4*x)*y+1))-(2-2*x)*y-1)/(2*x-2)	491	generatingfunction
1143	U	1/(3*(1-y)**2)+1/(9*(1/(27*(1-y)**6)+sqrt(x*(4/(1-y)**6+27*x))/(2*3**(3/2))+x/2)**(1/3)*(1-y)**4)+(1/(27*(1-y)**6)+sqrt(x*(4/(1-y)**6+27*x))/(2*3**(3/2))+x/2)**(1/3)	492	generatingfunction
1146	U	(sqrt((-16*x*y)+4*x+1)+1)/(2*sqrt(1-4*y))	493	generatingfunction
1156	U	((-sqrt((-4*x*y)+x**2+2*x+1))+2*x*y-x-1)/(2*y-2)	495	generatingfunction
1161	U	(sqrt((-4*x*y)+x**2+2*x+1)+2*x*y-x-1)/(2*y-2)	496	generatingfunction
1162	T	( 1  )	496	explicitformula
1163	T	( (k*(binomial(3*m+k-1,m)))/(2*m+k)  )	496	explicitformula
1164	T	( k*((binomial(2*n-k-1,n-1))*(-1)**(n-1))/n  )	496	explicitformula
1165	T	 (k*(binomial(k-n-1,n-1))*(k-2*n)*(binomial(-2*m+2*n-k-1,m-1)*(-1)**(m-1)))/(n*m)  	496	explicitformula
1166	U	(1-sqrt(1-4*y))/(6*y)+(1-sqrt(1-4*y))**2/(36*((1-sqrt(1-4*y))**3/(216*y**3)+sqrt(x*((1-sqrt(1-4*y))**3/(2*y**3)+27*x))/(2*3**(3/2))+x/2)**(1/3)*y**2)+((1-sqrt(1-4*y))**3/(216*y**3)+sqrt(x*((1-sqrt(1-4*y))**3/(2*y**3)+27*x))/(2*3**(3/2))+x/2)**(1/3)	497	generatingfunction
1167	T	( 0  )	497	explicitformula
1168	T	( k*((binomial(2*n-k-1,n-1))*(-1)**(n))/n  )	497	explicitformula
1169	T	 (k*(binomial(k-n-1,n-1))*(k-2*n)*(binomial(-2*m+2*n-k-1,m-1)*(-1)**m))/(n)/m  	497	explicitformula
1170	U	((-2*y)-sqrt(1-4*y)+1)/(6*y**2)+((-2*y)-sqrt(1-4*y)+1)**2/(36*(((-2*y)-sqrt(1-4*y)+1)**3/(216*y**6)+sqrt(x*(((-2*y)-sqrt(1-4*y)+1)**3/(2*y**6)+27*x))/(2*3**(3/2))+x/2)**(1/3)*y**4)+(((-2*y)-sqrt(1-4*y)+1)**3/(216*y**6)+sqrt(x*(((-2*y)-sqrt(1-4*y)+1)**3/(2*y**6)+27*x))/(2*3**(3/2))+x/2)**(1/3)	498	generatingfunction
1171	T	( binomial(k,m)*binomial(n+2*m+2*k-1,n)  )	498	explicitformula
1172	U	(sqrt(4*y+1)+1)/(2*(1-x)**2)	499	generatingfunction
1173	T	( 0  )	499	explicitformula
1111	T	0	483	explicitformula
1128	T	-(k*((binomial(2*m+2*n-k-1,m-1))*(-1)^(m-1)))/m*binomial(k-n-1,n)	487	explicitformula
1114	T	0	483	explicitformula
1116	T	1	484	explicitformula
1118	T	1	485	explicitformula
1121	T	0	486	explicitformula
1123	T	(k*((binomial(2*m+2*n-k-1,m-1))*( -1)**(m-1)))/m*binomial(k-n-1,n)	486	explicitformula
1130	T	1	488	explicitformula
1131	T	binomial(k-2*n-1 ,n-1)*k/(n)	488	explicitformula
1134	T	binomial(m+2*k-1,m)*binomial(n+k-1,n)	489	explicitformula
1133	T	( 1 )	489	explicitformula
1141	T	1	491	explicitformula
1112	T	-k*binomial(k-n-1,n-1)/n	483	explicitformula
1142	T	(2*k*((binomial(2*m-2*k-1,m-1))*(-1)**(m-1)))/m	491	explicitformula
1145	T	2*binomial(2*n-2*k -1,m-1)*k/m*(-1)**(m-1)	492	explicitformula
1144	T	1	492	explicitformula
1120	T	1	486	explicitformula
1122	T	binomial(k-n-1,n -1)*k/(n)	486	explicitformula
1125	T	0	487	explicitformula
1127	T	 -binomial(k-n-1,n-1)*k/(n)	487	explicitformula
1158	T	0	495	explicitformula
1136	T	0	490	explicitformula
1137	T	0	490	explicitformula
1150	T	0	493	explicitformula
1148	T	1	493	explicitformula
1138	T	(k*binomial(2*n+k-1,n)*binomial(2*(n+k)+m-1,m))/( n+k)	490	explicitformula
1139	T	0	490	explicitformula
1160	T	(k*(binomial(-m+k-1,n))*(binomial(n-k-1,m-1)*(-1)^(m-1)))/(m)	495	explicitformula
1157	T	binomial(k,n)	495	explicitformula
1147	T	(binomial(m+(k)/2-1,m))*4**m	493	explicitformula
1126	T	0	487	explicitformula
1149	T	(k*4**m*(binomial((k-2*n)/2+m-1,m))*(binomial(k-n-1,n- 1)))/(n)	493	explicitformula
1159	T	binomial(k,n)	495	explicitformula
1174	T	( -2*binomial(2*n-2*k-1,n-1)*(-1)**(n-1)*k/n  )	499	explicitformula
1175	T	 -(k*((binomial(2*m+n-k-1,m-1))*(-1)**(m-1)))/m*(binomial(2*k-n-1,n))  	499	explicitformula
1176	U	(y+x**2-2*x+1)/(x**4-4*x**3+6*x**2-4*x+1)	500	generatingfunction
1177	T	( 1  )	500	explicitformula
1178	T	( (2*k*((binomial(2*n-2*k-1,n-1))*(-1)**(n-1)))/n  )	500	explicitformula
1179	T	 (2*k*((binomial(2*n-2*k-1,n-1))*(-1)**(n-1)))/n  	500	explicitformula
1180	T	 (k*(binomial(k-n-1,m-1))*(binomial(n+2*(k-n)-1,n)))/(m)  	500	explicitformula
1181	U	((-x**2)+2*x-1)/(y-x**4+4*x**3-6*x**2+4*x-1)	501	generatingfunction
1182	T	( 0  )	501	explicitformula
1183	T	( -(2*k*((binomial(2*n-2*k-1,n-1))*(-1)**(n-1)))/n  )	501	explicitformula
1184	T	 -(k*(binomial(k-n-1,m-1))*(binomial(n+2*(k-n)-1,n)))/(m)  	501	explicitformula
1185	U	((x-1)*sqrt((-4*y)+x**6-6*x**5+15*x**4-20*x**3+15*x**2-6*x+1)+x**4-4*x**3+6*x**2-4*x+1)/(2*y)	502	generatingfunction
1186	T	( binomial(2*k,m)*binomial(n+2*k-1,n)  )	502	explicitformula
1187	U	(sqrt((sqrt(4*y+1)+1)**2/4+2*x*(sqrt(4*y+1)+1))+(sqrt(4*y+1)+1)/2+2*x)/2	503	generatingfunction
1188	T	( (k*binomial(2*(m+k),m)*binomial(n+2*(m+k)-1,n))/(m+k)  )	503	explicitformula
1189	U	((-sqrt((sqrt(4*y+1)+1)**2/4+2*x*(sqrt(4*y+1)+1)))+(sqrt(4*y+1)+1)/2+2*x)/2	504	generatingfunction
1190	T	( 1  )	504	explicitformula
1191	T	( (2*k*((binomial(2*n-2*k-1,n-1))*(-1)**(n-1)))/n  )	504	explicitformula
1192	T	 (2*k*((binomial(2*n-2*k-1,n-1))*(-1)**(n-1)))/n  	504	explicitformula
1193	T	 (2*k*binomial(2*(k-n)-1,m-1)*(binomial(n+2*(k-n)-1,n)))/(m)  	504	explicitformula
1194	U	(sqrt((y+1)**2+4*x*(y+1))+y+2*x+1)/2	505	generatingfunction
1195	T	( 0  )	505	explicitformula
1196	T	( -(2*k*((binomial(2*n-2*k-1,n-1))*(-1)**(n-1)))/n  )	505	explicitformula
1197	T	 -(2*k*binomial(2*(k-n)-1,m-1)*(binomial(n+2*(k-n)-1,n)))/m  	505	explicitformula
1198	U	((-sqrt((y+1)**2+4*x*(y+1)))+y+2*x+1)/2	506	generatingfunction
1199	T	( 1  )	506	explicitformula
1200	T	( (2*k*((binomial(2*n-2*k-1,n-1))*(-1)**(n-1)))/n  )	506	explicitformula
1201	T	 (2*k*((binomial(2*n-2*k-1,n-1))*(-1)**(n-1)))/n  	506	explicitformula
1202	T	 (k*(binomial(n-k-1,m-1))*(-1)**(m-1)*(binomial(n+2*(k-n)-1,n)))/(m)  	506	explicitformula
1203	U	(y+1)**2/(1-x)**2	507	generatingfunction
1204	T	( 0  )	507	explicitformula
1205	T	( -(2*k*((binomial(2*n-2*k-1,n-1))*(-1)**(n-1)))/n  )	507	explicitformula
1206	T	 -(k*(binomial(n-k-1,m-1))*(-1)**(m-1)*(binomial(n+2*(k-n)-1,n)))/m  	507	explicitformula
1207	U	((-2*y)+(x-1)*sqrt((-4*y)+x**2-2*x+1)+x**2-2*x+1)/(2*y**2)	508	generatingfunction
1208	T	( binomial(m+3*k-1,m)*binomial(n+2*k-1,n)  )	508	explicitformula
1209	U	(sqrt((y+1)**4+4*x*(y+1)**2)+(y+1)**2+2*x)/2	509	generatingfunction
1210	T	( 1  )	509	explicitformula
1211	T	( (2*k*((binomial(2*n-2*k-1,n-1))*(-1)**(n-1)))/n  )	509	explicitformula
1212	T	 (2*k*((binomial(2*n-2*k-1,n-1))*(-1)**(n-1)))/n  	509	explicitformula
1213	T	 k*3*binomial(-3*(k-n)-1,m-1)*(-1)**(m-1)/m*binomial(n+2*(k-n)-1,n)  	509	explicitformula
1214	U	((-sqrt((y+1)**4+4*x*(y+1)**2))+(y+1)**2+2*x)/2	510	generatingfunction
1215	T	( 0  )	510	explicitformula
1216	T	( -(2*k*((binomial(2*n-2*k-1,n-1))*(-1)**(n-1)))/n  )	510	explicitformula
1217	T	 -k*3*binomial(-3*(k-n)-1,m-1)*(-1)**(m-1)/m*binomial(n+2*(k-n)-1,n)  	510	explicitformula
1218	U	(1/(1-y)+sqrt((4*x)/(1-y)+1/(1-y)**2)+2*x)/2	511	generatingfunction
1219	T	( 1  )	511	explicitformula
1220	T	( (2*k*((binomial(2*n-2*k-1,n-1))*(-1)**(n-1)))/n  )	511	explicitformula
1221	T	 (2*k*((binomial(2*n-2*k-1,n-1))*(-1)**(n-1)))/n  	511	explicitformula
1222	T	 binomial(2*k-n-1,n)*(k)*binomial(n-m-k-1,m-1)/(m)*(-1)**(m-1)  	511	explicitformula
1223	U	(1/(1-y)-sqrt((4*x)/(1-y)+1/(1-y)**2)+2*x)/2	512	generatingfunction
1224	T	( 0  )	512	explicitformula
1225	T	( (-2*k*((binomial(2*n-2*k-1,n-1))*(-1)**(n-1)))/n  )	512	explicitformula
1226	T	 -binomial(2*k-n-1,n)*(k)*binomial(n-m-k-1,m-1)/(m)*(-1)**(m-1)  	512	explicitformula
1227	U	1/((1-x)**2*(1-y)**3)	513	generatingfunction
1228	T	( (k*binomial((-n)+m+k,m)*binomial(n+m+k-1,n))/(m+k)  )	513	explicitformula
1229	U	(1/(1-y)**3+sqrt((4*x)/(1-y)**3+1/(1-y)**6)+2*x)/2	514	generatingfunction
1230	T	( binomial(k,n)*binomial(k-2*n,m)  )	514	explicitformula
1231	U	(1/(1-y)**3-sqrt((4*x)/(1-y)**3+1/(1-y)**6)+2*x)/2	515	generatingfunction
1232	T	( binomial(k,m)  )	515	explicitformula
1233	T	 (binomial(k-n-1,n-1))*(binomial(k-3*n,m))*k/n  	515	explicitformula
1234	U	((1-sqrt(1-4*y))/(2*y)+sqrt((2*x*(1-sqrt(1-4*y)))/y+(1-sqrt(1-4*y))**2/(4*y**2))+2*x)/2	516	generatingfunction
1235	T	( 0  )	516	explicitformula
1236	T	 -(binomial(k-n-1,n-1))*(binomial(k-3*n,m))*k/(n)  	516	explicitformula
1237	U	((1-sqrt(1-4*y))/(2*y)-sqrt((2*x*(1-sqrt(1-4*y)))/y+(1-sqrt(1-4*y))**2/(4*y**2))+2*x)/2	517	generatingfunction
1238	T	( 1  )	517	explicitformula
1239	T	( binomial(k,m)  )	517	explicitformula
1240	T	 binomial(k,m)  	517	explicitformula
1241	T	 (binomial(k-2*n-1,n-1))*(binomial(k-4*n,m))*k/(n)  	517	explicitformula
1242	U	((-sqrt(4*x*y+x**2-2*x+1))-2*y-x+1)/(2*y**2-2*y)	518	generatingfunction
1243	T	( binomial(m+k-1,m)  )	518	explicitformula
1244	T	 (m*((binomial(3*n-m-1,n-1))*(-1)**(n-1)))/n*binomial(m+k-1,m)  	518	explicitformula
1245	U	((y+1)**2+x)/(y+1)	519	generatingfunction
1246	T	( binomial(2*(k-n),m)*binomial(n+k-1,n)  )	519	explicitformula
1247	U	(sqrt((y+1)**4+4*x*(y+1))+(y+1)**2)/(2*(y+1))	520	generatingfunction
1248	T	( binomial(k,n)*binomial(2*(k-2*n),m)  )	520	explicitformula
1249	U	((y+1)**2-sqrt((y+1)**4+4*x*(y+1)))/(2*(y+1))	521	generatingfunction
1250	T	( 1  )	521	explicitformula
1251	T	( binomial(2*k,m)  )	521	explicitformula
1252	T	 binomial(2*k,m)  	521	explicitformula
1253	T	 (k*(binomial(2*(k-3*n),m))*(binomial(k-n-1,n-1)))/(n)  	521	explicitformula
1254	U	(sqrt(x*(4*(y+1)**4+27*x))/(2*3**(3/2)*(y+1))+(y+1)**3/27+x/(2*(y+1)))**(1/3)+(y+1)**2/(9*(sqrt(x*(4*(y+1)**4+27*x))/(2*3**(3/2)*(y+1))+(y+1)**3/27+x/(2*(y+1)))**(1/3))+(y+1)/3	522	generatingfunction
1255	T	( 0  )	522	explicitformula
1256	T	 -(k*(binomial(2*(k-3*n),m))*(binomial(k-n-1,n-1)))/(n)  	522	explicitformula
1257	U	-(y+1)**4/(x-(y+1)**2)	523	generatingfunction
1258	T	( binomial(m+k-1,m)  )	523	explicitformula
1259	T	 (k*(binomial(-3*n+m+k-1,m))*(binomial(k-n-1,n-1)))/n  	523	explicitformula
1260	U	((y+1)**4+x)/(y+1)**2	524	generatingfunction
1261	T	( 0  )	524	explicitformula
1262	T	 -(k*(binomial(-3*n+m+k-1,m))*(binomial(k-n-1,n-1)))/n  	524	explicitformula
1263	U	(sqrt((y+1)**8+4*x*(y+1)**2)+(y+1)**4)/(2*(y+1)**2)	525	generatingfunction
1264	T	( 1  )	525	explicitformula
1265	T	( binomial(n-k-1,m-1)*(-1)**(m-1)*k/(m)  )	525	explicitformula
1266	T	 binomial(n-k-1,m-1)*(-1)**(m-1)*k/(m)  	525	explicitformula
1267	T	 (k*(binomial(-4*n+m+k-1,m))*(binomial(k-2*n-1,n-1)))/n  	525	explicitformula
1268	U	((y+1)**4-sqrt((y+1)**8+4*x*(y+1)**2))/(2*(y+1)**2)	526	generatingfunction
1269	T	( 0  )	526	explicitformula
1270	T	 k*((binomial(2*(k-3*n)+m-1,m))*(binomial(k-n-1,n-1)))/n  	526	explicitformula
1271	U	(sqrt(x*(4*(y+1)**8+27*x))/(2*3**(3/2)*(y+1)**2)+(y+1)**6/27+x/(2*(y+1)**2))**(1/3)+(y+1)**4/(9*(sqrt(x*(4*(y+1)**8+27*x))/(2*3**(3/2)*(y+1)**2)+(y+1)**6/27+x/(2*(y+1)**2))**(1/3))+(y+1)**2/3	527	generatingfunction
1272	T	( 1  )	527	explicitformula
1273	T	( 2*binomial(2*n-2*k-1,m-1)*(-1)**(m-1)*k/m  )	527	explicitformula
1274	T	 2*binomial(2*n-2*k-1,m-1)*(-1)**(m-1)*k/m  	527	explicitformula
1275	T	 k*((binomial(2*(k-4*n)+m-1,m))*(binomial(k-2*n-1,n-1)))/n  	527	explicitformula
1276	U	((1/(1-y)**2+sqrt((4*x)/(1-y)+1/(1-y)**4))*(1-y))/2	528	generatingfunction
1277	T	( (k/(k+m))*binomial(2*m+k-1,m)  )	528	explicitformula
1278	T	 (k/(k+m))*(m*((binomial(3*n-m-1,n-1))*(-1)**(n-1)))/n*binomial(2*m+k-1,m)  	528	explicitformula
1279	U	((1/(1-y)**2-sqrt((4*x)/(1-y)+1/(1-y)**4))*(1-y))/2	529	generatingfunction
1280	T	( binomial(k,m)  )	529	explicitformula
1281	T	 (m*((binomial(3*n-m-1,n-1))*(-1)**(n-1)))/n*binomial(k,m)  	529	explicitformula
1282	U	1/(3*(1-y))+1/(9*((sqrt(x*(4/(1-y)**4+27*x))*(1-y))/(2*3**(3/2))+(x*(1-y))/2+1/(27*(1-y)**3))**(1/3)*(1-y)**2)+((sqrt(x*(4/(1-y)**4+27*x))*(1-y))/(2*3**(3/2))+(x*(1-y))/2+1/(27*(1-y)**3))**(1/3)	530	generatingfunction
1283	T	( 1  )	530	explicitformula
1284	T	( k*binomial(2*m-k-1,m-1)*(-1)**(m-1)/m  )	530	explicitformula
1285	T	 k*binomial(2*m-k-1,m-1)*(-1)**(m-1)/m  	530	explicitformula
1286	T	 binomial(3*n-m-1,n-1)*(-1)**(n-1)/n*k*binomial(2*m-k-1,m-1)*(-1)**(m-1)  	530	explicitformula
1287	U	(1-sqrt((-4*x*y**4)-16*x*y**3-24*x*y**2-16*x*y-4*x+1))/(2*x*y+2*x)	531	generatingfunction
1288	T	( 1  )	531	explicitformula
1289	T	( (k*((binomial(3*n-k-1,n-1))*(-1)**(n-1)))/n  )	531	explicitformula
1290	T	( (k*((binomial(2*m+n-k-1,m-1))*(-1)**(m-1)))/m  )	531	explicitformula
1291	T	 ((k-4*n)*((binomial(2*m+4*n-k-1,m-1))*(-1)**(m-1)))/m*binomial(k-2*n-1,n-1)*k/n  	531	explicitformula
1292	U	1/(3*(1-y)**2)+1/(9*((sqrt(x*(4/(1-y)**8+27*x))*(1-y)**2)/(2*3**(3/2))+(x*(1-y)**2)/2+1/(27*(1-y)**6))**(1/3)*(1-y)**4)+((sqrt(x*(4/(1-y)**8+27*x))*(1-y)**2)/(2*3**(3/2))+(x*(1-y)**2)/2+1/(27*(1-y)**6))**(1/3)	532	generatingfunction
1293	T	( k/(n+k)*binomial(2*n+k-1,n)  )	532	explicitformula
1294	T	 (k*((binomial(3*m-k-1,m-1))*(-1)**(m-1)))/m*k/(n+k)*binomial(2*n+k-1,n)  	532	explicitformula
1295	U	(sqrt(x*((sqrt(4*y+1)+1)**4/4+27*x))/(3**(3/2)*(sqrt(4*y+1)+1))+(sqrt(4*y+1)+1)**3/216+x/(sqrt(4*y+1)+1))**(1/3)+(sqrt(4*y+1)+1)**2/(36*(sqrt(x*((sqrt(4*y+1)+1)**4/4+27*x))/(3**(3/2)*(sqrt(4*y+1)+1))+(sqrt(4*y+1)+1)**3/216+x/(sqrt(4*y+1)+1))**(1/3))+(sqrt(4*y+1)+1)/6	533	generatingfunction
1296	T	( 0  )	533	explicitformula
1297	T	( -k*binomial(k-n-1,n-1)/n  )	533	explicitformula
1298	T	 -(((binomial(3*m+3*n-k-1,m-1))*(-1)**(m-1)))/m*(k-3*n)*binomial(k-n-1,n-1)*k/n  	533	explicitformula
1299	U	(((-2*x)-sqrt(1-4*x)+1)*(y+1)**2)/(2*x**2)	534	generatingfunction
1300	T	( binomial(2*k,n)  )	534	explicitformula
1301	T	 ((binomial(n-2*m-k-1,m-1))*(-1)**(m-1)*(k-n)*(binomial(2*k,n)))/(m)  	534	explicitformula
1302	U	(x*sqrt((4*x-2)*y+2*sqrt(1-4*x)*y+x**2)+(1-2*x)*y-sqrt(1-4*x)*y-x**2)/((2*x-1)*y**2+sqrt(1-4*x)*y**2)	535	generatingfunction
1304	U	((y+1)**2+x)**2/(y+1)**2	536	generatingfunction
1306	U	((x*sqrt(x*(4*(y+1)**4+27*x)))/(2*3**(3/2)*(y+1)**2)+(y+1)**6/27+(2*x*(y+1)**2+(3*x**2)/(y+1)**2)/6)**(1/3)-((-(y+1)**4/9)-(2*x)/3)/((x*sqrt(x*(4*(y+1)**4+27*x)))/(2*3**(3/2)*(y+1)**2)+(y+1)**6/27+(2*x*(y+1)**2+(3*x**2)/(y+1)**2)/6)**(1/3)+(y+1)**2/3	537	generatingfunction
1307	T	( 1  )	537	explicitformula
1308	T	( (2*k*((binomial(2*n-2*k-1,n-1))*(-1)**(n-1)))/n  )	537	explicitformula
1309	T	 (2*k*((binomial(2*n-2*k-1,n-1))*(-1)**(n-1)))/n  	537	explicitformula
1310	T	 (k*(binomial(n-2*m-k-1,m-1)*(-1)**(m-1)/m)*(binomial(2*k-n-1,n)))  	537	explicitformula
1311	U	(1-sqrt(1-4*x*(y+1)**3))/(2*x*(y+1)**2)	538	generatingfunction
1312	T	( (k*binomial(n+k,n)*binomial(2*n+m+k-1,m))/(n+k)  )	538	explicitformula
1313	U	x*(y+1)**4+(y+1)**2	539	generatingfunction
1314	T	( (k*binomial(2*n+k,n)*binomial(3*n+m+k-1,m))/(2*n+k)  )	539	explicitformula
1305	T	binomial(2*k,n)*binomial(2*k-2*n,m)	536	explicitformula
1315	U	-(y+1)**2/(x*(y+1)**4-1)	540	generatingfunction
1316	T	( binomial(k,n)*binomial(2*n+m+2*k-1,m)  )	540	explicitformula
1317	U	(1-sqrt(1-4*x*(y+1)**6))/(2*x*(y+1)**4)	541	generatingfunction
1318	T	( (k*binomial(n+k,n)*binomial(4*n+m+2*k-1,m))/(n+k)  )	541	explicitformula
1319	U	1/(1-y)+x/(1-y)**2	542	generatingfunction
1320	T	( (k*binomial(2*n+k,n)*binomial(2*(n+k)+4*n+m-1,m))/(2*n+k)  )	542	explicitformula
1321	U	-1/((x/(1-y)**2-1)*(1-y))	543	generatingfunction
1322	T	( (binomial(k,n)*(n+k)*binomial(n+2*m+k-1,m))/(n+m+k)  )	543	explicitformula
1323	U	((1-sqrt(1-(4*x)/(1-y)**3))*(1-y)**2)/(2*x)	544	generatingfunction
1324	T	( (k*(2*n+k)*binomial(n+k,n)*binomial(2*n+2*m+k-1,m))/((n+k)*(2*n+m+k))  )	544	explicitformula
1325	U	1/(1-y)**2+x/(1-y)**4	545	generatingfunction
1326	T	( (k*(3*n+k)*binomial(2*n+k,n)*binomial(3*n+2*m+k-1,m))/((2*n+k)*(3*n+m+k))  )	545	explicitformula
1327	U	-1/((x/(1-y)**4-1)*(1-y)**2)	546	generatingfunction
1328	T	( binomial(2*k,m)  )	546	explicitformula
1329	T	 (k*((binomial(2*n-k-1,n-1))*(-1)**(n-1)))/n*binomial(2*k,m)  	546	explicitformula
1333	U	(1-sqrt(1-4*y))/(2*y)+(x*(1-sqrt(1-4*y))**2)/(4*y**2)	548	generatingfunction
1334	T	( binomial(2*m+k-1,m)*k/(m+k)  )	548	explicitformula
1336	U	(sqrt(1-4*y)-1)/(2*((x*(1-sqrt(1-4*y))**2)/(4*y**2)-1)*y)	549	generatingfunction
1339	U	(2*(1-sqrt(1-(x*(1-sqrt(1-4*y))**3)/(2*y**3)))*y**2)/(x*(1-sqrt(1-4*y))**2)	550	generatingfunction
1341	U	((sqrt(4*x+1)+1)*(y+1)**2)/2	551	generatingfunction
1343	U	(sqrt(4*x+1)+1)/(2*(1-y)**2)	552	generatingfunction
1345	U	((sqrt(4*x+1)+1)*(1-sqrt(1-4*y)))/(4*y)	553	generatingfunction
1347	U	((sqrt(4*x+1)+1)*((-2*y)-sqrt(1-4*y)+1))/(4*y**2)	554	generatingfunction
1349	U	((-2*y)-sqrt(1-4*y)+1)/(2*y**2)+(x*((-2*y)-sqrt(1-4*y)+1)**2)/(4*y**4)	555	generatingfunction
1351	U	(2*y+sqrt(1-4*y)-1)/(2*((x*((-2*y)-sqrt(1-4*y)+1)**2)/(4*y**4)-1)*y**2)	556	generatingfunction
1354	U	(2*(1-sqrt(1-(x*((-2*y)-sqrt(1-4*y)+1)**3)/(2*y**6)))*y**4)/(x*((-2*y)-sqrt(1-4*y)+1)**2)	557	generatingfunction
1357	U	((y+1)**2-sqrt((y+1)**4-4*x*(y+1)**3))/(2*x)	558	generatingfunction
1359	U	-(y+1)**3/(x-(y+1)**2)	559	generatingfunction
1361	U	((y+1)**3+x)/(y+1)**2	560	generatingfunction
1363	U	(sqrt((y+1)**4+4*x)+(y+1)**2)/(2*(y+1))	561	generatingfunction
1365	U	((y+1)**2-sqrt((y+1)**4+4*x))/(2*(y+1))	562	generatingfunction
1368	U	((y+1)**4-sqrt((y+1)**8-4*x*(y+1)**6))/(2*x)	563	generatingfunction
1370	U	-(y+1)**6/(x-(y+1)**4)	564	generatingfunction
1372	U	((y+1)**6+x)/(y+1)**4	565	generatingfunction
1376	U	((y+1)**4-sqrt((y+1)**8+4*x))/(2*(y+1)**2)	567	generatingfunction
1377	T	( binomial(k,n)*binomial((-3*n)+m+k-1,m)  )	567	explicitformula
1378	U	(1/(1-y)**2-sqrt(1/(1-y)**4-(4*x)/(1-y)**3))/(2*x)	568	generatingfunction
1379	T	( binomial(m+k-1,m)  )	568	explicitformula
1380	T	 (k*(binomial(-4*n+m+k-1,m))*(binomial(k-n-1,n-1)))/(n)  	568	explicitformula
1381	U	-1/((x-1/(1-y)**2)*(1-y)**3)	569	generatingfunction
1382	T	( 0  )	569	explicitformula
1383	T	 -(k*(binomial(-4*n+m+k-1,m))*(binomial(k-n-1,n-1)))/n  	569	explicitformula
1384	U	y**3+3*y**2+(x+3)*y+x+1	570	generatingfunction
1385	T	( (k*binomial(2*(k-n)+m-1,m)*binomial(2*n+k-1,n))/(n+k)  )	570	explicitformula
1386	U	(y+1)**3+x*(y+1)**2	571	generatingfunction
1387	T	( binomial(2*(k-2*n)+m-1,m)*binomial(n+k-1,n)  )	571	explicitformula
1388	U	(1/(1-y)**3+x)*(1-y)**2	572	generatingfunction
1335	T	 (binomial(k,n)*(n+k)*binomial(n+2*m+k-1,m))/(n+m+k)	548	explicitformula
1337	T	 (k*(2*n+k)*binomial(n+k,n)*binomial(2*n+2*m+k-1,m ))/((n+k)*(2*n+m+k))	549	explicitformula
1338	T	 (k*(2*n+k)*binomial(n+k,n)*binomial(2*n+2*m+k-1,m ))/((n+k)*(2*n+m+k))	549	explicitformula
1340	T	(k*(3*n+k)*binomial(2*n+k,n)*binomial(3*n+2*m+k-1 ,m))/((2*n+k)*(3*n+m+k))	550	explicitformula
1342	T	 binomial(2*k,m)	551	explicitformula
1344	T	binomial(m+2*k-1,m)	552	explicitformula
1346	T	 binomial(2*m+k-1,m)*k/(m+k)	553	explicitformula
1331	T	(k*binomial(2*n+k,n)*binomial(2*(n+k)+4*n+m-1,m)) /(2*n+k)	547	explicitformula
1348	T	 binomial(2*m+2*k,m)*k/(m+k)	554	explicitformula
1350	T	binomial(k,n)*binomial(2*m+2*k+2*n,m)*(k+n)/(m+k+n)	555	explicitformula
1352	T	(k*(2*n+k)*binomial(n+k,n)*binomial(2*(n+k)+2*n+2 *m,m))/((n+k)*(2*n+m+k))	556	explicitformula
1353	T	(k*(2*n+k)*binomial(n+k,n)*binomial(2*(n+k)+2*n+2 *m,m))/((n+k)*(2*n+m+k))	556	explicitformula
1355	T	 (k*(3*n+k)*binomial(2*n+k,n)*binomial(2*(2*n+k)+2 *n+2*m,m))/((2*n+k)*(3*n+m+k))	557	explicitformula
1358	T	 (k*binomial(k-n,m)*binomial(2*n+k-1,n))/(n+k)	558	explicitformula
1360	T	binomial(k-2*n,m)*binomial(n+k-1,n)	559	explicitformula
1362	T	binomial(k,n)*binomial(k-3*n,m)	560	explicitformula
1364	T	 binomial(k,m)	561	explicitformula
1366	T	0	562	explicitformula
1367	T	-(k*(binomial(k-4*n,m))*(binomial(k-n-1,n-1)))/	562	explicitformula
1369	T	(k*binomial(2*(k-n),m)*binomial(2*n+k-1,n))/(n+k)	563	explicitformula
1371	T	 binomial(k,n)*binomial(2*(k-3*n),m)	564	explicitformula
1373	T	binomial(k,n)*binomial(2*(k-3*n),m)	565	explicitformula
1374	G	 (sqrt((y+1)^8+4*x)+(y+1)^4)/(2*(y+1)^2)	566	generatingfunction
1375	T	binomial(2*k,m) 	566	explicitformula
1389	T	( binomial(k,n)*binomial(2*(k-3*n)+m-1,m)  )	572	explicitformula
1390	U	(1/(1-y)+sqrt(4*x*(1-y)**2+1/(1-y)**2))/2	573	generatingfunction
1391	T	( binomial(m+2*k-1,m)  )	573	explicitformula
1392	T	 (k*(binomial(2*(k-4*n)+m-1,m))*(binomial(k-n-1,n-1)))/(n)  	573	explicitformula
1393	U	(1/(1-y)-sqrt(4*x*(1-y)**2+1/(1-y)**2))/2	574	generatingfunction
1394	T	( 0  )	574	explicitformula
1395	T	 -(k*(binomial(2*(k-4*n)+m-1,m))*(binomial(k-n-1,n-1)))/(n)  	574	explicitformula
1396	U	(1/(1-y)**4-sqrt(1/(1-y)**8-(4*x)/(1-y)**6))/(2*x)	575	generatingfunction
1397	T	( (k**2*binomial(2*m+k-1,m)*binomial(3*n+k-1,n))/((m+k)*(2*n+k))  )	575	explicitformula
1398	U	-1/((x-1/(1-y)**4)*(1-y)**6)	576	generatingfunction
1399	T	( binomial(2*n+k-1,n)*k/(n+k)  )	576	explicitformula
1400	T	 (k*(binomial(n-m-k-1,m-1)*(-1)**(m-1))/m*(k-n)*(binomial(2*n+k-1,n)))/(n+k)  	576	explicitformula
1401	U	(1/(1-y)**6+x)*(1-y)**4	577	generatingfunction
1402	T	( binomial(n+k-1,n)  )	577	explicitformula
1403	T	 ((binomial(2*n-m-k-1,m-1)*(-1)**(m-1))/m*(k-2*n)*(binomial(n+k-1,n)))  	577	explicitformula
1404	U	((1/(1-y)**4+sqrt(1/(1-y)**8+4*x))*(1-y)**2)/2	578	generatingfunction
1405	T	( binomial(k,n)  )	578	explicitformula
1406	T	 ((binomial(3*n-m-k-1,m-1)*(-1)**(m-1))/m*(k-3*n)*(binomial(k,n)))  	578	explicitformula
1407	U	((1/(1-y)**4-sqrt(1/(1-y)**8+4*x))*(1-y)**2)/2	579	generatingfunction
1408	T	( (k**2*binomial(2*m+2*k,m)*binomial(3*n+k-1,n))/((m+k)*(2*n+k))  )	579	explicitformula
1409	U	((1-sqrt(1-4*y))**2/(4*y**2)-sqrt((1-sqrt(1-4*y))**4/(16*y**4)-(x*(1-sqrt(1-4*y))**3)/(2*y**3)))/(2*x)	580	generatingfunction
1410	T	( binomial(n+k-1,n)  )	580	explicitformula
1411	T	 (2*(binomial(2*k-4*n+2*m-1,m-1))/m*(k-2*n)*(binomial(n+k-1,n)))  	580	explicitformula
1412	U	-(1-sqrt(1-4*y))**3/(8*(x-(1-sqrt(1-4*y))**2/(4*y**2))*y**3)	581	generatingfunction
1413	T	( binomial(k,n)  )	581	explicitformula
1414	T	 (2*(binomial(2*k-6*n+2*m-1,m-1))/m*(k-3*n)*(binomial(k,n)))  	581	explicitformula
1415	U	(4*((1-sqrt(1-4*y))**3/(8*y**3)+x)*y**2)/(1-sqrt(1-4*y))**2	582	generatingfunction
1416	T	( 1  )	582	explicitformula
1417	T	( binomial(k-n-1,n-1)*k/(n)  )	582	explicitformula
1418	T	( k/(k+m)*binomial(2*m+2*k,m)  )	582	explicitformula
1419	T	 binomial(k-n-1,n-1)*k/(n)  	582	explicitformula
1420	T	 (2*(binomial(2*k-8*n+2*m-1,m-1))/m*(k-4*n)*(binomial(k-n-1,n-1))/n)*k  	582	explicitformula
1421	U	(((-2*y)-sqrt(1-4*y)+1)**2/(4*y**4)-sqrt(((-2*y)-sqrt(1-4*y)+1)**4/(16*y**8)-(x*((-2*y)-sqrt(1-4*y)+1)**3)/(2*y**6)))/(2*x)	583	generatingfunction
1422	T	( (k**2*binomial(3*m+k-1,m)*binomial(3*n+k-1,n))/((2*m+k)*(2*n+k))  )	583	explicitformula
1423	U	-((-2*y)-sqrt(1-4*y)+1)**3/(8*(x-((-2*y)-sqrt(1-4*y)+1)**2/(4*y**4))*y**6)	584	generatingfunction
1424	T	 ( binomial(2*n+k-1,n)*k/(n+k)) 	584	explicitformula
1425	U	(4*(((-2*y)-sqrt(1-4*y)+1)**3/(8*y**6)+x)*y**4)/((-2*y)-sqrt(1-4*y)+1)**2	585	generatingfunction
1426	T	( binomial(n+k-1,n)  )	585	explicitformula
1427	T	 ((binomial(n+k-1,n)))*((k-2*n)*(binomial(2*n-2*m-k-1,m-1)*(-1)**(m-1)))/m  	585	explicitformula
1428	U	((((-2*y)-sqrt(1-4*y)+1)**2/(4*y**4)+sqrt(((-2*y)-sqrt(1-4*y)+1)**4/(16*y**8)+4*x))*y**2)/((-2*y)-sqrt(1-4*y)+1)	586	generatingfunction
1429	T	( binomial(k,n)  )	586	explicitformula
1430	T	 ((binomial(k,n)))*((k-3*n)*(binomial(3*n-2*m-k-1,m-1)*(-1)**(m-1)))/m  	586	explicitformula
1431	U	((((-2*y)-sqrt(1-4*y)+1)**2/(4*y**4)-sqrt(((-2*y)-sqrt(1-4*y)+1)**4/(16*y**8)+4*x))*y**2)/((-2*y)-sqrt(1-4*y)+1)	587	generatingfunction
1432	T	( 1  )	587	explicitformula
1433	T	( k*binomial(k-n-1,n-1)/n  )	587	explicitformula
1434	T	( (k*(binomial(3*m+k-1,m)))/(2*m+k)  )	587	explicitformula
1435	T	 k*binomial(k-n-1,n-1)/n  	587	explicitformula
1436	T	 k*((binomial(k-n-1,n-1)/n))*((k-4*n)*(binomial(4*n-2*m-k-1,m-1)*(-1)**(m-1)))/(m)  	587	explicitformula
1437	U	(sqrt(4*x*(y+1)**3+(y+1)**2)+y+1)/2	588	generatingfunction
1438	T	( binomial(2*k,m)  )	588	explicitformula
1439	T	 binomial(2*k,m)*(k*((binomial(3*n-k-1,n-1))*(-1)**(n-1)))/n  	588	explicitformula
1440	U	x*(y+1)**3+y+1	589	generatingfunction
1441	T	( binomial(2*k+2*n,m)*k/(n+k)  )	589	explicitformula
1442	T	 binomial(2*k+2*n,m)*(k*((binomial(2*n-k-1,n-1))*(-1)**(n-1)))/n  	589	explicitformula
1443	U	((-y)-1)/(x*(y+1)**3-1)	590	generatingfunction
1444	T	( binomial(k,n)*binomial(4*n+2*k,m)  )	590	explicitformula
1445	U	(1-sqrt(1-4*x*(y+1)**4))/(2*x*(y+1)**3)	591	generatingfunction
1446	T	( (k*binomial(n+k,n)*binomial(6*n+2*k,m))/(n+k)  )	591	explicitformula
1447	U	(sqrt(4*x*(y+1)**6+(y+1)**4)+(y+1)**2)/2	592	generatingfunction
1448	T	( binomial(m+k+n-1,m)*k/(n+k)  )	592	explicitformula
1449	T	 binomial(m+n+k-1,m)*(k*((binomial(2*n-k-1,n-1))*(-1)**(n-1)))/n  	592	explicitformula
1450	U	x*(y+1)**6+(y+1)**2	593	generatingfunction
1451	T	( binomial(k,n)*binomial(2*n+m+k-1,m)  )	593	explicitformula
1452	U	-(y+1)**2/(x*(y+1)**6-1)	594	generatingfunction
1453	T	( binomial(n+k-1,n)*binomial(3*n+m+k-1,m)  )	594	explicitformula
1454	U	(1-sqrt(1-4*x*(y+1)**8))/(2*x*(y+1)**6)	595	generatingfunction
1455	T	( (k*binomial(2*n+k-1,n)*binomial(4*n+m+k-1,m))/(n+k)  )	595	explicitformula
1456	U	(1/(1-y)+sqrt(1/(1-y)**2+(4*x)/(1-y)**3))/2	596	generatingfunction
1457	T	( binomial(m+2*k+2*n-1,m)*k/(n+k)  )	596	explicitformula
1458	T	 binomial(m+2*k+2*n-1,m)*(k*((binomial(2*n-k-1,n-1))*(-1)**(n-1)))/n  	596	explicitformula
1459	U	1/(1-y)+x/(1-y)**3	597	generatingfunction
1460	T	( binomial(k,n)*binomial(4*n+m+2*k-1,m)  )	597	explicitformula
1461	U	-1/((x/(1-y)**3-1)*(1-y))	598	generatingfunction
1462	T	( binomial(n+k-1,n)*binomial(6*n+m+2*k-1,m)  )	598	explicitformula
1463	U	((1-sqrt(1-(4*x)/(1-y)**4))*(1-y)**3)/(2*x)	599	generatingfunction
1464	T	( (k*binomial(2*n+k-1,n)*binomial(8*n+m+2*k-1,m))/(n+k)  )	599	explicitformula
1465	U	(1/(1-y)**2+sqrt(1/(1-y)**4+(4*x)/(1-y)**6))/2	600	generatingfunction
1466	T	( k/(m+k+n)*binomial(2*m+k+n-1,m)  )	600	explicitformula
1467	T	 k/(m+k+n)*binomial(2*m+k+n-1,m)*((k+n)*((binomial(2*n-k-1,n-1))*(-1)**(n-1)))/n  	600	explicitformula
1468	U	1/(1-y)**2+x/(1-y)**6	601	generatingfunction
1469	T	( (binomial(k,n)*(2*n+k)*binomial(2*n+2*m+k-1,m))/(2*n+m+k)  )	601	explicitformula
1470	U	-1/((x/(1-y)**6-1)*(1-y)**2)	602	generatingfunction
1471	T	( ((3*n+k)*binomial(n+k-1,n)*binomial(3*n+2*m+k-1,m))/(3*n+m+k)  )	602	explicitformula
1472	U	((1-sqrt(1-(4*x)/(1-y)**8))*(1-y)**6)/(2*x)	603	generatingfunction
1473	T	( (k*(4*n+k)*binomial(2*n+k-1,n)*binomial(4*n+2*m+k-1,m))/((n+k)*(4*n+m+k))  )	603	explicitformula
1474	U	((1-sqrt(1-4*y))/(2*y)+sqrt((1-sqrt(1-4*y))**2/(4*y**2)+(x*(1-sqrt(1-4*y))**3)/(2*y**3)))/2	604	generatingfunction
1475	T	( (k)/(n+m+k)*binomial(2*m+2*k+2*n,m)  )	604	explicitformula
1830	U	1/(1-x*y)	741	generatingfunction
1476	T	 k/(n+m+k)*binomial(2*m+2*k+2*n,m)*((k+n)*((binomial(2*n-k-1,n-1))*(-1)**(n-1)))/n  	604	explicitformula
1477	U	(1-sqrt(1-4*y))/(2*y)+(x*(1-sqrt(1-4*y))**3)/(8*y**3)	605	generatingfunction
1478	T	( (binomial(k,n)*(2*n+k)*binomial(4*n+2*m+2*k,m))/(2*n+m+k)  )	605	explicitformula
1479	U	(sqrt(1-4*y)-1)/(2*((x*(1-sqrt(1-4*y))**3)/(8*y**3)-1)*y)	606	generatingfunction
1480	T	( ((3*n+k)*binomial(n+k-1,n)*binomial(2*(n+k)+4*n+2*m,m))/(3*n+m+k)  )	606	explicitformula
1481	U	(4*(1-sqrt(1-(x*(1-sqrt(1-4*y))**4)/(4*y**4)))*y**3)/(x*(1-sqrt(1-4*y))**3)	607	generatingfunction
1482	T	( (k*(4*n+k)*binomial(2*n+k-1,n)*binomial(8*n+2*m+2*k,m))/((n+k)*(4*n+m+k))  )	607	explicitformula
1483	U	(((-2*y)-sqrt(1-4*y)+1)/(2*y**2)+sqrt(((-2*y)-sqrt(1-4*y)+1)**2/(4*y**4)+(x*((-2*y)-sqrt(1-4*y)+1)**3)/(2*y**6)))/2	608	generatingfunction
1484	T	( 4**m*(binomial(m+(k+n)/2-1,m))*k/(k+n)  )	608	explicitformula
1485	T	 4**m*binomial(m+(k+n)/2-1,m)*(k*((binomial(2*n-k-1,n-1))*(-1)**(n-1)))/n  	608	explicitformula
1486	U	((-2*y)-sqrt(1-4*y)+1)/(2*y**2)+(x*((-2*y)-sqrt(1-4*y)+1)**3)/(8*y**6)	609	generatingfunction
1487	T	( binomial(k,n)*4**m*binomial(n+m+k/2-1,m)  )	609	explicitformula
1488	U	(2*y+sqrt(1-4*y)-1)/(2*((x*((-2*y)-sqrt(1-4*y)+1)**3)/(8*y**6)-1)*y**2)	610	generatingfunction
1489	T	( 4**m*binomial(n+k-1,n)*binomial((n+k)/2+n+m-1,m)  )	610	explicitformula
1490	U	(4*(1-sqrt(1-(x*((-2*y)-sqrt(1-4*y)+1)**4)/(4*y**8)))*y**6)/(x*((-2*y)-sqrt(1-4*y)+1)**3)	611	generatingfunction
1491	T	( (k*4**m*binomial(2*n+k-1,n)*binomial((2*n+k)/2+n+m-1,m))/(n+k)  )	611	explicitformula
1492	U	1/sqrt(1-4*y)+x/(1-4*y)**(3/2)	612	generatingfunction
1493	T	( (binomial(k,n)*(2*n+k)*binomial(2*n+3*m+k-1,m))/(2*n+2*m+k)  )	612	explicitformula
1494	U	-1/((x/(1-4*y)**(3/2)-1)*sqrt(1-4*y))	613	generatingfunction
1495	T	( ((3*n+k)*binomial(n+k-1,n)*binomial(3*n+3*m+k-1,m))/(3*n+2*m+k)  )	613	explicitformula
1496	U	((1-sqrt(1-(4*x)/(1-4*y)**2))*(1-4*y)**(3/2))/(2*x)	614	generatingfunction
1497	T	( (k*(4*n+k)*binomial(2*n+k-1,n)*binomial(4*n+3*m+k-1,m))/((n+k)*(4*n+2*m+k))  )	614	explicitformula
1498	U	(sqrt((x*(sqrt(4*y+1)+1)**3)/2+(sqrt(4*y+1)+1)**2/4)+(sqrt(4*y+1)+1)/2)/2	615	generatingfunction
1499	T	( (1+(-1)**m)/2*binomial(k+n,m/2)*k/(n+k)  )	615	explicitformula
1500	T	 (1+(-1)**m)/2*binomial(k+n,m/2)*(k*((binomial(2*n-k-1,n-1))*(-1)**(n-1)))/n  	615	explicitformula
1501	U	(x*(sqrt(4*y+1)+1)**3)/8+(sqrt(4*y+1)+1)/2	616	generatingfunction
1502	T	( (binomial(k,n)*((-1)**m+1)*binomial(2*n+k,m/2))/2  )	616	explicitformula
1503	U	((-sqrt(4*y+1))-1)/(2*((x*(sqrt(4*y+1)+1)**3)/8-1))	617	generatingfunction
1504	T	( (((-1)**m+1)*binomial(n+k-1,n)*binomial(3*n+k,m/2))/2  )	617	explicitformula
1505	U	(4*(1-sqrt(1-(x*(sqrt(4*y+1)+1)**4)/4)))/(x*(sqrt(4*y+1)+1)**3)	618	generatingfunction
1506	T	( (k*((-1)**m+1)*binomial(2*n+k-1,n)*binomial(4*n+k,m/2))/(2*(n+k))  )	618	explicitformula
1507	U	(sqrt(4*x*(y**2+1)**3+(y**2+1)**2)+y**2+1)/2	619	generatingfunction
1508	T	( k*(binomial(2*n+k-1,n))/(n+k)  )	619	explicitformula
1509	T	 k*(binomial(2*n+k-1,n))/(n+k)*((k-n)*((binomial(2*m+n-k-1,m-1))*(-1)**(m-1)))/m  	619	explicitformula
1510	U	x*(y**2+1)**3+y**2+1	620	generatingfunction
1511	T	( (binomial(n+k-1,n))  )	620	explicitformula
1512	T	 (binomial(n+k-1,n))*((k-2*n)*((binomial(2*m+2*n-k-1,m-1))*(-1)**(m-1)))/m  	620	explicitformula
1513	U	((-y**2)-1)/(x*(y**2+1)**3-1)	621	generatingfunction
1514	T	( (binomial(k,n))  )	621	explicitformula
1515	T	 (binomial(k,n))*((k-3*n)*((binomial(2*m+3*n-k-1,m-1))*(-1)**(m-1)))/m  	621	explicitformula
1516	U	(1-sqrt(1-4*x*(y**2+1)**4))/(2*x*(y**2+1)**3)	622	generatingfunction
1517	T	( 1  )	622	explicitformula
1518	T	( k*(binomial(k-n-1,n-1))/n  )	622	explicitformula
1519	T	( ((k-4*n)*((binomial(2*m+4*n-k-1,m-1))*(-1)**(m-1)))/m  )	622	explicitformula
1520	T	 k*(binomial(k-n-1,n-1))/n  	622	explicitformula
1521	T	 k*(binomial(k-n-1,n-1)/n)*((k-4*n)*((binomial(2*m+4*n-k-1,m-1))*(-1)**(m-1)))/m  	622	explicitformula
1522	U	((sqrt(4*y+1)+1)**2/4-sqrt((sqrt(4*y+1)+1)**4/16-(x*(sqrt(4*y+1)+1)**3)/2))/(2*x)	623	generatingfunction
1524	U	-(sqrt(4*y+1)+1)^3/(8*(x-(sqrt(4*y+1)+1)^2/4))	624	generatingfunction
1526	U	 (4*((sqrt(4*y+1)+1)^3/8+x))/(sqrt(4*y+1)+1)^2	625	generatingfunction
1528	U	(sqrt((sqrt(4*y+1)+1)**4/16+4*x)+(sqrt(4*y+1)+1)**2/4)/(sqrt(4*y+1)+1)	626	generatingfunction
1530	U	((sqrt(4*y+1)+1)**2/4-sqrt((sqrt(4*y+1)+1)**4/16+4*x))/(sqrt(4*y+1)+1)	627	generatingfunction
1531	T	( binomial(m+(k)/2-1,m)*4**m  )	627	explicitformula
1532	T	 k*((binomial(k-n-1,n-1)/n))*binomial(m+(k-4*n)/2-1,m)*4**m  	627	explicitformula
1533	U	-1/((x-1/(1-4*y))*(1-4*y)**(3/2))	628	generatingfunction
1534	T	( 1  )	628	explicitformula
1535	T	( k*binomial(k-n-1,n-1)/n  )	628	explicitformula
1536	T	( ((k-n)*((binomial(3*m+n-k-1,m-1))*(-1)**(m-1)))/m  )	628	explicitformula
1537	T	 k*binomial(k-n-1,n-1)/n  	628	explicitformula
1538	T	 k*binomial(k-n-1,n-1)/n*((k-n)*((binomial(3*m+n-k-1,m-1))*(-1)**(m-1)))/m  	628	explicitformula
1539	U	(1/(1-4*y)**(3/2)+x)*(1-4*y)	629	generatingfunction
1540	T	( 0  )	629	explicitformula
1541	T	( -k*binomial(k-n-1,n-1)/n  )	629	explicitformula
1542	T	 -k*binomial(k-n-1,n-1)/n*((k-n)*((binomial(3*m+n-k-1,m-1))*(-1)**(m-1)))/m  	629	explicitformula
1543	U	((1/(1-4*y)+sqrt(1/(1-4*y)**2+4*x))*sqrt(1-4*y))/2	630	generatingfunction
1546	U	((1/(1-4*y)-sqrt(1/(1-4*y)**2+4*x))*sqrt(1-4*y))/2	631	generatingfunction
1549	U	2*x-sqrt((y+1)**2+4*x**2)	632	generatingfunction
1550	T	( binomial(m+k-1,m)*(-1)**k  )	632	explicitformula
1551	T	 (-1)**(k+1)*k*binomial((n-k)/2-1,n-1)*binomial(m+k-n-1,m)*4**n/(2*n)  	632	explicitformula
1552	U	sqrt((y+1)**2+4*x**2)+2*x	633	generatingfunction
1553	T	( binomial(m+2*k-1,m)  )	633	explicitformula
1554	T	 (-1)**(n-1)*k*binomial((n-k)/2-1,n-1)*binomial(m+2*k-2*n-1,m)*4**n/(2*n)  	633	explicitformula
1555	U	sqrt((y+1)**4+4*x**2)+2*x	634	generatingfunction
1556	T	( binomial(m+2*k-1,m)*(-1)**k  )	634	explicitformula
1557	T	 (-1)**(k+1)*k*binomial((n-k)/2-1,n-1)*binomial(m+2*k-2*n-1,m)*4**n/(2*n)  	634	explicitformula
1558	U	2*x-sqrt((y+1)**4+4*x**2)	635	generatingfunction
1560	U	sqrt(1/(1-y)**2+4*x**2)+2*x	636	generatingfunction
1561	T	( 1  )	636	explicitformula
1562	T	( 1/2*4**n*binomial((n-k)/2-1,n-1)*k/n*(-1)**(n-1)  )	636	explicitformula
1563	T	 1/2*4**n*binomial((n-k)/2-1,n-1)*k/n*(-1)**(n-1)  	636	explicitformula
1564	T	 k/m*binomial(n-m-k-1,m-1)*(-1)**(m-1)*4**n*(binomial((n+k)/2-1,n))  	636	explicitformula
1565	U	2*x-sqrt(1/(1-y)**2+4*x**2)	637	generatingfunction
1566	T	( (-1)**k  )	637	explicitformula
1567	T	( (-1)**(k-1)/2*4**n*binomial((n-k)/2-1,n-1)*k/n  )	637	explicitformula
1568	T	 (-1)**(k-1)/2*4**n*binomial((n-k)/2-1,n-1)*k/n  	637	explicitformula
1569	T	 (-1)**(n-k)*k/m*binomial(n-m-k-1,m-1)*(-1)**(m-1)*4**n*(binomial((n+k)/2-1,n))  	637	explicitformula
1570	U	sqrt(1/(1-y)**4+4*x**2)+2*x	638	generatingfunction
1572	U	2*x-sqrt(1/(1-y)**4+4*x**2)	639	generatingfunction
1573	T	( 1  )	639	explicitformula
1574	T	( 1/2*4**n*binomial((n-k)/2-1,n-1)*k/n*(-1)**(n-1)  )	639	explicitformula
1575	T	 1/2*4**n*binomial((n-k)/2-1,n-1)*k/n*(-1)**(n-1)  	639	explicitformula
1576	T	 2*k/m*binomial(2*m+2*k-2*n-1,m-1)*4**n*(binomial((n+k)/2-1,n))  	639	explicitformula
1577	U	(1-sqrt(1-4*y))/(2*sqrt(1-4*x)*y)	640	generatingfunction
1578	T	( (-1)**k  )	640	explicitformula
1579	T	( (-1)**(k-1)/2*4**n*binomial((n-k)/2-1,n-1)*k/n  )	640	explicitformula
1580	T	 (-1)**(k-1)/2*4**n*binomial((n-k)/2-1,n-1)*k/n  	640	explicitformula
1581	T	 2*(-1)**(n-k)*k/m*binomial(2*m-2*n+2*k-1,m-1)*4**n*(binomial((n+k)/2-1,n))  	640	explicitformula
1582	U	sqrt((1-sqrt(1-4*y))**2/(4*y**2)+4*x**2)+2*x	641	generatingfunction
1583	T	( (k*binomial(3*m+k-1,m)*4**n*binomial(n+k/2-1,n))/(2*m+k)  )	641	explicitformula
1584	U	2*x-sqrt((1-sqrt(1-4*y))**2/(4*y**2)+4*x**2)	642	generatingfunction
1585	T	( 1  )	642	explicitformula
1586	T	( 1/2*4**n*binomial((n-k)/2-1,n-1)*k/n*(-1)**(n-1)  )	642	explicitformula
1587	T	 1/2*4**n*binomial((n-k)/2-1,n-1)*k/n*(-1)**(n-1)  	642	explicitformula
1588	T	 k/m*4**n*((binomial(n-2*m-k-1,m-1)))*(-1)**(m-1)*(binomial((n+k)/2-1,n))  	642	explicitformula
1589	U	((-2*y)-sqrt(1-4*y)+1)/(2*sqrt(1-4*x)*y**2)	643	generatingfunction
1590	T	( (-1)**k  )	643	explicitformula
1591	T	( (-1)**(k-1)/2*4**n*binomial((n-k)/2-1,n-1)*k/n  )	643	explicitformula
1592	T	 (-1)**(k-1)/2*4**n*binomial((n-k)/2-1,n-1)*k/n  	643	explicitformula
1593	T	 (-1)**(n-k)*k/m*((binomial(n-2*m-k-1,m-1)))*(-1)**(m-1)*4**n*(binomial((n+k)/2-1,n))  	643	explicitformula
1594	U	sqrt(((-2*y)-sqrt(1-4*y)+1)**2/(4*y**4)+4*x**2)+2*x	644	generatingfunction
1595	T	( 4**n*binomial(n+k/2-1,n)  )	644	explicitformula
1596	T	 4**n*binomial(n+k/2-1,n)*(k*((binomial(2*m-k-1,m-1))*(-1)**(m-1)))/m  	644	explicitformula
1597	U	2*x-sqrt(((-2*y)-sqrt(1-4*y)+1)**2/(4*y**4)+4*x**2)	645	generatingfunction
1598	T	( 1  )	645	explicitformula
1599	T	( 1/2*4**n*binomial((n-k)/2-1,n-1)*k/n*(-1)**(n-1)  )	645	explicitformula
1600	T	 1/2*4**n*binomial((n-k)/2-1,n-1)*k/n*(-1)**(n-1)  	645	explicitformula
1673	U	(sqrt((4*x)/(1-y)**2+1)-1)/(2*x)	671	generatingfunction
1544	T	binomial(m+(k)/2-1,m)*4^m	630	explicitformula
1547	T	0	631	explicitformula
1548	T	-(k*4^m*binomial((k-4*n)/2+m -1,m)*binomial((-n)+k-1,n-1))/n	631	explicitformula
1559	T	 binomial(2*k,m)*(-1)^k	635	explicitformula
1571	T	binomial(m+2*k-1,m)	638	explicitformula
1529	T	1	626	explicitformula
1601	T	 4**n*binomial((n+k)/2-1,n)*(k*((binomial(2*m+n-k-1,m-1))*(-1)**(m-1)))/m  	645	explicitformula
1602	U	(sqrt(4*y+1)+1)/(2*sqrt(1-4*x))	646	generatingfunction
1603	T	( binomial(2*n+k-1,n)*k/(n+k)  )	646	explicitformula
1604	T	 (k*(binomial(2*n+k,n))*(binomial(2*m-2*n-k-1,m-1)))/(m)*(-1)**(m-1)  	646	explicitformula
1605	U	sqrt((sqrt(4*y+1)+1)**2/4+4*x**2)+2*x	647	generatingfunction
1606	T	( binomial(2*(k+n),n)*k/(k+n)  )	647	explicitformula
1607	T	 ((binomial(2*k+2*n,n)*k)*(binomial(2*m-n-k-1,m-1)))/(m)*(-1)**(m-1)  	647	explicitformula
1608	U	2*x-sqrt((sqrt(4*y+1)+1)**2/4+4*x**2)	648	generatingfunction
1609	T	( 1  )	648	explicitformula
1610	T	( (k*((binomial(2*m-k-1,m-1))*(-1)**(m-1)))/m  )	648	explicitformula
1611	T	( (k*((binomial(2*n-k-1,n-1))*(-1)**(n-1)))/n  )	648	explicitformula
1612	T	 (k*((binomial(2*m-k-1,m-1))*(-1)**(m-1)))/m*(k*((binomial(2*n-k-1,n-1))*(-1)**(n-1)))/n  	648	explicitformula
1902	U	1/((1/(1-y)**3-x)*(1-y)**5)	777	generatingfunction
1613	U	((-sqrt(4*y+1))-1)/(x*sqrt(4*y+1)+x-2)	649	generatingfunction
1614	T	( 1  )	649	explicitformula
1615	T	( (k*((binomial(2*m-n-k-1,m-1))*(-1)**(m-1)))/m  )	649	explicitformula
1616	T	( (k*((binomial(n-k-1,n-1))*(-1)**(n-1)))/n  )	649	explicitformula
1617	T	 (k*((binomial(2*m-n-k-1,m-1))*(-1)**(m-1)))/m*((k+n)*((binomial(n-k-1,n-1))*(-1)**(n-1)))/n  	649	explicitformula
1618	U	(1-sqrt((-2*x*sqrt(4*y+1))-4*x*y-2*x+1))/(x*sqrt(4*y+1)+x)	650	generatingfunction
1619	T	( 1  )	650	explicitformula
1620	T	( (k*((binomial(2*m-2*n-k-1,m-1))*(-1)**(m-1)))/m  )	650	explicitformula
1621	T	( (k*((binomial(-k-1,n-1))*(-1)**(n-1)))/n  )	650	explicitformula
1622	T	 (k*((binomial(2*m-2*n-k-1,m-1))*(-1)**(m-1)))/m*((k+2*n)*((binomial(-k-1,n-1))*(-1)**(n-1)))/n  	650	explicitformula
1623	U	((x+1)**2*(sqrt(4*y+1)+1))/2	651	generatingfunction
1624	T	( 1  )	651	explicitformula
1625	T	( (k*((binomial(2*m-3*n-k-1,m-1))*(-1)**(m-1)))/m  )	651	explicitformula
1626	T	( (k*((binomial(-n-k-1,n-1))*(-1)**(n-1)))/n  )	651	explicitformula
1627	T	 (k*((binomial(2*m-3*n-k-1,m-1))*(-1)**(m-1)))/m*((k+3*n)*((binomial(-n-k-1,n-1))*(-1)**(n-1)))/n  	651	explicitformula
1628	U	((-sqrt((-2*x*sqrt(4*y+1))-2*x+1))-x*sqrt(4*y+1)-x+1)/(x**2*sqrt(4*y+1)+x**2)	652	generatingfunction
1629	T	( (k*(binomial(3*m+k-1,m)))/(2*m+k)  )	652	explicitformula
1630	T	 (k*((binomial(2*n-k-1,n-1))*(-1)**(n-1)))/n*(k*(binomial(3*m+k-1,m)))/(2*m+k)  	652	explicitformula
1631	U	((sqrt(4*x+1)+1)*(sqrt(4*y+1)+1))/4	653	generatingfunction
1632	T	( (binomial(k,n)*(n+k)*binomial(n+3*m+k-1,m))/(n+2*m+k)  )	653	explicitformula
1633	U	(x*(sqrt(4*y+1)+1)**2)/4+(sqrt(4*y+1)+1)/2	654	generatingfunction
1634	T	( (k*(2*n+k)*binomial(n+k,n)*binomial(2*n+3*m+k-1,m))/((n+k)*(2*n+2*m+k))  )	654	explicitformula
1635	U	((-sqrt(4*y+1))-1)/(2*((x*(sqrt(4*y+1)+1)**2)/4-1))	655	generatingfunction
1636	T	( (k*(3*n+k)*binomial(2*n+k,n)*binomial(3*n+3*m+k-1,m))/((2*n+k)*(3*n+2*m+k))  )	655	explicitformula
1637	U	(2*(1-sqrt(1-(x*(sqrt(4*y+1)+1)**3)/2)))/(x*(sqrt(4*y+1)+1)**2)	656	generatingfunction
1638	T	( 1  )	656	explicitformula
1639	T	( (k*((binomial(2*n-k-1,n-1))*(-1)**(n-1)))/n  )	656	explicitformula
1640	T	( (k*((binomial(3*m-k-1,m-1))*(-1)**(m-1)))/m  )	656	explicitformula
1641	T	 (k*((binomial(2*n-k-1,n-1))*(-1)**(n-1)))/n  	656	explicitformula
1642	T	 (k*((binomial(2*n-k-1,n-1))*(-1)**(n-1)))/n*(k*((binomial(3*m-k-1,m-1))*(-1)**(m-1)))/m  	656	explicitformula
1643	U	(sqrt(4*x+1)+1)/(2*sqrt(1-4*y))	657	generatingfunction
1644	T	( (k*(-1)**(n+k)*binomial(n+k,m)*binomial(2*n+k-1,n+k-1))/(n+k)  )	657	explicitformula
1645	U	1/sqrt(1-4*y)+x/(1-4*y)	658	generatingfunction
1646	T	( (k*(-1)**n*binomial(2*(n+k),m)*binomial(2*n+k-1,n))/(n+k)  )	658	explicitformula
1647	U	-1/((x/(1-4*y)-1)*sqrt(1-4*y))	659	generatingfunction
1648	T	( binomial(2*k,m)*(-1)**n*binomial(n+k-1,n)  )	659	explicitformula
1649	U	(sqrt(4*x*(y+1)+1)+1)/2	660	generatingfunction
1650	T	( binomial(2*n+m-1,m)  )	660	explicitformula
1651	T	 (k*((binomial(2*n-k-1,n-1))*(-1)**(n-1)))/n*(binomial(2*n+m-1,m))  	660	explicitformula
1652	U	(1-sqrt(4*x*(y+1)+1))/(2*x)	661	generatingfunction
1653	T	( (k*4**m*binomial(m+k/2-1,m)*binomial(2*n+2*k,n))/(n+k)  )	661	explicitformula
1654	U	(sqrt(4*x*(y+1)**2+1)-1)/(2*x)	662	generatingfunction
1655	T	( binomial(2*k,n)*4**m*binomial((k-n)/2+m-1,m)  )	662	explicitformula
1656	U	(y**2+2*y+1)/(x+1)	663	generatingfunction
1657	T	( (k*(-1)**(n+k-1)*binomial(n+m+k-1,m)*binomial(2*n+k-1,n+k-1))/(n+k)  )	663	explicitformula
1658	U	x/(1-y)+1	664	generatingfunction
1659	T	( binomial(k,n)*binomial(2*n+m-1,m)  )	664	explicitformula
1660	U	(sqrt((4*x)/(1-y)+1)+1)/2	665	generatingfunction
1661	T	 (binomial(2*n+m-1,m))	665	explicitformula
1662	U	((-2*x)-sqrt(1-4*x)+1)/(2*x**2*sqrt(1-4*y))	666	generatingfunction
1663	T	( (k*(-1)**n*binomial(2*n+k-1,n+k-1)*binomial(2*n+m+2*k-1,m))/(n+k)  )	666	explicitformula
1664	U	((2*x)/sqrt(1-4*y)+1/(1-4*y)+x**2)*sqrt(1-4*y)	667	generatingfunction
1665	T	( binomial(m+2*k-1,m)*(-1)**n*binomial(n+k-1,n)  )	667	explicitformula
1666	U	(sqrt((4*x)/(1-y)+1)-1)/(2*x)	668	generatingfunction
1667	T	 1	668	explicitformula
1668	U	x/(1-y)**2+1	669	generatingfunction
1669	T	( 1  )	669	explicitformula
1670	T	 (k*((binomial(2*n-k-1,n-1))*(-1)**(n-1)))/(n+m)*binomial(2*m+n-1,m)  	669	explicitformula
1671	U	(sqrt((4*x)/(1-y)**2+1)+1)/2	670	generatingfunction
1672	T	( (k*(-1)**(n+k)*binomial(n+2*m+k-1,m)*binomial(2*n+k-1,n+k-1))/(n+m+k)  )	670	explicitformula
1674	T	( binomial(k,n)*4**m*binomial(n/2+m-1,m)  )	671	explicitformula
1675	U	1/((x+1)*(1-y)**2)	672	generatingfunction
1676	T	( binomial(m+n/2-1,m)*4**m  )	672	explicitformula
1677	T	 (k*((binomial(2*n-k-1,n-1))*(-1)**(n-1)))/n*binomial(m+n/2-1,m)*4**m  	672	explicitformula
1678	U	(x*(1-sqrt(1-4*y)))/(2*y)+1	673	generatingfunction
1679	T	( (k*4**m*(-1)**(n-k)*binomial(2*n+k-1,n+k-1)*binomial((n+k)/2+m-1,m))/(n+k)  )	673	explicitformula
1680	U	(sqrt((2*x*(1-sqrt(1-4*y)))/y+1)+1)/2	674	generatingfunction
1681	T	 1	674	explicitformula
1682	U	(1-sqrt((2*x*(1-sqrt(1-4*y)))/y+1))/(2*x)	675	generatingfunction
1683	T	 1	675	explicitformula
1684	U	x/sqrt(1-4*y)+1	676	generatingfunction
1685	T	( (k*(-1)**(n-k)*binomial(2*n+k-1,n+k-1)*binomial(2*n+2*m+2*k,m))/(n+m+k)  )	676	explicitformula
1686	U	(sqrt((4*x)/sqrt(1-4*y)+1)+1)/2	677	generatingfunction
1687	T	( binomial(k,n)  )	677	explicitformula
1688	T	 binomial(k,n)*n*((binomial(2*m-n-1,m-1))*(-1)**(m-1))/m  	677	explicitformula
1689	U	(1-sqrt((4*x)/sqrt(1-4*y)+1))/(2*x)	678	generatingfunction
1690	T	( 1  )	678	explicitformula
1691	T	( binomial(k-n-1,n-1)*k/n  )	678	explicitformula
1692	T	 binomial(k-n-1,n-1)*k/n  	678	explicitformula
1693	T	 k*binomial(k-n-1,n-1)*((binomial(2*m-n-1,m-1))*(-1)**(m-1))/m  	678	explicitformula
1694	U	(x*((-2*y)-sqrt(1-4*y)+1))/(2*y**2)+1	679	generatingfunction
1695	T	( binomial(2*n+k-1,n+k-1)*(-1)**(n-k)*k/(n+k)  )	679	explicitformula
1696	T	 k*(binomial(2*n+k-1,n+k-1))*(-1)**(n-k)*((binomial(2*m-n-k-1,m-1))*(-1)**(m-1))/m  	679	explicitformula
1697	U	(sqrt((2*x*((-2*y)-sqrt(1-4*y)+1))/y**2+1)+1)/2	680	generatingfunction
1698	T	 1	680	explicitformula
1699	U	(1-sqrt((2*x*((-2*y)-sqrt(1-4*y)+1))/y**2+1))/(2*x)	681	generatingfunction
1700	T	 1	681	explicitformula
1701	U	(x*(sqrt(4*y+1)+1))/2+1	682	generatingfunction
1702	T	( (-1)**k  )	682	explicitformula
1703	T	 k*binomial(2*n+k-1,n+k-1)*(-1)**(n-k)*((binomial(3*m+n+k-1,m)))/(2*m+n+k)  	682	explicitformula
1704	U	(sqrt(2*x*(sqrt(4*y+1)+1)+1)+1)/2	683	generatingfunction
1705	T	( binomial(k,n)  )	683	explicitformula
1706	T	 binomial(k,n)*(n*((binomial(3*m-n-1,m-1))*(-1)**(m-1)))/m  	683	explicitformula
1707	U	(1-sqrt(2*x*(sqrt(4*y+1)+1)+1))/(2*x)	684	generatingfunction
1708	T	( 1  )	684	explicitformula
1709	T	( k*binomial(k-n-1,n-1)/n  )	684	explicitformula
1710	T	 k*binomial(k-n-1,n-1)/n  	684	explicitformula
1711	T	 k*binomial(k-n-1,n-1)*(((binomial(3*m-n-1,m-1))*(-1)**(m-1)))/m  	684	explicitformula
1712	U	1/(1-x/(1-y)**2)	685	generatingfunction
1713	T	 1	685	explicitformula
1714	U	((1-sqrt(1-(4*x)/(1-y)**2))*(1-y)**2)/(2*x)	686	generatingfunction
1715	T	 1	686	explicitformula
1716	U	(y+1)**3/(1-x*(y+1)**2)	687	generatingfunction
1717	T	( 4**m*binomial(int(n/2)+m-1,m)*binomial(n+k-1,n)  )	687	explicitformula
1718	U	(1-sqrt(1-4*x*(4*y+1)**(3/2)))/(2*x*(4*y+1))	688	generatingfunction
1720	U	(sqrt(4*x*(4*y+1)**(3/2)+4*y+1)+sqrt(4*y+1))/2	689	generatingfunction
1722	U	x*(4*y+1)**(3/2)+sqrt(4*y+1)	690	generatingfunction
1724	U	-sqrt(4*y+1)/(x*(4*y+1)**(3/2)-1)	691	generatingfunction
1726	U	(1-sqrt(1-4*x*(4*y+1)**2))/(2*x*(4*y+1)**(3/2))	692	generatingfunction
1728	U	(1-sqrt(((-4*x)-4)*y**2+1))/(2*y**2)	693	generatingfunction
1730	U	((-sqrt((-4*x*y**3)-12*x*y**2-12*x*y-4*x+1))-2*x*y**3-6*x*y**2-6*x*y-2*x+1)/(2*x**2*y**2+4*x**2*y+2*x**2)	694	generatingfunction
1732	U	(y+1)**4/(1-x*(y+1))	695	generatingfunction
1734	U	(y+1)**3/(1-x*(y+1))	696	generatingfunction
1736	U	y**2+(x+2)*y+x+1	697	generatingfunction
1739	U	x^2*(y+1)^3+2*x*(y+1)^2+y+1	698	generatingfunction
1740	T	binomial(2*k,n)*binomial(n+k,m)	698	explicitformula
1741	U	(y+1)*(x*(y+1)+1)**3	699	generatingfunction
1744	U	((-sqrt((-4*x*y^2)-8*x*y-4*x+1))-2*x*y^2-4*x*y-2* x+1)/(2*x^2*y^3+6*x^2*y^2+6*x^2*y+2*x^2)	700	generatingfunction
1745	T	(k*binomial(2*n+k,m)*binomial(2*n+2*k,n))/(n+k)	700	explicitformula
1746	U	1/(1-y)+(2*x)/(1-y)**2+x**2/(1-y)**3	701	generatingfunction
1749	U	((-(y**2-2*y+1)*sqrt(y**2-2*y-4*x+1))-y**3+3*y**2-(3-2*x)*y-2*x+1)/(2*x**2)	702	generatingfunction
1750	T	(k*binomial(2*n+2*k,n)*binomial(2*n+m+k-1,m))/(n+ k)	702	explicitformula
1751	U	x**2*(y+1)**6+2*x*(y+1)**4+(y+1)**2	703	generatingfunction
1721	T	k/(n+k) * Tsqrt(m, n+k)*TLeftA271825(n, n+k)	689	explicitformula
1723	T	k/(2*n+k)*Tsqrt(m, 2*n+k)*TLeftA271825(n, 2*n+k)	690	explicitformula
1725	T	k/(3*n+k) * Tsqrt(m, 3*n+k)*TLeftA271825(n, 3*n+k)	691	explicitformula
1727	T	k/(4*n+k) * Tsqrt(m, 4*n+k)*TLeftA271825(n, 4*n+k)	692	explicitformula
1731	T	(k * binomial(2*n+2*k, n) * binomial(3*n+4*k, m)) / (n+k)	694	explicitformula
1733	T	binomial(n+k-1, n) * binomial(n+4*k, m)	695	explicitformula
1735	T	binomial(n+k-1, n) * binomial(n+3*k, m)	696	explicitformula
1737	T	binomial(k, n) * binomial(2*k-n, m)	697	explicitformula
1742	T	binomial(3*k, n) * binomial(n+k, m)	699	explicitformula
1754	U	((-sqrt(1-4*x*(y+1)^4))-2*x*(y+1)^4+1)/(2*x^2*(y+ 1)^6)	704	generatingfunction
1756	U	1/(1-y)**2+(2*x)/(1-y)**4+x**2/(1-y)**6	705	generatingfunction
1758	U	(((-(2*x)/(1-y)**4)-sqrt(1-(4*x)/(1-y)**4)+1)*(1-y)**6)/(2*x**2)	706	generatingfunction
1761	U	(y+1)/((-x*y)-x+1)**3	707	generatingfunction
1764	U	(y+1)**2/(1-x*(y+1)**2)**3	708	generatingfunction
1766	U	(1-sqrt(1-4*x*(y+1)))**4/(16*x**4*(y+1)**3)	709	generatingfunction
1768	U	(((x*((-2*y)-sqrt(1-4*y)+1))/(2*y**2)+1)**2*((-2*y)-sqrt(1-4*y)+1))/(2*y**2)	710	generatingfunction
1770	U	(4*((-(x*((-2*y)-sqrt(1-4*y)+1)**2)/(2*y**4))-sqrt(1-(x*((-2*y)-sqrt(1-4*y)+1)**2)/y**4)+1)*y**6)/(x**2*((-2*y)-sqrt(1-4*y)+1)**3)	711	generatingfunction
1772	U	(x/sqrt(1-4*y)+1)**2/sqrt(1-4*y)	712	generatingfunction
1774	U	(((-(2*x)/(1-4*y))-sqrt(1-(4*x)/(1-4*y))+1)*(1-4*y)**(3/2))/(2*x**2)	713	generatingfunction
1776	U	(1-sqrt(1-4*x*(y+1)))**3/(8*x**3*(y+1)**2)	714	generatingfunction
1778	U	((1-sqrt(1-(2*x*((-2*y)-sqrt(1-4*y)+1))/y**2))**3*y**4)/(2*x**3*((-2*y)-sqrt(1-4*y)+1)**2)	715	generatingfunction
1780	U	sqrt(4*y+1)*(x*sqrt(4*y+1)+1)**2	716	generatingfunction
1782	U	((-sqrt(1-4*x*(4*y+1)))-2*x*(4*y+1)+1)/(2*x**2*(4*y+1)**(3/2))	717	generatingfunction
1784	U	(y+1)**3/(y-x+1)**2	718	generatingfunction
1786	U	(y+1)**6/((y+1)**2-x)**2	719	generatingfunction
1788	U	-1/(x**2*y**3+(2*x-3*x**2)*y**2+(3*x**2-4*x+1)*y-x**2+2*x-1)	720	generatingfunction
1790	U	1/((1/(1-y)**2-x)**2*(1-y)**6)	721	generatingfunction
1792	U	(1-sqrt(1-4*y))**3/(8*((1-sqrt(1-4*y))/(2*y)-x)**2*y**3)	722	generatingfunction
1794	U	((-2*y)-sqrt(1-4*y)+1)**3/(8*(((-2*y)-sqrt(1-4*y)+1)/(2*y**2)-x)**2*y**6)	723	generatingfunction
1796	U	(y+1)*(x/(y+1)+1)**3	724	generatingfunction
1798	U	(y+1)**2*(x/(y+1)**2+1)**3	725	generatingfunction
1800	U	1/(1-x*(y+1))**2	726	generatingfunction
1802	U	((-sqrt(4*x*y+4*x+1))+2*x*y+2*x+1)/(2*x**2)	727	generatingfunction
1806	U	1/(1-x/(1-y))**2	729	generatingfunction
1808	U	((-sqrt(y**2+((-4*x)-2)*y+4*x+1))+y-2*x-1)/(2*y-2)	730	generatingfunction
1810	U	((-sqrt(1-4*x*(y+1)**2))-2*x*(y+1)**2+1)/(2*x**2*(y+1)**2)	731	generatingfunction
1812	U	(((-(2*x)/(1-y))-sqrt(1-(4*x)/(1-y))+1)*(1-y)**2)/(2*x**2)	732	generatingfunction
1814	U	(((-(2*x)/(1-y)**2)-sqrt(1-(4*x)/(1-y)**2)+1)*(1-y)**4)/(2*x**2)	733	generatingfunction
1816	U	1/(1-(x*(1-sqrt(1-4*y)))/(2*y))**2	734	generatingfunction
1818	U	(y+1)**2*(y+x)	735	generatingfunction
1820	U	(y+x)/(1-y)**2	736	generatingfunction
1822	U	1/sqrt(1-(4*x)/sqrt(1-4*y))	737	generatingfunction
1752	T	binomial(2*k, n) * binomial(2*n+2*k, m)	703	explicitformula
1755	T	k*binomial(2*n+2*k, n) * binomial(4*n+2*k, m) / (n+k)	704	explicitformula
1757	T	binomial(2*k, n) * binomial(2*n+m+2*k-1, m)	705	explicitformula
1762	T	3*k*binomial(n+k, m) * binomial(n+3*k, n) / (n+3*k)	707	explicitformula
1765	T	3*k*binomial(n+3*k, n) * binomial(2*n+2*k, m) / (n+3*k)	708	explicitformula
1767	T	2*k*binomial(n+k, m) * binomial(2*n+4*k, n) / (n + 2*k)	709	explicitformula
1771	T	k * (2*n+k) * binomial(2*n+ 2*k, n)*binomial(4*n+2*m+2*k, m) / ((n+k)*(2*n+m+k))	711	explicitformula
1769	T	binomial(2*k, n)*(n+k)*binomial(2*n+2*m+2*k, m) / (n+m+k)	710	explicitformula
1773	T	binomial(2*k, n) * TA984(m, n+k)	712	explicitformula
1775	T	k/(n+k) * binomial(2*k + 2*n, n) * TA984(m, 2*n+k)	713	explicitformula
1779	T	(3*k*(n+k)*binomial(2*n+3*k,n)*binomial(2*n+2*m+2 *k,m))/((n+m+k)*(2*n+3*k))	715	explicitformula
1777	T	( (3*k*binomial(n+k, m)*binomial(2*n+3*k,n))/(2*n+3*k))	714	explicitformula
1781	T	binomial(2*k, n) * Tsqrt(m, n+k)	716	explicitformula
1783	T	k/(n+k) * Tsqrt(m, 2*n+k)*binomial(2*n+2*k, n)	717	explicitformula
1785	T	binomial(k-n,m)*binomial(n+2*k-1,n)	718	explicitformula
1787	T	binomial(2*(k-n),m)*binomial(n+2*k-1,n)	719	explicitformula
1789	T	binomial((-n)+m+k-1,m)*binomial(n+2*k-1,n)	720	explicitformula
1791	T	binomial((-2*n)+m+2*k-1,m)*binomial(n+2*k-1,n)	721	explicitformula
1795	T	(2*binomial((-2*n)+2*m+2*k-1,m-1)*(k-n)*binomial( 3*n+2*(k-n)-1,n))/m	723	explicitformula
1793	T	(-1)**(m-1)*(k-n)*binomial(n+2*k-1,n)*binomial(n-m-k-1,m-1) / m	722	explicitformula
1797	T	(3*k*binomial(k-n, m)*(-1)**(n-1)*binomial(n-3*k-1, n-1)) / n	724	explicitformula
1801	T	binomial(n,m)*binomial(n+2*k-1,n)	726	explicitformula
1799	T	3*k*binomial(2*k-2*n,m)*(-1)**(n-1)*binomial(n-3* k-1,n-1) / n	725	explicitformula
1807	T	 binomial(n+2*k-1,n)*binomial(n+m-1, m)	729	explicitformula
1803	T	2*k*(-1)**n*binomial(n+2*k,m)*binomial(2*(n+k)-1, n+2*k-1)/(n+2*k)	727	explicitformula
1804	U	 (sqrt(4*x*y+4*x+1)+2*x*y+2*x+1)/2	728	generatingfunction
1811	T	(k*binomial(2*n+2*k,m)*binomial(2*n+2*k,n))/(n+k)	731	explicitformula
1805	T	(2*k*(-1)**(n-1)*binomial(n,m)*binomial(2*(n-k)-1, n-1))/n	728	explicitformula
1809	T	(2*k*(-1)**(n-1)*binomial(n+m-1,m)*binomial(2*n-2* k-1,n-1))/n	730	explicitformula
1815	T	(k*binomial(2*n+2*k,n)*binomial(2*n+m-1,m))/(n+k)	733	explicitformula
1813	T	(k*binomial(n+m-1,m)*binomial(2*n+2*k,n))/(n+k)	732	explicitformula
1819	T	binomial(k,n)*binomial(2*k,n+m-k)	735	explicitformula
1821	T	binomial(k,n)*binomial(n+m+k-1,n+m-k)	736	explicitformula
1823	T	((binomial(m+k/2,m))*(binomial(2*m+k,m+k/2)))/(binomial(k,k/2))*((binomial(n+k/2,n))*(binomial(2*n+k,n+k/2)))/(binomial(k,k/2))	737	explicitformula
1817	T	1	734	explicitformula
1824	U	1/(1-x*sqrt(4*y+1))	738	generatingfunction
1826	U	(1-sqrt((-4*x*y**5)-20*x*y**4-40*x*y**3-40*x*y**2-20*x*y-4*x+1))/(2*x*y**2+4*x*y+2*x)	739	generatingfunction
1827	T	 1	739	explicitformula
1828	U	(y+1)**4+x*(y+1)	740	generatingfunction
1832	U	(x*y-1)/(x*y+x-1)	742	generatingfunction
1834	U	((-sqrt(x**2*y**2-2*x*y-4*x+1))+x*y+1)/(2*x*y+2*x)	743	generatingfunction
1836	U	(1-sqrt((-4*x*y**5)-20*x*y**4-40*x*y**3-40*x*y**2-20*x*y-4*x+1))/(2*x*y+2*x)	744	generatingfunction
1838	U	1/((1-x/(1-y))*(1-y)**2)	745	generatingfunction
1840	U	1/((1-x/(1-y))*(1-y)**3)	746	generatingfunction
1842	U	(sqrt(y**4-4*y**3+6*y**2-4*y-4*x+1)-y**2+2*y-1)/(2*x*y-2*x)	747	generatingfunction
1844	U	(x*(1-y)**2+1)/(1-y)**3	748	generatingfunction
1846	U	1/((1-x/(1-y))*(1-y)**4)	749	generatingfunction
1848	U	((-sqrt(y**6-6*y**5+15*y**4-20*y**3+15*y**2+(4*x-6)*y-4*x+1))-y**3+3*y**2-3*y+1)/(2*x*y**2-4*x*y+2*x)	750	generatingfunction
1850	U	(x*(1-y)**3+1)/(1-y)**4	751	generatingfunction
1852	U	1/((1-x/(1-y)**2)*(1-y)**3)	752	generatingfunction
1854	U	(sqrt(y**6-6*y**5+15*y**4-20*y**3+15*y**2+(4*x-6)*y-4*x+1)+y**3-3*y**2+3*y-1)/(2*x*y-2*x)	753	generatingfunction
1856	U	(x*y-x-1)/(y**3-3*y**2+3*y-1)	754	generatingfunction
1858	U	((y+1)*(1-sqrt(1-4*x*(y+1))))/(2*x)	755	generatingfunction
1860	U	((y+1)**2*(1-sqrt(1-4*x*(y+1))))/(2*x)	756	generatingfunction
1862	U	((y+1)*(1-sqrt(1-4*x*(y+1)**2)))/(2*x)	757	generatingfunction
1864	U	((y+1)**2*(1-sqrt(1-4*x*(y+1)**2)))/(2*x)	758	generatingfunction
1866	U	(1-sqrt(1-(4*x)/(1-y)))/(2*x*(1-y))	759	generatingfunction
1868	U	1/(x*y**3+(1-3*x)*y**2+(3*x-2)*y-x+1)	760	generatingfunction
1870	U	(1-sqrt(1-(4*x)/(1-y)))/(2*x*(1-y)**2)	761	generatingfunction
1872	U	1/(x*y**5-5*x*y**4+(10*x-1)*y**3+(3-10*x)*y**2+(5*x-3)*y-x+1)	762	generatingfunction
1874	U	(1-sqrt(1-(4*x)/(1-y)))/(2*x*(1-y)**3)	763	generatingfunction
1876	U	1/(x*y**7-7*x*y**6+21*x*y**5+(1-35*x)*y**4+(35*x-4)*y**3+(6-21*x)*y**2+(7*x-4)*y-x+1)	764	generatingfunction
1878	U	1/((1-x/(1-y))**2*(1-y))	765	generatingfunction
1880	U	((-sqrt(4*x+1))-2*x-1)/(2*y-2)	766	generatingfunction
1882	U	(sqrt((-4*x*y)+4*x+1)-2*x*y+2*x+1)/(2*y**2-4*y+2)	767	generatingfunction
1884	U	1/((1-x/(1-y))**2*(1-y)**3)	768	generatingfunction
1886	U	((-sqrt(4*x*y**2-8*x*y+4*x+1))-2*x*y**2+4*x*y-2*x-1)/(2*y**3-6*y**2+6*y-2)	769	generatingfunction
1888	U	((y+1)**3*(1-sqrt(1-(4*x)/(y+1))))/(2*x)	770	generatingfunction
1890	U	(y+1)**5/((y+1)**3-x)	771	generatingfunction
1892	U	((y+1)**5+x)/(y+1)**3	772	generatingfunction
1894	U	((y+1)**5*(1-sqrt(1-(4*x)/(y+1)**2)))/(2*x)	773	generatingfunction
1896	U	(y+1)**8/((y+1)**5-x)	774	generatingfunction
1898	U	((y+1)**8+x)/(y+1)**5	775	generatingfunction
2184	U	 (x/(1-y)**3+1)/(1-y)**3	907	generatingfunction
1831	T	delta(m,n)*binomial(n+k-1,n)	741	explicitformula
1833	T	binomial(n-1,m)*binomial(n-m+k-1,n-m)	742	explicitformula
1835	T	(k*binomial(n-1,m)*binomial(2*n-m+k-1,n-m))/(n+k)	743	explicitformula
1837	T	(k*binomial(2*n+k-1,n)*binomial(5*n+4*k,m))/(n+k)	744	explicitformula
1839	T	binomial(n+k-1,n)*binomial(n+m+2*k-1,m)	745	explicitformula
1841	T	binomial(n+k-1,n)*binomial(n+m+3*k-1,m)	746	explicitformula
1843	T	(k*binomial(2*n+k-1,n)*binomial(4*n+m+3*k-1,m))/( n+k)	747	explicitformula
1845	T	binomial(k,n)*binomial((-2*n)+m+3*k-1,m)	748	explicitformula
1847	T	binomial(n+k-1,n)*binomial(n+m+4*k-1,m)	749	explicitformula
1849	T	(k*binomial(2*n+k-1,n)*binomial(5*n+m+4*k-1,m))/( n+k)	750	explicitformula
1851	T	 binomial(k,n)*binomial((-3*n)+m+4*k-1,m)	751	explicitformula
1853	T	 binomial(n+k-1,n)*binomial(2*n+m+3*k-1,m)	752	explicitformula
1855	T	(k*binomial(2*n+k-1,n)*binomial(5*n+m+3*k-1,m))/( n+k)	753	explicitformula
1857	T	binomial(k,n)*binomial((-n)+m+3*k-1,m)	754	explicitformula
1859	T	 (k*binomial(n+2*k,m)*binomial(2*n+k-1,n))/(n+k)	755	explicitformula
1861	T	(k*binomial(n+3*k,m)*binomial(2*n+k-1,n))/(n+k)	756	explicitformula
1863	T	 (k*binomial(2*n+k-1,n)*binomial(2*n+3*k,m))/(n+k)	757	explicitformula
1865	T	(k*binomial(2*n+k-1,n)*binomial(2*n+4*k,m))/(n+k)	758	explicitformula
1869	T	binomial((-n)+m+2*k-1,m)*binomial(n+k-1,n)	760	explicitformula
1867	T	(k*binomial(n+m+2*k-1,m)*binomial(2*n+k-1,n))/(n+k)	759	explicitformula
1871	T	 (k*binomial(n+m+3*k-1,m)*binomial(2*n+k-1,n))/(n+k)	761	explicitformula
1873	T	  binomial((-2*n)+m+3*k-1,m)*binomial(n+k-1,n)	762	explicitformula
1877	T	binomial((-3*n)+m+4*k-1,m)*binomial(n+k-1,n)	764	explicitformula
1879	T	binomial(n+2*k-1,n)*binomial(n+m+k-1,m)	765	explicitformula
1885	T	 binomial(n+2*k-1,n)*binomial(n+m+3*k-1,m)	768	explicitformula
1881	T	 binomial(m+k-1,m)	766	explicitformula
1883	T	1	767	explicitformula
1889	T	(k*binomial(2*k-n,m)*binomial(2*n+k-1,n))/(n+k)	770	explicitformula
1887	T	(binomial(m+3*k-1,m))	769	explicitformula
1891	T	 binomial(2*k-3*n,m)*binomial(n+k-1,n)	771	explicitformula
1893	T	binomial(k,n)*binomial(2*k-5*n,m)	772	explicitformula
1895	T	(k*binomial(3*k-2*n,m)*binomial(2*n+k-1,n))/(n+k)	773	explicitformula
1897	T	binomial(3*k-5*n,m)*binomial(n+k-1,n)	774	explicitformula
1825	T	binomial(n+k-1,n)*binomial(k/2,n)*4**n	738	explicitformula
1900	U	(1-sqrt(1-4*x*(1-y)))/(2*x*(1-y)**3)	776	generatingfunction
1904	U	(1/(1-y)**5+x)*(1-y)**3	778	generatingfunction
1906	U	((1-sqrt(1-(4*x)/sqrt(1-4*y)))*sqrt(1-4*y))/(2*x)	779	generatingfunction
1908	U	(1-2*x*sqrt(1+4*y)-sqrt(1-4*x*sqrt(1+4*y)))/(2*x**2*((1+4*y)))	780	generatingfunction
1910	U	(y+1)**2/(1-x/(y+1))**2	781	generatingfunction
1912	U	((y+1)*sqrt(y**4+4*y**3+6*y**2+(4*x+4)*y+4*x+1)+y**3+3*y**2+3*y+2*x+1)/(2*y+2)	782	generatingfunction
1914	U	(y+1)**3/(1-x/(y+1)**2)**2	783	generatingfunction
1916	U	((y+1)**2*sqrt(y**6+6*y**5+15*y**4+20*y**3+15*y**2+(4*x+6)*y+4*x+1)+(y+1)**5+2*x)/(2*(y+1)**2)	784	generatingfunction
1918	U	(y+1)/(1-x*(y+1))**2	785	generatingfunction
1920	U	(sqrt(4*x+1)*(y+1)+2*x*(y+1)+y+1)/2	786	generatingfunction
1922	U	(y+1)**3/(1-x/(y+1))**2	787	generatingfunction
1924	U	((y+1)**2*sqrt((y+1)**4+4*x)+(y+1)**4+2*x)/(2*(y+1))	788	generatingfunction
1926	U	1/((1-x*(1-y))**2*(1-y)**2)	789	generatingfunction
1928	U	((sqrt((4*x)/(1-y)+1/(1-y)**4)/(1-y)+1/(1-y)**3+2*x)*(1-y))/2	790	generatingfunction
1930	U	1/((1-x*(1-y)**2)**2*(1-y)**3)	791	generatingfunction
1932	U	(2*x*(1-y)**2+1/(1-y)**3+sqrt((4*x)/(1-y)+1/(1-y)**6))/2	792	generatingfunction
1934	U	1/((1-x*(1-y))**2*(1-y)**3)	793	generatingfunction
1936	U	(2*x*(1-y)+sqrt(1/(1-y)**4+4*x)/(1-y)+1/(1-y)**3)/2	794	generatingfunction
1941	U	(sqrt((-4*x*y**2)-8*x*y-4*x+1)+1)/(2*y+2)	795	generatingfunction
1943	U	(x+1)*(y+2)	796	generatingfunction
1946	U	((-y)-2)/(x*y+2*x-1)	797	generatingfunction
1948	U	(1-sqrt((-4*x*y**2)-16*x*y-16*x+1))/(2*x*y+4*x)	798	generatingfunction
1950	U	(sqrt((-4*x*y**2)-16*x*y-16*x+1)+1)/(2*y+4)	799	generatingfunction
1951	T	( (k*2**m*binomial(m+k,m)*binomial(m+k,n))/(m+k)  )	799	explicitformula
1952	U	((-sqrt(y**2+((-4*x)-2)*y+4*x**2-4*x+1))-y-2*x+1)/(4*x*y)	800	generatingfunction
1954	U	(sqrt(y**2+((-4*x)-2)*y+4*x**2-4*x+1)-y-2*x+1)/2	801	generatingfunction
1955	T	( binomial(k,n)  )	801	explicitformula
1956	T	 binomial(k-m-1,m-1)*binomial(k-m,n)*2**m*k/(m)  	801	explicitformula
1957	U	(x+1)*(2*y+1)	802	generatingfunction
1958	T	( (k*2**(m+k)*binomial(2*m+k-1,m)*(-1)**(n+m+k)*binomial(n+m-1,n))/(m+k)  )	802	explicitformula
1959	U	((-2*y)-1)/(2*x*y+x-1)	803	generatingfunction
1960	T	( binomial(k,n)  )	803	explicitformula
1961	T	 (k*binomial(-2*m+k-1,m-1)*binomial(k-2*m,n)*2**m)/m  	803	explicitformula
1962	U	((-x)-1)/((2*x+2)*y-1)	804	generatingfunction
1963	T	( binomial(k,n)*2**m*binomial(m+k-1,m)  )	804	explicitformula
1964	U	(1-sqrt(((-8*x**2)-16*x-8)*y+1))/((4*x+4)*y)	805	generatingfunction
1965	T	( (k*2**m*binomial(n+k,n)*binomial(n+m+k-1,m))/(n+k)  )	805	explicitformula
1966	U	(sqrt((8*x+8)*y+x**2+2*x+1)+x+1)/2	806	generatingfunction
1967	T	( (k*2**m*binomial(m+k,n)*binomial(2*m+k-1,m))/(m+k)  )	806	explicitformula
1968	U	((-sqrt((8*x+8)*y+x**2+2*x+1))+x+1)/2	807	generatingfunction
1969	T	( 2**(-k)  )	807	explicitformula
1970	T	( 0  )	807	explicitformula
1971	T	 -k*2**(m-k)*(binomial(m,n))*(binomial(2*m-k-1,m-1))/m  	807	explicitformula
1972	U	(((x+1)*sqrt(y*(27*y+2*x**2+4*x+2)))/3**(3/2)+(x*(27*y+3)+27*y+x**3+3*x**2+1)/27)**(1/3)+(x**2+2*x+1)/(9*(((x+1)*sqrt(y*(27*y+2*x**2+4*x+2)))/3**(3/2)+(x*(27*y+3)+27*y+x**3+3*x**2+1)/27)**(1/3))+(x+1)/3	808	generatingfunction
1973	T	( (-1)**m*binomial(m+k-1,m)  )	808	explicitformula
2185	T	 binomial(k,n)*binomial(3*(n+k)+m-1,m)	907	explicitformula
1901	T	(k*binomial(n+2*(k-n)+m-1,m)*binomial(2*n+k-1,n)) /(n+k)	776	explicitformula
1903	T	binomial((-3*n)+m+2*k-1,m)*binomial(n+k-1,n)	777	explicitformula
1905	T	binomial(k,n)*binomial((-5*n)+m+2*k-1,m)	778	explicitformula
1909	T	1	780	explicitformula
1911	T	binomial(2*k-n,m)*binomial(n+2*k-1,n)	781	explicitformula
1915	T	binomial(n+3*(k-n),m)*binomial(3*n+2*(k-n)-1,n)	783	explicitformula
1913	T	binomial(2*k,m)	782	explicitformula
1919	T	 binomial(n+k,m)*binomial(n+2*k-1,n)	785	explicitformula
1917	T	binomial(3*k,m)	784	explicitformula
1923	T	binomial(3*k-n,m)*binomial(n+2*k-1,n)	787	explicitformula
1921	T	 binomial(k,m)	786	explicitformula
1927	T	 binomial((-n)+m+2*k-1,m)*binomial(n+2*k-1,n)	789	explicitformula
1925	T	 binomial(3*k,m) 	788	explicitformula
1929	T	binomial(2*k+m-1,m)	790	explicitformula
1931	T	binomial((-2*n)+m+3*k-1,m)*binomial(n+2*k-1,n)	791	explicitformula
1933	T	binomial(3*k+m-1,m)	792	explicitformula
1935	T	binomial((-n)+m+3*k-1,m)*binomial(n+2*k-1,n)	793	explicitformula
1937	T	.	794	explicitformula
1938	T	.	794	explicitformula
1939	T	.	794	explicitformula
1940	T	 (2*k*binomial((-4*n)+m+3*k-1,m)*(-1)^(n-1)*binomi al(2*n-2*k-1,n-1))/n	794	explicitformula
1947	T	(k*2**(n-m+k)*binomial(n+k,m)*binomial(n+k,n))/(n+ k)	797	explicitformula
1945	T	binomial(k,m)*binomial(k,n)*2^(k-m)	796	explicitformula
1944	T	0	796	explicitformula
1942	T	1	795	explicitformula
1949	T	 (k*2**(2*n-m+k)*binomial(2*n+k,m)*binomial(2*n+k,n ))/(2*n+k)	798	explicitformula
1953	T	(k*2**n*binomial(n+m+k,m)*binomial(n+m+k,n))/(n+m+ k)	800	explicitformula
1974	T	 (-k*((binomial(2*n-k-1,n-1))))/n*binomial(n-k,m)  	808	explicitformula
1975	U	(x+1)/(1-2*y)	809	generatingfunction
1976	T	( (-1)**(m+k)*binomial(k,m)  )	809	explicitformula
1977	T	 (-1)**(k-1)*(k*((binomial(2*n-k-1,n-1))))/n*binomial(m+n-k-1,m)  	809	explicitformula
1978	U	-1/(2*y+x-1)	810	generatingfunction
1979	T	( (-1)**m*binomial(m+2*k-1,m)  )	810	explicitformula
1980	T	 (-k*binomial(2*n-2*k,m)*binomial(2*n-k-1,n-1))/(n)  	810	explicitformula
1981	U	sqrt(4*y+4*x**2+1)+2*x	811	generatingfunction
1982	T	( binomial(k,n+m-2*k)*binomial(2*k,m)  )	811	explicitformula
1983	U	sqrt(4*y**2+8*x*y+4*x**2+1)+2*y+2*x	812	generatingfunction
1984	T	( binomial(k,n+m-3*k)*binomial(3*k,m)  )	812	explicitformula
1985	U	sqrt(4*x*y+4*x+1)	813	generatingfunction
1986	T	( binomial(k,n+m-4*k)*binomial(4*k,m)  )	813	explicitformula
1987	U	sqrt(4*x**2*y**2+8*x**2*y+4*x**2+1)+2*x*y+2*x	814	generatingfunction
1988	T	( 0  )	814	explicitformula
1989	T	 binomial(2*k,m)*binomial(n+m-k-1,n+m-2*k)  	814	explicitformula
1990	U	sqrt(4*x**2*y**2+4*x+1)+2*x*y	815	generatingfunction
1991	T	( 0  )	815	explicitformula
1992	T	 binomial(3*k,m)*binomial(n+m-k-1,n+m-3*k)  	815	explicitformula
1993	U	(x+1)*(y+x)**2	816	generatingfunction
1994	T	( 0  )	816	explicitformula
1995	T	 binomial(4*k,m)*binomial(n+m-k-1,n+m-4*k)  	816	explicitformula
1996	U	(x+1)*(y+x)**3	817	generatingfunction
1997	T	( (k*binomial(m+k,n-m-2*k)*binomial(2*(m+k),m))/(m+k)  )	817	explicitformula
1998	U	(x+1)*(y+x)**4	818	generatingfunction
1999	T	( (k*binomial(2*m+2*k,m)*binomial(n+k-1,n-m))/(m+k)  )	818	explicitformula
2000	U	(y+x)**2/(1-x)	819	generatingfunction
2001	T	( binomial(2*k,m)*binomial(2*k,n+m-2*k)  )	819	explicitformula
2002	U	(y+x)**3/(1-x)	820	generatingfunction
2003	T	( binomial(k,m)*binomial(2*k,n+m-k)  )	820	explicitformula
2004	U	(y+x)**4/(1-x)	821	generatingfunction
2005	T	( binomial(k,m)*binomial(3*k,n+m-k)  )	821	explicitformula
2006	U	((-x**2)-1)/(x*y-1)	822	generatingfunction
2007	T	( int((binomial(k,int((n+m)/2))*((-1)**m+1)*binomial(int((n+m)/2),int(n/2))*((-1)**n+1))/4 ) )	822	explicitformula
2008	U	((-sqrt(4*x*y+4*x**2+1))-2*x*y-1)/(2*y**2-2)	823	generatingfunction
2009	T	( binomial(k,n-m)*binomial(n-m,m)  )	823	explicitformula
2010	U	(sqrt(4*x*y+4*x**2+1)-2*x*y-1)/(x**2*(2*y**2-2))	824	generatingfunction
2011	T	( (k*binomial(n+k,n-m)*binomial(n-m,m))/(n+k)  )	824	explicitformula
2012	U	(1-sqrt((-4*x*y)-4*x**2+1))/(2*x*y+2*x**2)	825	generatingfunction
2013	T	( 0  )	825	explicitformula
2014	T	( (-1)**n*binomial(k,n)  )	825	explicitformula
2015	T	 -k/m*binomial(n-m-1,m-1)*binomial(n-k-1,n-m-1)  	825	explicitformula
2016	U	1/(1-x*(4*y+1)**(3/2))	826	generatingfunction
2017	T	( binomial(n,m)  )	826	explicitformula
2018	T	 (k*((binomial(3*n-k-1,n-1))*(-1)**(n-1)))/n*binomial(n,m)  	826	explicitformula
2019	U	(x*(4*y+1)**(3/2)+1)**2	827	generatingfunction
2020	T	( binomial(n+k,m)  )	827	explicitformula
2021	T	 (k*((binomial(3*n-k-1,n-1))*(-1)**(n-1)))/n*binomial(n+k,m)  	827	explicitformula
2022	U	1/(1-x*(4*y+1)**(3/2))**2	828	generatingfunction
2023	T	( binomial(n-k,m)  )	828	explicitformula
2024	T	 (k*((binomial(3*n-k-1,n-1))*(-1)**(n-1)))/n*binomial(n-k,m)  	828	explicitformula
2025	U	(1-sqrt(sqrt(4*y+1)*((-16*x*y)-4*x)+1))/(sqrt(4*y+1)*(8*x*y+2*x))	829	generatingfunction
2026	T	( binomial(n-2*k,m)  )	829	explicitformula
2027	T	 (k*((binomial(3*n-k-1,n-1))*(-1)**(n-1)))/n*binomial(n-2*k,m)  	829	explicitformula
2028	U	(sqrt(4*x*(y+1)+1)+1)/(2*(y+1))	830	generatingfunction
2029	T	( binomial(n-k,m)*binomial(n+k-1,n)  )	830	explicitformula
2030	U	(sqrt(4*x*(y+1)+1)+1)/(2*(y+1)**2)	831	generatingfunction
2031	T	( binomial(n-2*k,m)*binomial(n+k-1,n)  )	831	explicitformula
2032	U	((y+1)**2*(sqrt(4*x*(y+1)+1)+1))/2	832	generatingfunction
2033	T	( (k*binomial(n-k,m)*binomial(2*n+k-1,n))/(n+k)  )	832	explicitformula
2034	U	(y+1)**2*(x*(y+1)+1)	833	generatingfunction
2035	T	( (k*binomial(n-2*k,m)*binomial(2*n+k-1,n))/(n+k)  )	833	explicitformula
2036	U	(x*(y+1)+1)/(y+1)**2	834	generatingfunction
2037	T	( (k*binomial(n+k,m)*binomial(2*n+2*k,n))/(n+k)  )	834	explicitformula
2038	U	1/((y+1)*(1-x*(y+1)))	835	generatingfunction
2039	T	( (k*binomial(n+2*k,m)*binomial(2*n+2*k,n))/(n+k)  )	835	explicitformula
2040	U	1/((y+1)**2*(1-x*(y+1)))	836	generatingfunction
2041	T	( (k*binomial(n-k,m)*binomial(2*n+2*k,n))/(n+k)  )	836	explicitformula
2042	U	(1-sqrt(1-4*x*(y+1)))/(2*x*(y+1)**2)	837	generatingfunction
2043	T	( (k*binomial(n-2*k,m)*binomial(2*n+2*k,n))/(n+k)  )	837	explicitformula
2044	U	((-sqrt(1-4*x*(y+1)))-2*x*(y+1)+1)/(2*x**2*(y+1)**3)	838	generatingfunction
2045	T	( binomial(n+k-1,n)*binomial(n+m-k-1,m)  )	838	explicitformula
2046	U	((-sqrt(1-4*x*(y+1)))-2*x*(y+1)+1)/(2*x**2*(y+1)**4)	839	generatingfunction
2047	T	( binomial(n+k-1,n)*binomial(n+m-2*k-1,m)  )	839	explicitformula
2048	U	(x+1)**2/sqrt(1-4*(x+1)*y)	840	generatingfunction
2049	T	( binomial(n+k-1,n)  )	840	explicitformula
2050	T	 binomial(n+k-1,n)*(n-k)*binomial(2*m+n-k-1,m-1)/m  	840	explicitformula
2051	U	1/((x+1)*sqrt(1-4*(x+1)*y))	841	generatingfunction
2052	T	( binomial(n+k-1,n)  )	841	explicitformula
2053	T	 binomial(n+k-1,n)*(n-2*k)*binomial(2*m+n-2*k-1,m-1)/m  	841	explicitformula
2054	U	((x*(1-sqrt(1-4*y))**3)/(8*y**3)+1)**3	842	generatingfunction
2055	T	(3*binomial(3*k,n)*n*binomial(3*n+2*m-1,m))/(3*n+ m)	842	explicitformula
2056	U	1/(1-(x*(1-sqrt(1-4*y))**3)/(8*y**3))	843	generatingfunction
2057	T	(3*n*binomial(n+k-1,n)*binomial(3*n+2*m-1,m))/(3* n+m)	843	explicitformula
2058	U	 1/(1-(x*((-2*y)-sqrt(1-4*y)+1)**2)/(4*y**4))	844	generatingfunction
2059	T	(2*n*binomial(n+k-1,n)*binomial(4*n+2*m,m))/(2*n+ m)	844	explicitformula
2060	U	1/(1-(x*((-2*y)-sqrt(1-4*y)+1)**3)/(8*y**6))	845	generatingfunction
2061	T	(3*n*binomial(n+k-1,n)*binomial(6*n+2*m,m))/(3*n+ m)	845	explicitformula
2062	U	1/(1-x*(y+1)^2)^2	846	generatingfunction
2063	T	binomial(2*n,m)*binomial(n+2*k-1,n)	846	explicitformula
2064	U	1/(1-x*(y+1)**3)**2	847	generatingfunction
2065	T	binomial(3*n,m)*binomial(n+2*k-1,n)	847	explicitformula
2066	U	1/(1-x/(1-y)**2)**2	848	generatingfunction
2067	T	 binomial(n+2*k-1,n)*binomial(2*n+m-1,m)	848	explicitformula
2068	U	1/(1-x/(1-y)**3)**2	849	generatingfunction
2069	T	binomial(n+2*k-1,n)*binomial(3*n+m-1,m)	849	explicitformula
2070	U	1/(1-(x*(1-sqrt(1-4*y))^2)/(4*y^2))^2	850	generatingfunction
2071	T	(2*n*binomial(n+2*k-1,n)*binomial(2*n+2*m-1,m))/( 2*n+m)	850	explicitformula
2072	U	1/(1-(x*(1-sqrt(1-4*y))^3)/(8*y^3))^2	851	generatingfunction
2073	T	(3*n*binomial(n+2*k-1,n)*binomial(3*n+2*m-1,m))/( 3*n+m)	851	explicitformula
2074	U	1/(1-(x*((-2*y)-sqrt(1-4*y)+1)**2)/(4*y**4))**2	852	generatingfunction
2075	T	(2*n*binomial(n+2*k-1,n)*binomial(4*n+2*m,m))/(2* n+m)	852	explicitformula
2076	U	1/(1-(x*((-2*y)-sqrt(1-4*y)+1)**3)/(8*y**6))**2	853	generatingfunction
2077	T	(3*n*binomial(n+2*k-1,n)*binomial(6*n+2*m,m))/(3*n+m)	853	explicitformula
2078	U	 1/(1-x*(y+1))**3	854	generatingfunction
2079	T	binomial(n,m)*binomial(n+3*k-1,n)	854	explicitformula
2080	U	1/(1-x*(y+1)**2)**3	855	generatingfunction
2081	T	binomial(2*n,m)*binomial(n+3*k-1,n)	855	explicitformula
2082	U	1/(1-x*(y+1)**3)**3	856	generatingfunction
2083	T	binomial(3*n,m)*binomial(n+3*k-1,n)	856	explicitformula
2084	U	 1/(1-x/(1-y))^3	857	generatingfunction
2085	T	binomial(n+3*k-1,n)*binomial(n+m-1,m)	857	explicitformula
2086	U	1/(1-x/(1-y)**2)**3	858	generatingfunction
2087	T	binomial(n+3*k-1,n)*binomial(2*n+m-1,m)	858	explicitformula
2088	U	1/(1-x/(1-y)**3)**3	859	generatingfunction
2089	T	binomial(n+3*k-1,n)*binomial(3*n+m-1,m)	859	explicitformula
2090	U	1/(1-(x*(1-sqrt(1-4*y)))/(2*y))**3	860	generatingfunction
2091	T	(n*binomial(n+3*k-1,n)*binomial(n+2*m-1,m))/(n+m)	860	explicitformula
2092	U	1/(1-(x*(1-sqrt(1-4*y))**2)/(4*y**2))**3	861	generatingfunction
2093	T	(2*n*binomial(n+3*k-1,n)*binomial(2*n+2*m-1,m))/( 2*n+m)	861	explicitformula
2094	U	 1/(1-(x*(1-sqrt(1-4*y))**3)/(8*y**3))**3	862	generatingfunction
2095	T	(3*n*binomial(n+3*k-1,n)*binomial(3*n+2*m-1,m))/( 3*n+m)	862	explicitformula
2096	U	 1/(1-(x*((-2*y)-sqrt(1-4*y)+1)**2)/(4*y**4))**3	863	generatingfunction
2097	T	 (2*n*binomial(n+3*k-1,n)*binomial(4*n+2*m,m))/(2* n+m)	863	explicitformula
2098	U	1/(1-(x*((-2*y)-sqrt(1-4*y)+1)**3)/(8*y**6))**3	864	generatingfunction
2099	T	 (3*n*binomial(n+3*k-1,n)*binomial(6*n+2*m,m))/(3* n+m)	864	explicitformula
2100	U	 ((1-sqrt(1-(4*x)/(1-y)**3))*(1-y)**3)/(2*x)	865	generatingfunction
2101	T	(k*binomial(2*n+k-1,n)*binomial(3*n+m-1,m))/(n+k)	865	explicitformula
2102	U	 (4*(1-sqrt(1-(x*(1-sqrt(1-4*y))**3)/(2*y**3)))*y**3) /(x*(1-sqrt(1-4*y))**3)	866	generatingfunction
2103	T	 (3*k*n*binomial(2*n+k-1,n)*binomial(3*n+2*m-1,m)) /((n+k)*(3*n+m))	866	explicitformula
2104	U	(2*(1-sqrt(1-(x*((-2*y)-sqrt(1-4*y)+1)**2)/y**4))*y **4)/(x*((-2*y)-sqrt(1-4*y)+1)**2)	867	generatingfunction
2105	T	 (2*k*n*binomial(2*n+k-1,n)*binomial(4*n+2*m,m))/( (n+k)*(2*n+m))	867	explicitformula
2106	U	(4*(1-sqrt(1-(x*((-2*y)-sqrt(1-4*y)+1)**3)/(2*y**6) ))*y**6)/(x*((-2*y)-sqrt(1-4*y)+1)**3)	868	generatingfunction
2107	T	 (3*k*n*binomial(2*n+k-1,n)*binomial(6*n+2*m,m))/( (n+k)*(3*n+m))	868	explicitformula
2108	U	(1-sqrt(1-4*x*(y+1)**2))**2/(4*x**2*(y+1)**4)	869	generatingfunction
2109	T	(2*k*binomial(2*n,m)*binomial(2*n+2*k-1,n))/(n+2*k)	869	explicitformula
2110	U	(1-sqrt(1-4*x*(y+1)**3))**2/(4*x**2*(y+1)**6)	870	generatingfunction
2111	T	(2*k*binomial(3*n,m)*binomial(2*n+2*k-1,n))/(n+2* k)	870	explicitformula
2112	U	((1-sqrt(1-(4*x)/(1-y)**3))**2*(1-y)**6)/(4*x**2)	871	generatingfunction
2113	T	 (2*k*binomial(2*n+2*k-1,n)*binomial(3*n+m-1,m))/( n+2*k)	871	explicitformula
2114	U	(4*(1-sqrt(1-(x*(1-sqrt(1-4*y))**2)/y**2))**2*y**4)/( x**2*(1-sqrt(1-4*y))**4)	872	generatingfunction
2115	T	 (4*k*n*binomial(2*n+2*k-1,n)*binomial(2*n+2*m-1,m ))/((n+2*k)*(2*n+m))	872	explicitformula
2116	U	(16*(1-sqrt(1-(x*(1-sqrt(1-4*y))**3)/(2*y**3)))**2*y **6)/(x**2*(1-sqrt(1-4*y))**6)	873	generatingfunction
2117	T	(6*k*n*binomial(2*n+2*k-1,n)*binomial(3*n+2*m-1,m ))/((n+2*k)*(3*n+m))	873	explicitformula
2118	U	 (4*(1-sqrt(1-(x*((-2*y)-sqrt(1-4*y)+1)**2)/y**4))**2 *y**8)/(x**2*((-2*y)-sqrt(1-4*y)+1)**4)	874	generatingfunction
2119	T	 (4*k*n*binomial(2*n+2*k-1,n)*binomial(4*n+2*m,m)) /((n+2*k)*(2*n+m))	874	explicitformula
2120	U	(16*(1-sqrt(1-(x*((-2*y)-sqrt(1-4*y)+1)**3)/(2*y**6 )))**2*y**12)/(x**2*((-2*y)-sqrt(1-4*y)+1)**6)	875	generatingfunction
2121	T	(6*k*n*binomial(2*n+2*k-1,n)*binomial(6*n+2*m,m)) /((n+2*k)*(3*n+m))	875	explicitformula
2122	U	 (1-sqrt(1-4*x*(y+1)))**3/(8*x**3*(y+1)**3)	876	generatingfunction
2123	T	 (3*k*binomial(n,m)*binomial(2*n+3*k-1,n))/(n+3*k)	876	explicitformula
2124	U	(1-sqrt(1-4*x*(y+1)**2))**3/(8*x**3*(y+1)**6)	877	generatingfunction
2125	T	(3*k*binomial(2*n,m)*binomial(2*n+3*k-1,n))/(n+3* k)	877	explicitformula
2126	U	(1-sqrt(1-4*x*(y+1)**3))**3/(8*x**3*(y+1)**9)	878	generatingfunction
2127	T	(3*k*binomial(3*n,m)*binomial(2*n+3*k-1,n))/(n+3*k)	878	explicitformula
2128	U	 ((1-sqrt(1-(4*x)/(1-y)))**3*(1-y)**3)/(8*x**3)	879	generatingfunction
2129	T	(3*k*binomial(n+m-1,m)*binomial(2*n+3*k-1,n))/(n+ 3*k)	879	explicitformula
2130	U	((1-sqrt(1-(4*x)/(1-y)**2))**3*(1-y)**6)/(8*x**3)	880	generatingfunction
2131	T	(3*k*binomial(2*n+3*k-1,n)*binomial(2*n+m-1,m))/( n+3*k)	880	explicitformula
2132	U	 ((1-sqrt(1-(4*x)/(1-y)**3))**3*(1-y)**9)/(8*x**3)	881	generatingfunction
2133	T	 (3*k*binomial(2*n+3*k-1,n)*binomial(3*n+m-1,m))/( n+3*k)	881	explicitformula
2134	U	((1-sqrt(1-(2*x*(1-sqrt(1-4*y)))/y))**3*y**3)/(x^3* (1-sqrt(1-4*y))**3)	882	generatingfunction
2135	T	 (3*k*n*binomial(n+2*m-1,m)*binomial(2*n+3*k-1,n)) /((n+3*k)*(n+m))	882	explicitformula
2136	U	 (8*(1-sqrt(1-(x*(1-sqrt(1-4*y))**2)/y**2))**3*y**6)/( x**3*(1-sqrt(1-4*y))**6)	883	generatingfunction
2137	T	 (6*k*n*binomial(2*n+3*k-1,n)*binomial(2*n+2*m-1,m ))/((n+3*k)*(2*n+m))	883	explicitformula
2138	U	(64*(1-sqrt(1-(x*(1-sqrt(1-4*y))**3)/(2*y**3)))**3*y **9)/(x**3*(1-sqrt(1-4*y))**9)	884	generatingfunction
2139	T	(9*k*n*binomial(2*n+3*k-1,n)*binomial(3*n+2*m-1,m ))/((n+3*k)*(3*n+m))	884	explicitformula
2140	U	 (8*(1-sqrt(1-(x*((-2*y)-sqrt(1-4*y)+1)**2)/y**4))**3 *y**12)/(x**3*((-2*y)-sqrt(1-4*y)+1)**6)	885	generatingfunction
2141	T	 (6*k*n*binomial(2*n+3*k-1,n)*binomial(4*n+2*m,m)) /((n+3*k)*(2*n+m))	885	explicitformula
2142	U	 (64*(1-sqrt(1-(x*((-2*y)-sqrt(1-4*y)+1)**3)/(2*y**6 )))**3*y**18)/(x**3*((-2*y)-sqrt(1-4*y)+1)**9)	886	generatingfunction
2143	T	(9*k*n*binomial(2*n+3*k-1,n)*binomial(6*n+2*m,m)) /((n+3*k)*(3*n+m))	886	explicitformula
2144	U	((-sqrt(1-4*x*(y+1)**2))-2*x*(y+1)**2+1)**2/(4*x**4*( y+1)**8)	887	generatingfunction
2145	T	(2*k*binomial(2*n,m)*binomial(2*n+4*k,n))/(n+2*k)	887	explicitformula
2146	U	((-sqrt(1-4*x*(y+1)**3))-2*x*(y+1)**3+1)**2/(4*x**4*( y+1)**12)	888	generatingfunction
2147	T	 (2*k*binomial(3*n,m)*binomial(2*n+4*k,n))/(n+2*k)	888	explicitformula
2148	U	(((-(2*x)/(1-y))-sqrt(1-(4*x)/(1-y))+1)**2*(1-y)**4 )/(4*x**4)	889	generatingfunction
2149	T	(2*k*binomial(n+m-1,m)*binomial(2*n+4*k,n))/(n+2* k)	889	explicitformula
2150	U	(((-(2*x)/(1-y)**2)-sqrt(1-(4*x)/(1-y)**2)+1)**2*(1- y)**8)/(4*x**4)	890	generatingfunction
2151	T	 (2*k*binomial(2*n+4*k,n)*binomial(2*n+m-1,m))/(n+ 2*k)	890	explicitformula
2152	U	(((-(2*x)/(1-y)**3)-sqrt(1-(4*x)/(1-y)**3)+1)**2*(1- y)**12)/(4*x**4)	891	generatingfunction
2153	T	 (2*k*binomial(2*n+4*k,n)*binomial(3*n+m-1,m))/(n+ 2*k)	891	explicitformula
2154	U	 (4*((-(x*(1-sqrt(1-4*y)))/y)-sqrt(1-(2*x*(1-sqrt( 1-4*y)))/y)+1)**2*y**4)/(x**4*(1-sqrt(1-4*y))**4)	892	generatingfunction
2155	T	 (2*k*n*binomial(n+2*m-1,m)*binomial(2*n+4*k,n))/( (n+2*k)*(n+m))	892	explicitformula
2156	U	(64*((-(x*(1-sqrt(1-4*y))**2)/(2*y**2))-sqrt(1-(x*( 1-sqrt(1-4*y))**2)/y**2)+1)**2*y**8)/(x**4*(1-sqrt(1-4 *y))**8)	893	generatingfunction
2157	T	 (4*k*n*binomial(2*n+4*k,n)*binomial(2*n+2*m-1,m)) /((n+2*k)*(2*n+m))	893	explicitformula
2158	U	 (1024*((-(x*(1-sqrt(1-4*y))**3)/(4*y**3))-sqrt(1-(x *(1-sqrt(1-4*y))**3)/(2*y**3))+1)**2*y**12)/(x**4*(1-sqrt(1-4*y))**12)	894	generatingfunction
2159	T	(6*k*n*binomial(2*n+4*k,n)*binomial(3*n+2*m-1,m)) /((n+2*k)*(3*n+m))	894	explicitformula
2160	U	(1024*((-(x*((-2*y)-sqrt(1-4*y)+1)**3)/(4*y**6))-sqrt(1-(x*((-2*y)-sqrt(1-4*y)+1)**3)/(2*y**6))+1)**2*y**24)/(x**4*((-2*y)-sqrt(1-4*y)+1)**12)	895	generatingfunction
2161	T	 (6*k*n*binomial(2*n+4*k,n)*binomial(6*n+2*m,m))/( (n+2*k)*(3*n+m))	895	explicitformula
2162	U	 ((-sqrt(1-4*x*(y+1)))-2*x*(y+1)+1)**3/(8*x**6*(y+1) **6)	896	generatingfunction
2163	T	(3*k*binomial(n,m)*binomial(2*n+6*k,n))/(n+3*k)	896	explicitformula
2164	U	((-sqrt(1-4*x*(y+1)**2))-2*x*(y+1)**2+1)**3/(8*x**6*( y+1)**12)	897	generatingfunction
2165	T	(3*k*binomial(2*n,m)*binomial(2*n+6*k,n))/(n+3*k)	897	explicitformula
2166	U	((-sqrt(1-4*x*(y+1)**3))-2*x*(y+1)**3+1)**3/(8*x**6*( y+1)**18)	898	generatingfunction
2167	T	(3*k*binomial(3*n,m)*binomial(2*n+6*k,n))/(n+3*k)	898	explicitformula
2168	U	 (((-(2*x)/(1-y))-sqrt(1-(4*x)/(1-y))+1)**3*(1-y)**6 )/(8*x**6)	899	generatingfunction
2169	T	(3*k*binomial(n+m-1,m)*binomial(2*n+6*k,n))/(n+3*k)	899	explicitformula
2170	U	(((-(2*x)/(1-y)**2)-sqrt(1-(4*x)/(1-y)**2)+1)**3*(1- y)**12)/(8*x**6)	900	generatingfunction
2171	T	 (3*k*binomial(2*n+6*k,n)*binomial(2*n+m-1,m))/(n+ 3*k)	900	explicitformula
2172	U	(((-(2*x)/(1-y)**3)-sqrt(1-(4*x)/(1-y)**3)+1)**3*(1- y)**18)/(8*x**6)	901	generatingfunction
2173	T	(3*k*binomial(2*n+6*k,n)*binomial(3*n+m-1,m))/(n+ 3*k)	901	explicitformula
2174	U	(8*((-(x*(1-sqrt(1-4*y)))/y)-sqrt(1-(2*x*(1-sqrt( 1-4*y)))/y)+1)**3*y**6)/(x**6*(1-sqrt(1-4*y))**6)	902	generatingfunction
2175	T	 (3*k*n*binomial(n+2*m-1,m)*binomial(2*n+6*k,n))/( (n+3*k)*(n+m))	902	explicitformula
2176	U	(512*((-(x*(1-sqrt(1-4*y))**2)/(2*y**2))-sqrt(1-(x* (1-sqrt(1-4*y))**2)/y**2)+1)**3*y**12)/(x**6*(1-sqrt(1 -4*y))**12)	903	generatingfunction
2177	T	 (6*k*n*binomial(2*n+6*k,n)*binomial(2*n+2*m-1,m)) /((n+3*k)*(2*n+m))	903	explicitformula
2178	U	 (32768*((-(x*(1-sqrt(1-4*y))**3)/(4*y**3))-sqrt(1-( x*(1-sqrt(1-4*y))**3)/(2*y**3))+1)**3*y**18)/(x**6*(1- sqrt(1-4*y))**18)	904	generatingfunction
2179	T	(9*k*n*binomial(2*n+6*k,n)*binomial(3*n+2*m-1,m)) /((n+3*k)*(3*n+m))	904	explicitformula
2180	U	(512*((-(x*((-2*y)-sqrt(1-4*y)+1)**2)/(2*y**4))-sqrt(1-(x*((-2*y)-sqrt(1-4*y)+1)**2)/y**4)+1)**3*y**24)/ (x**6*((-2*y)-sqrt(1-4*y)+1)**12)	905	generatingfunction
2181	T	 (6*k*n*binomial(2*n+6*k,n)*binomial(4*n+2*m,m))/( (n+3*k)*(2*n+m))	905	explicitformula
2182	U	 (32768*((-(x*((-2*y)-sqrt(1-4*y)+1)**3)/(4*y**6))-sqrt(1-(x*((-2*y)-sqrt(1-4*y)+1)**3)/(2*y**6))+1)**3* y**36)/(x**6*((-2*y)-sqrt(1-4*y)+1)**18)	906	generatingfunction
2183	T	 (9*k*n*binomial(2*n+6*k,n)*binomial(6*n+2*m,m))/( (n+3*k)*(3*n+m))	906	explicitformula
2186	U	 ((1-sqrt(1-4*y))**3*((x*(1-sqrt(1-4*y))**3)/(8*y**3) +1))/(8*y**3)	908	generatingfunction
2187	T	 (3*binomial(k,n)*(n+k)*binomial(3*(n+k)+2*m-1,m)) /(3*(n+k)+m)	908	explicitformula
2188	U	 (((x*((-2*y)-sqrt(1-4*y)+1)**2)/(4*y**4)+1)*((-2*y) -sqrt(1-4*y)+1)**2)/(4*y**4)	909	generatingfunction
2189	T	(2*binomial(k,n)*(n+k)*binomial(4*(n+k)+2*m,m))/( 2*(n+k)+m)	909	explicitformula
2190	U	 (((x*((-2*y)-sqrt(1-4*y)+1)**3)/(8*y**6)+1)*((-2*y) -sqrt(1-4*y)+1)**3)/(8*y**6)	910	generatingfunction
2191	T	 (3*binomial(k,n)*(n+k)*binomial(6*(n+k)+2*m,m))/( 3*(n+k)+m)	910	explicitformula
2192	U	 (y+1)**3*(x*(y+1)**3+1)**2	911	generatingfunction
2193	T	binomial(2*k,n)*binomial(3*(n+k),m)	911	explicitformula
2194	U	(x/(1-y)**3+1)**2/(1-y)**3	912	generatingfunction
2195	T	 binomial(2*k,n)*binomial(3*(n+k)+m-1,m)	912	explicitformula
2196	U	((1-sqrt(1-4*y))**3*((x*(1-sqrt(1-4*y))**3)/(8*y**3) +1)**2)/(8*y**3)	913	generatingfunction
2197	T	 (3*binomial(2*k,n)*(n+k)*binomial(3*(n+k)+2*m-1,m ))/(3*(n+k)+m)	913	explicitformula
2198	U	 (((x*((-2*y)-sqrt(1-4*y)+1)**2)/(4*y**4)+1)**2*((-2* y)-sqrt(1-4*y)+1)**2)/(4*y**4)	914	generatingfunction
2199	T	(2*binomial(2*k,n)*(n+k)*binomial(4*(n+k)+2*m,m)) /(2*(n+k)+m)	914	explicitformula
2200	U	 (((x*((-2*y)-sqrt(1-4*y)+1)**3)/(8*y**6)+1)**2*((-2* y)-sqrt(1-4*y)+1)**3)/(8*y**6)	915	generatingfunction
2201	T	 (3*binomial(2*k,n)*(n+k)*binomial(6*(n+k)+2*m,m)) /(3*(n+k)+m)	915	explicitformula
2202	U	 (y+1)**2*(x*(y+1)**2+1)**3	916	generatingfunction
2203	T	binomial(3*k,n)*binomial(2*(n+k),m)	916	explicitformula
2204	U	(y+1)**3*(x*(y+1)**3+1)**3	917	generatingfunction
2205	T	binomial(3*k,n)*binomial(3*(n+k),m)	917	explicitformula
2206	U	(x/(1-y)+1)**3/(1-y)	918	generatingfunction
2207	T	binomial(3*k,n)*binomial(n+m+k-1,m)	918	explicitformula
2208	U	(x/(1-y)**2+1)**3/(1-y)**2	919	generatingfunction
2209	T	binomial(3*k,n)*binomial(2*(n+k)+m-1,m)	919	explicitformula
2210	U	 (x/(1-y)**3+1)**3/(1-y)**3	920	generatingfunction
2211	T	binomial(3*k,n)*binomial(3*(n+k)+m-1,m)	920	explicitformula
2212	U	 ((1-sqrt(1-4*y))*((x*(1-sqrt(1-4*y)))/(2*y)+1)**3) /(2*y)	921	generatingfunction
2213	T	(binomial(3*k,n)*(n+k)*binomial(n+2*m+k-1,m))/(n+ m+k)	921	explicitformula
2214	U	((1-sqrt(1-4*y))**2*((x*(1-sqrt(1-4*y))**2)/(4*y**2) +1)**3)/(4*y**2)	922	generatingfunction
2215	T	(2*binomial(3*k,n)*(n+k)*binomial(2*(n+k)+2*m-1,m ))/(2*(n+k)+m)	922	explicitformula
2216	U	 ((1-sqrt(1-4*y))**3*((x*(1-sqrt(1-4*y))**3)/(8*y**3) +1)**3)/(8*y**3)	923	generatingfunction
2217	T	(3*binomial(3*k,n)*(n+k)*binomial(3*(n+k)+2*m-1,m ))/(3*(n+k)+m)	923	explicitformula
2218	U	(((x*((-2*y)-sqrt(1-4*y)+1)**2)/(4*y**4)+1)**3*((-2* y)-sqrt(1-4*y)+1)**2)/(4*y**4)	924	generatingfunction
2219	T	(2*binomial(3*k,n)*(n+k)*binomial(4*(n+k)+2*m,m)) /(2*(n+k)+m)	924	explicitformula
2220	U	 (((x*((-2*y)-sqrt(1-4*y)+1)**3)/(8*y**6)+1)**3*((-2* y)-sqrt(1-4*y)+1)**3)/(8*y**6)	925	generatingfunction
2221	T	(3*binomial(3*k,n)*(n+k)*binomial(6*(n+k)+2*m,m)) /(3*(n+k)+m)	925	explicitformula
2222	U	 1/((1-x/(1-y)**3)*(1-y)**3)	926	generatingfunction
2223	T	binomial(n+k-1,n)*binomial(3*(n+k)+m-1,m)	926	explicitformula
2224	U	 (1-sqrt(1-4*y))**3/(8*(1-(x*(1-sqrt(1-4*y))**3)/(8* y**3))*y**3)	927	generatingfunction
2225	T	(3*(n+k)*binomial(n+k-1,n)*binomial(3*(n+k)+2*m-1 ,m))/(3*(n+k)+m)	927	explicitformula
2226	U	((-2*y)-sqrt(1-4*y)+1)**2/(4*(1-(x*((-2*y)-sqrt(1- 4*y)+1)**2)/(4*y**4))*y**4)	928	generatingfunction
2227	T	(2*(n+k)*binomial(n+k-1,n)*binomial(4*(n+k)+2*m,m ))/(2*(n+k)+m)	928	explicitformula
2228	U	 ((-2*y)-sqrt(1-4*y)+1)**3/(8*(1-(x*((-2*y)-sqrt(1- 4*y)+1)**3)/(8*y**6))*y**6)	929	generatingfunction
2229	T	 (3*(n+k)*binomial(n+k-1,n)*binomial(6*(n+k)+2*m,m ))/(3*(n+k)+m)	929	explicitformula
2230	U	 (y+1)**2/(1-x*(y+1)**2)**2	930	generatingfunction
2231	T	binomial(2*(n+k),m)*binomial(n+2*k-1,n)	930	explicitformula
2232	U	(y+1)**3/(1-x*(y+1)**3)**2	931	generatingfunction
2233	T	 binomial(3*(n+k),m)*binomial(n+2*k-1,n)	931	explicitformula
2234	U	 1/((1-x/(1-y)**2)**2*(1-y)**2)	932	generatingfunction
2235	T	binomial(n+2*k-1,n)*binomial(2*(n+k)+m-1,m)	932	explicitformula
2236	U	1/((1-x/(1-y)**3)**2*(1-y)**3)	933	generatingfunction
2237	T	binomial(n+2*k-1,n)*binomial(3*(n+k)+m-1,m)	933	explicitformula
2238	U	 (1-sqrt(1-4*y))**2/(4*(1-(x*(1-sqrt(1-4*y))**2)/(4* y**2))**2*y**2)	934	generatingfunction
2239	T	(2*(n+k)*binomial(n+2*k-1,n)*binomial(2*(n+k)+2*m -1,m))/(2*(n+k)+m)	934	explicitformula
2240	U	 (1-sqrt(1-4*y))**3/(8*(1-(x*(1-sqrt(1-4*y))**3)/(8* y**3))**2*y**3)	935	generatingfunction
2241	T	(3*(n+k)*binomial(n+2*k-1,n)*binomial(3*(n+k)+2*m -1,m))/(3*(n+k)+m)	935	explicitformula
2242	U	y/(1-x)+1	936	generatingfunction
2243	T	binomial(k,m)*binomial(n+m-1,n)	936	explicitformula
2244	U	 (y/(1-x)+1)/(1-x)^2	937	generatingfunction
2245	T	binomial(k,m)*binomial(n+m+2*k-1,n)	937	explicitformula
2246	U	 (y/(1-x)+1)/(1-x)^3	938	generatingfunction
2247	T	 binomial(k,m)*binomial(n+m+3*k-1,n)	938	explicitformula
2248	U	(y/(1-x)^2+1)/(1-x)^3	939	generatingfunction
2249	T	 binomial(k,m)*binomial(n+2*m+3*k-1,n)	939	explicitformula
2250	U	(y/(1-x)^3+1)/(1-x)	940	generatingfunction
2251	T	binomial(k,m)*binomial(n+3*m+k-1,n)	940	explicitformula
2252	U	(y/(1-x)^3+1)/(1-x)^2	941	generatingfunction
2253	T	 binomial(k,m)*binomial(n+3*m+2*k-1,n)	941	explicitformula
2254	U	 (y/(1-x)^3+1)/(1-x)^3	942	generatingfunction
2255	T	 binomial(k,m)*binomial(n+3*m+3*k-1,n)	942	explicitformula
2256	U	(x+1)*y+1	943	generatingfunction
2257	T	 binomial(k,m)*binomial(m,n)	943	explicitformula
2258	U	(x+1)^2*((x+1)*y+1)	944	generatingfunction
2259	T	binomial(k,m)*binomial(m+2*k,n)	944	explicitformula
2260	U	 (x+1)^3*((x+1)*y+1)	945	generatingfunction
2261	T	 binomial(k,m)*binomial(m+3*k,n)	945	explicitformula
2262	U	 (x+1)^2*y+1	946	generatingfunction
2263	T	binomial(k,m)*binomial(2*m,n)	946	explicitformula
2264	U	(x+1)^2*((x+1)^2*y+1)	947	generatingfunction
2265	T	binomial(k,m)*binomial(2*m+2*k,n)	947	explicitformula
2266	U	 (x+1)^3*((x+1)^2*y+1)	948	generatingfunction
2267	T	 binomial(k,m)*binomial(2*m+3*k,n)	948	explicitformula
2268	U	 (x+1)^3*y+1	949	generatingfunction
2269	T	binomial(k,m)*binomial(3*m,n)	949	explicitformula
2270	U	(x+1)*((x+1)^3*y+1)	950	generatingfunction
2271	T	binomial(k,m)*binomial(3*m+k,n)	950	explicitformula
2272	U	(x+1)^2*((x+1)^3*y+1)	951	generatingfunction
2273	T	binomial(k,m)*binomial(3*m+2*k,n)	951	explicitformula
2274	U	(x+1)^3*((x+1)^3*y+1)	952	generatingfunction
2275	T	 binomial(k,m)*binomial(3*m+3*k,n)	952	explicitformula
2276	U	(y+1)^3*(x*(y+1)+1)	953	generatingfunction
2277	T	binomial(k,n)*binomial(n+3*k,m)	953	explicitformula
2278	U	 (y+1)^3*(x*(y+1)^2+1)	954	generatingfunction
2279	T	binomial(k,n)*binomial(2*n+3*k,m)	954	explicitformula
2280	U	(y+1)*(x*(y+1)^3+1)	955	generatingfunction
2281	T	binomial(k,n)*binomial(3*n+k,m)	955	explicitformula
2282	U	(y+1)^2*(x*(y+1)^3+1)	956	generatingfunction
2283	T	binomial(k,n)*binomial(3*n+2*k,m)	956	explicitformula
2284	U	(y+1)^3*(x*(y+1)^3+1)	957	generatingfunction
2285	T	 binomial(k,n)*binomial(3*n+3*k,m)	957	explicitformula
2286	U	(x/(1-y)+1)/(1-y)^2	958	generatingfunction
2287	T	 binomial(k,n)*binomial(n+m+2*k-1,m)	958	explicitformula
2288	U	 (x/(1-y)+1)/(1-y)^3	959	generatingfunction
2289	T	 binomial(k,n)*binomial(n+m+3*k-1,m)	959	explicitformula
2290	U	 (x/(1-y)^3+1)/(1-y)	960	generatingfunction
2291	T	binomial(k,n)*binomial(3*n+m+k-1,m)	960	explicitformula
2292	U	(x/(1-y)^3+1)/(1-y)^2	961	generatingfunction
2293	T	binomial(k,n)*binomial(3*n+m+2*k-1,m)	961	explicitformula
2294	U	(x/(1-y)^2+1)/(1-y)^3	962	generatingfunction
2295	T	binomial(k,n)*binomial(2*n+m+3*k-1,m)	962	explicitformula
2296	U	1/((1-x)^3*(1-y/(1-x)))	963	generatingfunction
2297	T	binomial(m+k-1,m)*binomial(n+m+3*k-1,n)	963	explicitformula
2298	U	1/((1-x)^3*(1-y/(1-x)^2))	964	generatingfunction
2299	T	 binomial(m+k-1,m)*binomial(n+2*m+3*k-1,n)	964	explicitformula
2300	U	 1/((1-x)^2*(1-y/(1-x)^3))	965	generatingfunction
2301	T	binomial(m+k-1,m)*binomial(n+3*m+2*k-1,n)	965	explicitformula
2302	U	 1/((1-x)^3*(1-y/(1-x)^3))	966	generatingfunction
2303	T	binomial(m+k-1,m)*binomial(n+3*m+3*k-1,n)	966	explicitformula
2304	U	(x/(1-y)+1)^2/(1-y)^2	967	generatingfunction
2305	T	binomial(2*k,n)*binomial(n+m+2*k-1,m)	967	explicitformula
2306	U	 (x/(1-y)+1)^2/(1-y)^3	968	generatingfunction
2307	T	binomial(2*k,n)*binomial(n+m+3*k-1,m)	968	explicitformula
2308	U	(x/(1-y)^2+1)^2/(1-y)	969	generatingfunction
2309	T	binomial(2*k,n)*binomial(2*n+m+k-1,m)	969	explicitformula
2310	U	(x/(1-y)^2+1)^2/(1-y)^3	970	generatingfunction
2311	T	binomial(2*k,n)*binomial(2*n+m+3*k-1,m)	970	explicitformula
2312	U	 (x/(1-y)^3+1)^2/(1-y)	971	generatingfunction
2313	T	binomial(2*k,n)*binomial(3*n+m+k-1,m)	971	explicitformula
2314	U	 (x/(1-y)^3+1)^2/(1-y)^2	972	generatingfunction
2315	T	binomial(2*k,n)*binomial(3*n+m+2*k-1,m)	972	explicitformula
2316	U	(x/(1-y)+1)^3/(1-y)^3	973	generatingfunction
2317	T	 binomial(3*k,n)*binomial(n+m+3*k-1,m)	973	explicitformula
2318	U	 (x/(1-y)^2+1)^3/(1-y)	974	generatingfunction
2319	T	binomial(3*k,n)*binomial(2*n+m+k-1,m)	974	explicitformula
2320	U	(x/(1-y)^2+1)^3/(1-y)^3	975	generatingfunction
2321	T	binomial(3*k,n)*binomial(2*n+m+3*k-1,m)	975	explicitformula
2322	U	 (x/(1-y)^3+1)^3/(1-y)	976	generatingfunction
2323	T	binomial(3*k,n)*binomial(3*n+m+k-1,m)	976	explicitformula
2324	U	(x/(1-y)^3+1)^3/(1-y)^2	977	generatingfunction
2325	T	binomial(3*k,n)*binomial(3*n+m+2*k-1,m)	977	explicitformula
2326	U	 (y+1)^2/(1-x*(y+1)^3)	978	generatingfunction
2327	T	binomial(n+k-1,n)*binomial(3*n+2*k,m)	978	explicitformula
2328	U	 (y+1)^3/(1-x*(y+1)^3)	979	generatingfunction
2329	T	binomial(n+k-1,n)*binomial(3*n+3*k,m)	979	explicitformula
2330	U	(y+1)^2/(1-x*(y+1))^2	980	generatingfunction
2331	T	binomial(n+2*k-1,n)*binomial(n+2*k,m)	980	explicitformula
2332	U	 (y+1)^3/(1-x*(y+1))^2	981	generatingfunction
2333	T	 binomial(n+2*k-1,n)*binomial(n+3*k,m)	981	explicitformula
2334	U	(y+1)^3/(1-x*(y+1)^2)^2	982	generatingfunction
2335	T	binomial(n+2*k-1,n)*binomial(2*n+3*k,m)	982	explicitformula
2336	U	 (y+1)/(1-x*(y+1)^3)^2	983	generatingfunction
2337	T	binomial(n+2*k-1,n)*binomial(3*n+k,m)	983	explicitformula
2338	U	(y+1)^2/(1-x*(y+1)^3)^2	984	generatingfunction
2339	T	binomial(n+2*k-1,n)*binomial(3*n+2*k,m)	984	explicitformula
2340	U	 (y+1)/(1-x*(y+1)^2)^2	985	generatingfunction
2341	T	binomial(n+2*k-1,n)*binomial(2*n+k,m)	985	explicitformula
2342	U	(y+1)^2/(1-x*(y+1))^3	986	generatingfunction
2343	T	 binomial(n+2*k,m)*binomial(n+3*k-1,n)	986	explicitformula
2344	U	 (y+1)^3/(1-x*(y+1))^3	987	generatingfunction
2345	T	binomial(n+3*k-1,n)*binomial(n+3*k,m)	987	explicitformula
2346	U	(y+1)/(1-x*(y+1)^2)^3	988	generatingfunction
2347	T	binomial(n+3*k-1,n)*binomial(2*n+k,m)	988	explicitformula
2348	U	 (y+1)^3/(1-x*(y+1)^2)^3	989	generatingfunction
2349	T	 binomial(n+3*k-1,n)*binomial(2*n+3*k,m)	989	explicitformula
2350	U	(y+1)/(1-x*(y+1)^3)^3	990	generatingfunction
2351	T	 binomial(n+3*k-1,n)*binomial(3*n+k,m)	990	explicitformula
2352	U	 (y+1)^2/(1-x*(y+1)^3)^3	991	generatingfunction
2353	T	binomial(n+3*k-1,n)*binomial(3*n+2*k,m)	991	explicitformula
2354	U	 1/((1-x/(1-y)^3)*(1-y)^2)	992	generatingfunction
2355	T	binomial(n+k-1,n)*binomial(3*n+m+2*k-1,m)	992	explicitformula
2356	U	 1/((1-x/(1-y)^2)^2*(1-y))	993	generatingfunction
2357	T	binomial(n+2*k-1,n)*binomial(2*n+m+k-1,m)	993	explicitformula
2358	U	 1/((1-x/(1-y)^3)^2*(1-y))	994	generatingfunction
2359	T	binomial(n+2*k-1,n)*binomial(3*n+m+k-1,m)	994	explicitformula
2360	U	 1/((1-x/(1-y)^2)^2*(1-y)^3)	995	generatingfunction
2361	T	binomial(n+2*k-1,n)*binomial(2*n+m+3*k-1,m)	995	explicitformula
2362	U	 1/((1-x/(1-y)^3)^2*(1-y)^2)	996	generatingfunction
2363	T	binomial(n+2*k-1,n)*binomial(3*n+m+2*k-1,m)	996	explicitformula
2364	U	(1-sqrt(1-(4*x)/(1-y)^2))/(2*x*(1-y))	997	generatingfunction
2365	T	 (k*binomial(2*n+k-1,n)*binomial(2*n+m+3*k-1,m))/( n+k)	997	explicitformula
2366	U	 (1-sqrt(1-(4*x)/(1-y)^3))/(2*x*(1-y))	998	generatingfunction
2367	T	(k*binomial(2*n+k-1,n)*binomial(3*n+m+2*k-1,m))/( n+k)	998	explicitformula
2368	U	((-(2*x)/(1-y))-sqrt(1-(4*x)/(1-y))+1)/(2*x^2)	999	generatingfunction
2369	T	(k*binomial(n+m+2*k-1,m)*binomial(2*n+2*k,n))/(n+k)	999	explicitformula
2370	U	((-(2*x)/(1-y))-sqrt(1-(4*x)/(1-y))+1)/(2*x^2*(1- y))	1000	generatingfunction
2371	T	 (k*binomial(n+m+3*k-1,m)*binomial(2*n+2*k,n))/(n+ k)	1000	explicitformula
2372	U	(((-(2*x)/(1-y)^2)-sqrt(1-(4*x)/(1-y)^2)+1)*(1-y) ^2)/(2*x^2)	1001	generatingfunction
2373	T	 (k*binomial(2*n+2*k,n)*binomial(2*n+m+2*k-1,m))/( n+k)	1001	explicitformula
2374	U	 (((-(2*x)/(1-y)^2)-sqrt(1-(4*x)/(1-y)^2)+1)*(1-y) )/(2*x^2)	1002	generatingfunction
2375	T	(k*binomial(2*n+2*k,n)*binomial(2*n+m+3*k-1,m))/( n+k)	1002	explicitformula
2376	U	 (((-(2*x)/(1-y)^3)-sqrt(1-(4*x)/(1-y)^3)+1)*(1-y) ^5)/(2*x^2)	1003	generatingfunction
2377	T	(k*binomial(2*n+2*k,n)*binomial(3*n+m+k-1,m))/(n+ k)	1003	explicitformula
2378	U	(((-(2*x)/(1-y)^3)-sqrt(1-(4*x)/(1-y)^3)+1)*(1-y) ^4)/(2*x^2)	1004	generatingfunction
2379	T	 (k*binomial(2*n+2*k,n)*binomial(3*n+m+2*k-1,m))/( n+k)	1004	explicitformula
2380	U	 (((-(2*x)/(1-y)^3)-sqrt(1-(4*x)/(1-y)^3)+1)*(1-y) ^3)/(2*x^2)	1005	generatingfunction
2381	T	 (k*binomial(2*n+2*k,n)*binomial(3*n+m+3*k-1,m))/( n+k)	1005	explicitformula
2382	U	 ((-sqrt(1-4*x*(y+1)^2))-2*x*(y+1)^2+1)/(2*x^2*(y+ 1))	1006	generatingfunction
2383	T	 (k*binomial(2*n+2*k,n)*binomial(2*n+3*k,m))/(n+k)	1006	explicitformula
2384	U	 ((-sqrt(1-4*x*(y+1)^3))-2*x*(y+1)^3+1)/(2*x^2*(y+ 1)^5)	1007	generatingfunction
2385	T	 (k*binomial(2*n+2*k,n)*binomial(3*n+k,m))/(n+k)	1007	explicitformula
2386	U	((-sqrt(1-4*x*(y+1)^3))-2*x*(y+1)^3+1)/(2*x^2*(y+ 1)^4)	1008	generatingfunction
2387	T	(k*binomial(2*n+2*k,n)*binomial(3*n+2*k,m))/(n+k)	1008	explicitformula
2388	U	15661	1009	generatingfunction
2390	U	 ((1-sqrt(1-4*x))*((-2*y)-sqrt(1-4*y)+1)**2)/(8*x*y**4)	1009	generatingfunction
2391	T	 (2*k**2*binomial(2*m+4*k,m)*binomial(2*n+k-1,n))/( (m+2*k)*(n+k))	1009	explicitformula
2392	U	 ((1-sqrt(1-4*x))*((-2*y)-sqrt(1-4*y)+1)**3)/(16*x*y**6)	1010	generatingfunction
2393	T	 (3*k**2*binomial(2*m+6*k,m)*binomial(2*n+k-1,n))/( (m+3*k)*(n+k))	1010	explicitformula
2394	U	 ((1-sqrt(1-4*x))**2*(y+1)**3)/(4*x**2)	1011	generatingfunction
2395	T	(2*k*binomial(3*k,m)*binomial(2*n+2*k-1,n))/(n+2* k)	1011	explicitformula
2396	U	((1-sqrt(1-4*x))**2*(1-sqrt(1-4*y))**3)/(32*x**2*y**3)	1012	generatingfunction
2397	T	 (6*k**2*binomial(2*m+3*k-1,m)*binomial(2*n+2*k-1,n ))/((m+3*k)*(n+2*k))	1012	explicitformula
2398	U	 ((1-sqrt(1-4*x))**2*((-2*y)-sqrt(1-4*y)+1)**2)/(16* x**2*y**4)	1013	generatingfunction
2399	T	(4*k**2*binomial(2*m+4*k,m)*binomial(2*n+2*k-1,n)) /((m+2*k)*(n+2*k))	1013	explicitformula
2400	U	 ((1-sqrt(1-4*x))**2*((-2*y)-sqrt(1-4*y)+1)**3)/(32* x**2*y**6)	1014	generatingfunction
2401	T	(6*k**2*binomial(2*m+6*k,m)*binomial(2*n+2*k-1,n)) /((m+3*k)*(n+2*k))	1014	explicitformula
2402	U	((1-sqrt(1-4*x))**3*(y+1))/(8*x**3)	1015	generatingfunction
2403	T	 (3*k*binomial(k,m)*binomial(2*n+3*k-1,n))/(n+3*k)	1015	explicitformula
2404	U	((1-sqrt(1-4*x))**3*(y+1)**2)/(8*x**3)	1016	generatingfunction
2405	T	(3*k*binomial(2*k,m)*binomial(2*n+3*k-1,n))/(n+3* k)	1016	explicitformula
2406	U	 ((1-sqrt(1-4*x))**3*(y+1)**3)/(8*x**3)	1017	generatingfunction
2407	T	(3*k*binomial(3*k,m)*binomial(2*n+3*k-1,n))/(n+3* k)	1017	explicitformula
2408	U	(1-sqrt(1-4*x))**3/(8*x**3*(1-y))	1018	generatingfunction
2409	T	 (3*k*binomial(m+k-1,m)*binomial(2*n+3*k-1,n))/(n+ 3*k)	1018	explicitformula
2410	U	 (1-sqrt(1-4*x))**3/(8*x**3*(1-y)**2)	1019	generatingfunction
2411	T	 (3*k*binomial(m+2*k-1,m)*binomial(2*n+3*k-1,n))/( n+3*k)	1019	explicitformula
2412	U	(1-sqrt(1-4*x))**3/(8*x**3*(1-y)**3)	1020	generatingfunction
2413	T	 (3*k*binomial(m+3*k-1,m)*binomial(2*n+3*k-1,n))/( n+3*k)	1020	explicitformula
2414	U	 ((1-sqrt(1-4*x))**3*(1-sqrt(1-4*y)))/(16*x**3*y)	1021	generatingfunction
2485	T	binomial(2*k,n)*binomial(3*n+m-1,m)	1056	explicitformula
2415	T	(3*k**2*binomial(2*m+k-1,m)*binomial(2*n+3*k-1,n)) /((m+k)*(n+3*k))	1021	explicitformula
2416	U	 ((1-sqrt(1-4*x))**3*(1-sqrt(1-4*y))**2)/(32*x**3*y**2)	1022	generatingfunction
2417	T	(6*k**2*binomial(2*m+2*k-1,m)*binomial(2*n+3*k-1,n ))/((m+2*k)*(n+3*k))	1022	explicitformula
2418	U	((1-sqrt(1-4*x))**3*(1-sqrt(1-4*y))**3)/(64*x**3*y**3)	1023	generatingfunction
2419	T	(9*k**2*binomial(2*m+3*k-1,m)*binomial(2*n+3*k-1,n ))/((m+3*k)*(n+3*k))	1023	explicitformula
2420	U	 ((1-sqrt(1-4*x))**3*((-2*y)-sqrt(1-4*y)+1)**3)/(64* x**3*y**6)	1024	generatingfunction
2421	T	(9*k**2*binomial(2*m+6*k,m)*binomial(2*n+3*k-1,n)) /((m+3*k)*(n+3*k))	1024	explicitformula
2422	U	(((-2*x)-sqrt(1-4*x)+1)**2*(y+1))/(4*x**4)	1025	generatingfunction
2423	T	(2*k*binomial(k,m)*binomial(2*n+4*k,n))/(n+2*k)	1025	explicitformula
2424	U	 (((-2*x)-sqrt(1-4*x)+1)**2*(y+1)**2)/(4*x**4)	1026	generatingfunction
2425	T	 (2*k*binomial(2*k,m)*binomial(2*n+4*k,n))/(n+2*k)	1026	explicitformula
2426	U	(((-2*x)-sqrt(1-4*x)+1)**2*(y+1)**3)/(4*x**4)	1027	generatingfunction
2427	T	 (2*k*binomial(3*k,m)*binomial(2*n+4*k,n))/(n+2*k)	1027	explicitformula
2428	U	 ((-2*x)-sqrt(1-4*x)+1)**2/(4*x**4*(1-y))	1028	generatingfunction
2429	T	(2*k*binomial(m+k-1,m)*binomial(2*n+4*k,n))/(n+2*k)	1028	explicitformula
2430	U	((-2*x)-sqrt(1-4*x)+1)**2/(4*x**4*(1-y)**2)	1029	generatingfunction
2431	T	(2*k*binomial(m+2*k-1,m)*binomial(2*n+4*k,n))/(n+ 2*k)	1029	explicitformula
2432	U	 ((-2*x)-sqrt(1-4*x)+1)**2/(4*x**4*(1-y)**3)	1030	generatingfunction
2433	T	 (2*k*binomial(m+3*k-1,m)*binomial(2*n+4*k,n))/(n+2*k)	1030	explicitformula
2434	U	(((-2*x)-sqrt(1-4*x)+1)**2*(1-sqrt(1-4*y)))/(8*x**4 *y)	1031	generatingfunction
2435	T	(2*k**2*binomial(2*m+k-1,m)*binomial(2*n+4*k,n))/( (m+k)*(n+2*k))	1031	explicitformula
2436	U	 (((-2*x)-sqrt(1-4*x)+1)**2*(1-sqrt(1-4*y))**2)/(16* x**4*y**2)	1032	generatingfunction
2437	T	 (4*k**2*binomial(2*m+2*k-1,m)*binomial(2*n+4*k,n)) /((m+2*k)*(n+2*k))	1032	explicitformula
2438	U	(((-2*x)-sqrt(1-4*x)+1)**2*(1-sqrt(1-4*y))**3)/(32* x**4*y**3)	1033	generatingfunction
2439	T	 (6*k**2*binomial(2*m+3*k-1,m)*binomial(2*n+4*k,n)) /((m+3*k)*(n+2*k))	1033	explicitformula
2440	U	(((-2*x)-sqrt(1-4*x)+1)**2*((-2*y)-sqrt(1-4*y)+1)**2)/(16*x**4*y**4)	1034	generatingfunction
2441	T	(4*k**2*binomial(2*m+4*k,m)*binomial(2*n+4*k,n))/( (m+2*k)*(n+2*k))	1034	explicitformula
2442	U	(((-2*x)-sqrt(1-4*x)+1)**2*((-2*y)-sqrt(1-4*y)+1)**3)/(32*x**4*y**6)	1035	generatingfunction
2443	T	 (6*k**2*binomial(2*m+6*k,m)*binomial(2*n+4*k,n))/( (m+3*k)*(n+2*k))	1035	explicitformula
2444	U	 (((-2*x)-sqrt(1-4*x)+1)**3*(y+1))/(8*x**6)	1036	generatingfunction
2445	T	(3*k*binomial(k,m)*binomial(2*n+6*k,n))/(n+3*k)	1036	explicitformula
2446	U	(((-2*x)-sqrt(1-4*x)+1)**3*(y+1)**2)/(8*x**6)	1037	generatingfunction
2447	T	(3*k*binomial(2*k,m)*binomial(2*n+6*k,n))/(n+3*k)	1037	explicitformula
2448	U	(((-2*x)-sqrt(1-4*x)+1)**3*(y+1)**3)/(8*x**6)	1038	generatingfunction
2449	T	(3*k*binomial(3*k,m)*binomial(2*n+6*k,n))/(n+3*k)	1038	explicitformula
2450	U	 ((-2*x)-sqrt(1-4*x)+1)**3/(8*x**6*(1-y))	1039	generatingfunction
2451	T	(3*k*binomial(m+k-1,m)*binomial(2*n+6*k,n))/(n+3*k)	1039	explicitformula
2452	U	 ((-2*x)-sqrt(1-4*x)+1)**3/(8*x**6*(1-y)**2)	1040	generatingfunction
2453	T	(3*k*binomial(m+2*k-1,m)*binomial(2*n+6*k,n))/(n+3*k)	1040	explicitformula
2454	U	 ((-2*x)-sqrt(1-4*x)+1)**3/(8*x**6*(1-y)**3)	1041	generatingfunction
2455	T	 (3*k*binomial(m+3*k-1,m)*binomial(2*n+6*k,n))/(n+ 3*k)	1041	explicitformula
2456	U	(((-2*x)-sqrt(1-4*x)+1)**3*(1-sqrt(1-4*y)))/(16*x**6*y)	1042	generatingfunction
2457	T	(3*k**2*binomial(2*m+k-1,m)*binomial(2*n+6*k,n))/( (m+k)*(n+3*k))	1042	explicitformula
2458	U	 (((-2*x)-sqrt(1-4*x)+1)**3*(1-sqrt(1-4*y))**2)/(32* x**6*y**2)	1043	generatingfunction
2459	T	(6*k**2*binomial(2*m+2*k-1,m)*binomial(2*n+6*k,n)) /((m+2*k)*(n+3*k))	1043	explicitformula
2460	U	(((-2*x)-sqrt(1-4*x)+1)**3*(1-sqrt(1-4*y))**3)/(64*x**6*y**3)	1044	generatingfunction
2461	T	(9*k**2*binomial(2*m+3*k-1,m)*binomial(2*n+6*k,n)) /((m+3*k)*(n+3*k))	1044	explicitformula
2462	U	(((-2*x)-sqrt(1-4*x)+1)**3*((-2*y)-sqrt(1-4*y)+1)**2)/(32*x**6*y**4)	1045	generatingfunction
2463	T	(6*k**2*binomial(2*m+4*k,m)*binomial(2*n+6*k,n))/( (m+2*k)*(n+3*k))	1045	explicitformula
2464	U	(((-2*x)-sqrt(1-4*x)+1)**3*((-2*y)-sqrt(1-4*y)+1)**3)/(64*x**6*y**6)	1046	generatingfunction
2465	T	 (9*k**2*binomial(2*m+6*k,m)*binomial(2*n+6*k,n))/((m+3*k)*(n+3*k))	1046	explicitformula
2466	U	 x/(1-y)**3+1	1047	generatingfunction
2467	T	binomial(k,n)*binomial(3*n+m-1,m)	1047	explicitformula
2468	U	(x*(1-sqrt(1-4*y))**3)/(8*y**3)+1	1048	generatingfunction
2470	U	(x*((-2*y)-sqrt(1-4*y)+1)**2)/(4*y**4)+1	1049	generatingfunction
2472	U	(x*((-2*y)-sqrt(1-4*y)+1)**3)/(8*y**6)+1	1050	generatingfunction
2474	U	 (x*(y+1)+1)**2	1051	generatingfunction
2475	T	binomial(2*k,n)*binomial(n,m)	1051	explicitformula
2476	U	(x*(y+1)^2+1)**2	1052	generatingfunction
2477	T	binomial(2*k,n)*binomial(2*n,m)	1052	explicitformula
2478	U	(x*(y+1)**3+1)**2	1053	generatingfunction
2479	T	 binomial(2*k,n)*binomial(3*n,m)	1053	explicitformula
2480	U	 (x/(1-y)+1)**2	1054	generatingfunction
2481	T	 binomial(2*k,n)*binomial(n+m-1,m)	1054	explicitformula
2482	U	 (x/(1-y)**2+1)**2	1055	generatingfunction
2483	T	binomial(2*k,n)*binomial(2*n+m-1,m)	1055	explicitformula
2484	U	 (x/(1-y)**3+1)**2	1056	generatingfunction
2469	T	1	1048	explicitformula
2471	T	1	1049	explicitformula
2473	T	1	1050	explicitformula
2486	U	 ((x*(1-sqrt(1-4*y)))/(2*y)+1)**2	1057	generatingfunction
2488	U	 ((x*(1-sqrt(1-4*y))**2)/(4*y**2)+1)**2	1058	generatingfunction
2490	U	 ((x*(1-sqrt(1-4*y))**3)/(8*y**3)+1)**2	1059	generatingfunction
2492	U	((x*((-2*y)-sqrt(1-4*y)+1)**2)/(4*y**4)+1)**2	1060	generatingfunction
2494	U	((x*((-2*y)-sqrt(1-4*y)+1)**3)/(8*y**6)+1)**2	1061	generatingfunction
2496	U	(1+x*(1+y))**3	1062	generatingfunction
2497	T	binomial(3*k,n)*binomial(n,m)	1062	explicitformula
2498	U	(x*(y+1)**2+1)**3	1063	generatingfunction
2499	T	binomial(3*k,n)*binomial(2*n,m)	1063	explicitformula
2500	U	 (x*(y+1)**3+1)**3	1064	generatingfunction
2501	T	binomial(3*k,n)*binomial(3*n,m)	1064	explicitformula
2502	U	(x/(1-y)+1)**3	1065	generatingfunction
2503	T	binomial(3*k,n)*binomial(n+m-1,m)	1065	explicitformula
2504	U	(x/(1-y)**2+1)**3	1066	generatingfunction
2505	T	binomial(3*k,n)*binomial(2*n+m-1,m)	1066	explicitformula
2506	U	 (x/(1-y)**3+1)**3	1067	generatingfunction
2507	T	binomial(3*k,n)*binomial(3*n+m-1,m)	1067	explicitformula
2508	U	 ((x*(1-sqrt(1-4*y)))/(2*y)+1)**3	1068	generatingfunction
2510	U	 ((x*(1-sqrt(1-4*y))**2)/(4*y**2)+1)**3	1069	generatingfunction
2512	U	(y+1)*sqrt(4*x*(y+1)**3+1)	1070	generatingfunction
2513	T	binomial(k/2,n)*4**n*binomial(k+3*n,m)	1070	explicitformula
2514	T	 (-1)**(n-(k+1)/2)*binomial(2*n,n)*binomial(n,(k+1)/2)/ binomial(2*n,2*(k+1)/2)*binomial(k+3*n,m)	1070	explicitformula
2515	T	 binomial(2*(k+1)/2,2*n)*binomial (2*n,n)/binomial((k+1)/2,n)*binomial(k+3*n,m)	1070	explicitformula
2516	U	sqrt(4*x+1)*(y+1)^2	1071	generatingfunction
2520	U	(y+1)**2*sqrt(4*x*(y+1)**3+1)	1072	generatingfunction
2521	T	binomial (k/2,n)*4**n*binomial(2*k+3*n,m)	1072	explicitformula
2523	T	binomial(2*(k+1)/2,2*n)*binomial(2*n,n)/binomial((k+1)/2,n)*binomial(2*k+3*n,m)	1072	explicitformula
2524	U	(y+1)**7*sqrt(4*x*(y+1)**3+1)	1073	generatingfunction
2525	T	binomial(k/2,n)*4**n*binomial(3*k+3*n,m)	1073	explicitformula
2526	T	(-1)**(n-(k+1)/2)*binomial(2*n,n)*binomial(n,(k+1)/2)/binomial(2*n,2*(k+1)/2)*binomial(3*k+3*n,m)	1073	explicitformula
2527	T	binomial(2*(k+1)/2,2*n)*binomial(2*n,n)/binomial((k+1)/2,n)*binomial(3*k+3*n,m)	1073	explicitformula
2528	U	(y+1)*sqrt(4*(x**2)*(y+1)**4+1)+2*x*(y+1)**3	1074	generatingfunction
2529	T	k*binomial(k/2,n)*(4**n)*binomial(2*n+k,m)/(n+k)	1074	explicitformula
2530	U	sqrt(4*x*(y+1)**2+1)	1075	generatingfunction
2531	T	binomial(k/2,n)*4**n*binomial(2*n,m)	1075	explicitformula
2532	T	(-1)**(n-(k+1)/2)*binomial(2*n,n)*binomial(n,(k+1)/2)/binomial(2*n,2*(k+1)/2)*binomial(2*n,m)	1075	explicitformula
2533	T	binomial(2*(k+1)/2,2*n)* binomial(2*n,n)/binomial((k+1)/2,n)*binomial(2*n,m)	1075	explicitformula
2534	U	sqrt(4*x*(y+1)**3+1)	1076	generatingfunction
2535	T	binomial(k/2,n)*4**n*binomial(3*n,m)	1076	explicitformula
2536	T	(-1)**(n-(k+1)/2)*binomial(2*n,n)*binomial(n,(k+1)/2)/binomial(2*n,2*(k+1)/2)*binomial(3*n,m)	1076	explicitformula
2537	T	binomial(2*(k+1)/2,2*n)* binomial(2*n,n)/binomial((k+1)/2,n)*binomial(3*n,m)	1076	explicitformula
2538	U	(y+1)**3*sqrt(4*x**2*(y+1)**2+1)+2*x*(y+1)**4	1077	generatingfunction
2539	T	k*binomial(n+(n+k)/2,n)*binomial(2*n+2*(n+k)/2,n+(n+k)/2)*binomial(n+3*k,m)/(binomial(2*(n+k)/2,(n+k)/2)*(n+k))	1077	explicitformula
2540	T	k*binomial(n+(n+k+1)/2,n)*binomial(2*n+2*(n+k+1)/2,n+(n+k+1)/2)*binomial(n+3*k,m)/(binomial(2*(n+k+1)/2,(n+k+1)/2)*(n+k))	1077	explicitformula
2541	U	 (y+1)^2*sqrt(4*x^2*(y+1)^4+1)+2*x*(y+1)^4	1078	generatingfunction
2542	T	k*binomial(n+(n+k)/2,n)*binomial(2*n+2*(n+k)/2,n+(n+k)/2)*binomial(2*n+2*k,m)/(binomial(2*(n+k)/2,(n+k)/2)*(n+k))	1078	explicitformula
2543	T	k*binomial(n+(n+k+1)/2,n)*binomial(2*n+2*(n+k+1)/2,n+(n+k+1)/2)*binomial(2*n+2*k,m)/(binomial(2*(n+k+1)/2,(n+k+1)/2)*(n+k))	1078	explicitformula
2544	U	 (y+1)**2*sqrt(4*x**2*(y+1)**2+1)+2*x*(y+1)**3	1079	generatingfunction
2545	T	k*binomial(n+(n+k)/2,n)*binomial(2*n+2*(n+k)/2,n+(n+k)/2)*binomial(n+2*k,m)/(binomial(2*(n+k)/2,(n+k)/2)*(n+k))	1079	explicitformula
2546	T	k*binomial(n+(n+k+1)/2,n)*binomial(2*n+2*(n+k+1)/2,n+(n+k+1)/2)*binomial(n+2*k,m)/(binomial(2*(n+k+1)/2,(n+k+1)/2)*(n+k))	1079	explicitformula
2547	U	 -(2*x)/(sqrt(x**2*y**2+((-2*x**2)-2*x)*y+x**2-2*x+1)+ x*y-x-1)	1080	generatingfunction
2548	T	1	1080	explicitformula
2550	U	 sqrt((4*x**2+4*x)*y**2+1)+(2*x+1)*y	1081	generatingfunction
2551	T	 (k*4**n*binomial(n+k,2*n-m+k)*binomial((2*n-m+k)/2 ,n))/(n+k)	1081	explicitformula
2692	T	binomial(n+k-1,n)*binomial(n+m-2*k-1,m)	1146	explicitformula
2552	U	1/sqrt(x^2*y^2-4*x^2*y-2*x*y+1)	1082	generatingfunction
2522	T	(-1)**(n-(k+1)/2)*binomial(2*n,n)*binomial(n,(k+1)/2 )/binomial(2*n,2*(k+1)/2)*binomial(2*k+3*n,m)	1072	explicitformula
2517	T	Tsqrt(n, k)*binomial(2*k,m)	1071	explicitformula
2487	T	1	1057	explicitformula
2489	T	1	1058	explicitformula
2491	T	1	1059	explicitformula
2493	T	1	1060	explicitformula
2495	T	1	1061	explicitformula
2509	T	1	1068	explicitformula
2511	T	1	1069	explicitformula
2555	U	1/((y-x+1)**2-4*y)	1083	generatingfunction
2556	T	((binomial(m+k,k-1))*(binomial(n+k-1,k-1)) * (binomial(n+m+2*k-1,k-1))*(binomial(2*(n+m)+2*k,2 *m+1)))/(2*(binomial(2*k-2,k-1))*(binomial(2*m+2* k,2*k-2)))	1083	explicitformula
2557	U	 1/((x+1)*y-x**2-2*x-1)	1084	generatingfunction
2559	U	(1-(4*sin(asin((3^(3/2)*sqrt(-x))/2)/3)^2)/3)^2*( y+1)	1085	generatingfunction
2560	T	binomial(k,m)	1085	explicitformula
2561	T	(2*k*binomial(k,m)*(-1)^(n-1)*binomial(3*n-2*k-1, n-1))/n	1085	explicitformula
2562	U	(sqrt(2)*sqrt(8*x*y**2-2*y-sqrt(1-4*y)+1)-sqrt(1-4*y)+1)/(4*y)	1086	generatingfunction
2565	U	(sqrt(((-4*x**2)+8*x-2)*y+sqrt(1-4*x)*(2-4*x)*y+x**4)-x**2)/((2*x-1)*y+sqrt(1-4*x)*y)	1087	generatingfunction
2566	T	 (k*binomial(2*m+k,m)*binomial(2*n+2*(2*m+k),n))/(n+2*m+k)	1087	explicitformula
2567	U	(y+x)/(1-x)**3	1088	generatingfunction
2569	U	(1-(4*sin(asin((3^(3/2)*sqrt(-x))/2)/3)^2)/3)^2*( y+1)^2	1089	generatingfunction
2570	T	binomial(2*k,m)	1089	explicitformula
2571	T	(2*k*((binomial( 3*n-2*k-1,n-1))*(-1)^(n-1)))/n*binomial(2*k,m)	1089	explicitformula
2572	U	(y**2+x**2)/(1-x)	1090	generatingfunction
2580	U	 (((-2*x)-sqrt(1-4*x)+1)*(y+1)**2)/(2*x**2)	1091	generatingfunction
2581	T	 (k*binomial(2*k,m)*binomial(2*n+2*k,n))/(n+k)	1091	explicitformula
2582	U	(((-2*x)-sqrt(1-4*x)+1)*sin(asin((3^(3/2)*sqrt(y) )/2)/3))/(sqrt(3)*x^2*sqrt(y))	1092	generatingfunction
2583	T	(k^2*binomial(3*m+k-1,m)*binomial(2*n+2*k,n))/((2 *m+k)*(n+k))	1092	explicitformula
2584	U	 (sqrt(3)*((2*sin(asin((3^(3/2)*sqrt(y))/2)/3))/(sqrt(3)*sqrt(y))+x)^2*sqrt(y))/(2*sin(asin((3^(3/2 )*sqrt(y))/2)/3))	1093	generatingfunction
2585	T	binomial(2*k,n)	1093	explicitformula
2586	T	((binomial(n-2*m -k-1,m-1))*(-1)^(m-1)*(k-n)*(binomial(2*k,n)))/(m)	1093	explicitformula
2587	U	(2*(x+1)^2*sin(asin((3^(3/2)*sqrt(y))/2)/3))/(sqr t(3)*sqrt(y))	1094	generatingfunction
2588	T	(k*binomial(2*k,n)*binomial(3*m+k-1,m))/(2*m+k)	1094	explicitformula
2589	U	 (2*(y+1)*sin(arcsin((3^(3/2)*sqrt(x*(y+1)))/2)/3))/ (sqrt(3)*sqrt(x))	1095	generatingfunction
2590	T	(k*binomial(2*n+2*k,m)*binomial(3*n+k-1,n))/(2*n+ k)	1095	explicitformula
2591	U	(2*(y+1)^2*sin(arcsin((3^(3/2)*sqrt(x*(y+1)))/2)/3) )/(sqrt(3)*sqrt(x))	1096	generatingfunction
2592	T	 (k*binomial(2*n+3*k,m)*binomial(3*n+k-1,n))/(2*n+ k)	1096	explicitformula
2593	U	 (2*sin(asin((3**(3/2)*sqrt(x))/2)/3)*(y+1)**2)/(sqrt(3)*sqrt(x))	1097	generatingfunction
2594	T	(k*binomial(2*k,m)*binomial(3*n+k-1,n))/(2*n+k)	1097	explicitformula
2596	T	(k*binomial(3*n,m)*binomial(3*n+k-1,n))/(2*n+k)	1098	explicitformula
2597	U	(sin(asin((3**(3/2)*sqrt(x))/2)/3)*(1-sqrt(1-4*y)) )/(sqrt(3)*sqrt(x)*y)	1099	generatingfunction
2598	T	 (k**2*binomial(2*m+k-1,m)*binomial(3*n+k-1,n))/((m +k)*(2*n+k))	1099	explicitformula
2599	U	 (sin(asin((3**(3/2)*sqrt(x))/2)/3)*((-2*y)-sqrt(1- 4*y)+1))/(sqrt(3)*sqrt(x)*y**2)	1100	generatingfunction
2600	T	(k**2*binomial(2*m+2*k,m)*binomial(3*n+k-1,n))/((m +k)*(2*n+k))	1100	explicitformula
2602	T	(k*binomial(3*n+k-1,n)*binomial(3*n+k,m))/(2*n+k)	1101	explicitformula
2603	U	 (4*sin(asin((3**(3/2)*sqrt(x))/2)/3)*sin(asin((3**( 3/2)*sqrt(y))/2)/3))/(3*sqrt(x)*sqrt(y))	1102	generatingfunction
2604	T	(k**2*binomial(3*m+k-1,m)*binomial(3*n+k-1,n))/((2 *m+k)*(2*n+k))	1102	explicitformula
2605	U	(2*(y+1)*sin(arcsin((3^(3/2)*sqrt(x*(y+1)^3))/2)/3) )/(sqrt(3)*sqrt(x*(y+1)))	1103	generatingfunction
2606	T	(k*binomial(3*n+k-1,n)*binomial(3*n+2*k,m))/(2*n+ k)	1103	explicitformula
2607	U	 (2*(y+1)^2*sin(arcsin((3^(3/2)*sqrt(x*(y+1)^3))/2)/ 3))/(sqrt(3)*sqrt(x*(y+1)))	1104	generatingfunction
2608	T	(k*binomial(3*n+k-1,n)*binomial(3*n+3*k,m))/(2*n+k)	1104	explicitformula
2609	U	-(2*sin(asin((3^(3/2)*sqrt(y))/2)/3))/(sqrt(3)*(( 8*x*sin(asin((3**(3/2)*sqrt(y))/2)/3)**3)/(3**(3/2)* y**(3/2))-1)*sqrt(y))	1105	generatingfunction
2610	T	((3*n+k)*binomial(n+k-1,n)*binomial(3*n+3*m+k-1,m ))/(3*n+2*m+k)	1105	explicitformula
2612	T	(k*binomial(3*k,m)*binomial(3*n+k-1,n))/(2*n+k)	1106	explicitformula
2613	U	 (3**(3/2)*(1-sqrt(1-(64*x*sin(asin((3**(3/2)*sqrt(y ))/2)/3)**4)/(9*y**2)))*y**(3/2))/(16*x*sin(asin((3**(3/2)*sqrt(y))/2)/3)**3)	1107	generatingfunction
2614	T	(k*(4*n+k)*binomial(2*n+k-1,n)*binomial(4*n+3*m+k -1,m))/((n+k)*(4*n+2*m+k))	1107	explicitformula
2616	T	(k*binomial(3*n+k-1,n)*binomial(3*n+m-1,m))/(2*n+k)	1108	explicitformula
2618	T	 (k*4**m*binomial(m+k/2-1,m)*binomial(3*n+k-1,n))/( 2*n+k)	1109	explicitformula
2620	T	(k*binomial(3*n+k-1,n)*binomial(3*n+m+k-1,m))/(2* n+k)	1110	explicitformula
2568	T	 binomial(k,m)*binomial(n+m+2*k-1,n+m-k)	1088	explicitformula
2573	T	0	1090	explicitformula
2564	T	binomial(2*n-k-1,n-1)*(-1)**(n-1)*k/n	1086	explicitformula
2558	T	binomial(m+k-1,m)*(-1)**(n-k)*binomial(n+m+2*k-1,n)	1084	explicitformula
2617	U	(2*sin(arcsin((3^(3/2)*sqrt(x))/2)/3))/(sqrt(3)*sqrt(x)*sqrt(1-4*y))	1109	generatingfunction
2595	U	 (2*sin(arcsin((3^(3/2)*sqrt(x*(y+1)^3))/2)/3))/(sqrt(3)*sqrt(x*(y+1)^3))	1098	generatingfunction
2563	T	(k*(-1)**(m+n-1)*(binomial(2*n-k,n))*(binomial(2*n-m-k-1,m-1)))/m	1086	explicitformula
2601	U	 (2*sin(arcsin((3^(3/2)*sqrt(x*(y+1)^3))/2)/3))/(sqrt(3)*sqrt(x*(y+1)))	1101	generatingfunction
2611	U	(2*sin(asin((3^(3/2)*sqrt(x))/2)/3)*(y+1)^3)/(sqrt(3)*sqrt(x))	1106	generatingfunction
2615	U	(2*sin(asin((3^(3/2)*sqrt(x/(1-y)^3))/2)/3))/(sqrt(3)*sqrt(x/(1-y)^3))	1108	generatingfunction
2619	U	(2*sin(asin((3^(3/2)*sqrt(x/(1-y)^3))/2)/3))/(sqrt(3)*sqrt(x/(1-y)))	1110	generatingfunction
2622	T	 (k*binomial(3*n+k-1,n)*binomial(3*n+m+2*k-1,m))/( 2*n+k)	1111	explicitformula
2623	U	 (1/(1-4*y)-sqrt(1/(1-4*y)**2-(4*x)/(1-4*y)**(3/2))) /(2*x)	1112	generatingfunction
2624	T	 (k*4**m*binomial((k-n)/2+m-1,m)*binomial(2*n+k-1,n ))/(n+k)	1112	explicitformula
2625	U	 (x+1)*(1-(4*sin(asin((3**(3/2)*sqrt(-y))/2)/3)**2)/ 3)	1113	generatingfunction
2626	T	 (k*binomial(k,n)*(-1)**(m-1)*binomial(3*m-k-1,m-1) )/m	1113	explicitformula
2627	U	 (2*sin(asin((3**(3/2)*sqrt(y))/2)/3))/(sqrt(3)*sqrt(1-4*x)*sqrt(y))	1114	generatingfunction
2628	T	(k*binomial(3*m+k-1,m)*4**n*binomial(n+k/2-1,n))/( 2*m+k)	1114	explicitformula
2629	U	(2*sin(asin((3**(3/2)*sqrt(y))/2)/3))/(sqrt(3)*sqrt(y))+(4*x*sin(asin((3**(3/2)*sqrt(y))/2)/3)**2)/(3 *y)	1115	generatingfunction
2630	T	(binomial(k,n)*(n+k)*binomial(n+3*m+k-1,m))/(n+2* m+k)	1115	explicitformula
2631	U	-(2*sin(asin((3**(3/2)*sqrt(y))/2)/3))/(sqrt(3)*(( 4*x*sin(asin((3**(3/2)*sqrt(y))/2)/3)**2)/(3*y)-1)* sqrt(y))	1116	generatingfunction
2632	T	(k*(2*n+k)*binomial(n+k,n)*binomial(2*n+3*m+k-1,m ))/((n+k)*(2*n+2*m+k))	1116	explicitformula
2633	U	 (3*(1-sqrt(1-(32*x*sin(asin((3**(3/2)*sqrt(y))/2)/ 3)**3)/(3**(3/2)*y**(3/2))))*y)/(8*x*sin(asin((3**(3/ 2)*sqrt(y))/2)/3)**2)	1117	generatingfunction
2634	T	 (k*(3*n+k)*binomial(2*n+k,n)*binomial(3*n+3*m+k-1 ,m))/((2*n+k)*(3*n+2*m+k))	1117	explicitformula
2635	U	 ((1-sqrt(1-(4*x)/(1-4*y)**(3/2)))*(1-4*y))/(2*x)	1118	generatingfunction
2636	T	 (k*4**m*binomial(2*n+k-1,n)*binomial((n+k)/2+n+m-1 ,m))/(n+k)	1118	explicitformula
2637	U	(2*x*sin(asin((3**(3/2)*sqrt(y))/2)/3))/(sqrt(3)*sqrt(y))+1	1119	generatingfunction
2638	T	 (binomial(k,n)*n*binomial(n+3*m-1,m))/(n+2*m)	1119	explicitformula
2639	U	((1-sqrt(1-(2*x*(1-sqrt(1-4*y)))/y))*y)/(x*(1-sqrt(1-4*y)))	1120	generatingfunction
2640	T	(k*n*binomial(n+2*m-1,m)*binomial(2*n+k-1,n))/((n +k)*(n+m))	1120	explicitformula
2641	U	 ((1-sqrt(1-(2*x*((-2*y)-sqrt(1-4*y)+1))/y**2))*y**2 )/(x*((-2*y)-sqrt(1-4*y)+1))	1121	generatingfunction
2642	T	 (k*n*binomial(2*n+k-1,n)*binomial(2*n+2*m,m))/((n +k)*(n+m))	1121	explicitformula
2643	U	 1/(1-(x*((-2*y)-sqrt(1-4*y)+1))/(2*y**2))	1122	generatingfunction
2644	T	(n*binomial(n+k-1,n)*binomial(2*n+2*m,m))/(n+m)	1122	explicitformula
2645	U	1/(1-(x*(1-sqrt(1-4*y)))/(2*y))	1123	generatingfunction
2646	T	(n*binomial(n+k-1,n)*binomial(n+2*m-1,m))/(n+m)	1123	explicitformula
2647	U	 1/(1-x/sqrt(1-4*y))	1124	generatingfunction
2648	T	4**m*binomial(n/2+m-1,m)*binomial(n+k-1,n)	1124	explicitformula
2649	U	(2*sin(arcsin((3^(3/2)*sqrt(x/(1-y)))/2)/3))/(sqrt( 3)*sqrt(x/(1-y))*(1-y))	1125	generatingfunction
2650	T	(k*binomial(n+m+k-1,m)*binomial(3*n+k-1,n))/(2*n+ k)	1125	explicitformula
2651	U	 (1-sqrt(1-4*x*(1-y)^2))/(2*x*(1-y)^5)	1126	generatingfunction
2652	T	 (k*binomial((-2*n)+m+3*k-1,m)*binomial(2*n+k-1,n) )/(n+k)	1126	explicitformula
2653	U	1/((1-x*(1-y)^5)*(1-y)^3)	1127	generatingfunction
2654	T	binomial((-5*n)+m+3*k-1,m)*binomial(n+k-1,n)	1127	explicitformula
2655	U	 (1/(1-y)^8+x)*(1-y)^5	1128	generatingfunction
2656	T	 binomial(k,n)*binomial((-8*n)+m+3*k-1,m)	1128	explicitformula
2657	U	(2*(1-cos((2*arcsin((3^(3/2)*sqrt(x*(y+1)))/2))/3)) )/(3*x)	1129	generatingfunction
2658	T	(k*binomial(n+k,m)*binomial(3*n+2*k-1,n))/(n+k)	1129	explicitformula
2659	U	 (2*(y+1)^2*(1-cos((2*arcsin((3^(3/2)*sqrt(x*(y+1))) /2))/3)))/(3*x)	1130	generatingfunction
2660	T	(k*binomial(n+3*k,m)*binomial(3*n+2*k-1,n))/(n+k)	1130	explicitformula
2661	U	 (2*(1-cos((2*arcsin((3^(3/2)*sqrt(x)*abs(y+1))/2))/ 3)))/(3*x*(y+1))	1131	generatingfunction
2662	T	(k*binomial(2*n+k,m)*binomial(3*n+2*k-1,n))/(n+k)	1131	explicitformula
2663	U	(2*(1-cos((2*arcsin((3^(3/2)*sqrt(x)*abs(y+1))/2))/ 3)))/(3*x)	1132	generatingfunction
2664	T	(k*binomial(2*n+2*k,m)*binomial(3*n+2*k-1,n))/(n+k)	1132	explicitformula
2665	U	 (2*(y+1)*(1-cos((2*arcsin((3^(3/2)*sqrt(x)*abs(y+1) )/2))/3)))/(3*x)	1133	generatingfunction
2666	T	(k*binomial(2*n+3*k,m)*binomial(3*n+2*k-1,n))/(n+ k)	1133	explicitformula
2667	U	(2*(1-cos((2*arcsin((3^(3/2)*sqrt(x))/(2*abs(y-1))) )/3)))/(3*x)	1134	generatingfunction
2668	T	(k*binomial(2*n+m+2*k-1,m)*binomial(3*n+2*k-1,n)) /(n+k)	1134	explicitformula
2669	U	(2*(1-cos((2*arcsin((3^(3/2)*sqrt(x))/(2*abs(y-1))) )/3))*(1-y))/(3*x)	1135	generatingfunction
2671	U	 (2*(1-cos((2*arcsin((3^(3/2)*sqrt(x))/(2*abs(y-1))) )/3)))/(3*x*(1-y))	1136	generatingfunction
2672	T	(k*binomial(2*n+m+3*k-1,m)*binomial(3*n+2*k-1,n)) /(n+k)	1136	explicitformula
2673	U	(1-sqrt(((-8*x)-8)*y+1))/(4*y)	1137	generatingfunction
2674	T	(k*2^m*binomial(m+k,n)*binomial(2*m+k-1,m))/(m+k)	1137	explicitformula
2675	U	(x+1)^2*(y+x)^2	1138	generatingfunction
2676	T	binomial(2*k,m)*binomial(2*k,n+m-2*k)	1138	explicitformula
2677	U	 (x+1)^2*(y+x)	1139	generatingfunction
2678	T	 binomial(k,m)*binomial(2*k,n+m-k)	1139	explicitformula
2679	U	 (x+1)^3*(y+x)	1140	generatingfunction
2680	T	binomial(k,m)*binomial(3*k,n+m-k)	1140	explicitformula
2681	U	 y^2+x^2+1	1141	generatingfunction
2682	T	(binomial(k,(n+m)/2)*((-1)^m+1)*binomial(n/2+m/2, n/2)*((-1)^n+1))/4	1141	explicitformula
2683	U	 x*y+1	1142	generatingfunction
2684	T	 binomial(k,n)*kron_delta(m,n)	1142	explicitformula
2685	U	 x^2*y+x+1	1143	generatingfunction
2686	T	 binomial(k,n-m)*binomial(n-m,m)	1143	explicitformula
2687	U	(1-sqrt(1-4*x*(y+1)))/(2*x*(y+1)^3)	1144	generatingfunction
2688	T	(k*binomial(n-2*k,m)*binomial(2*n+k-1,n))/(n+k)	1144	explicitformula
2689	U	(1-y)/(1-x/(1-y))	1145	generatingfunction
2690	T	 binomial(n+k-1,n)*binomial(n+m-k-1,m)	1145	explicitformula
2691	U	(1-y)^2/(1-x/(1-y))	1146	generatingfunction
2693	U	 (2*y)/((1-sqrt(1-4*y))*(1-(x*(1-sqrt(1-4*y)))/(2* y)))	1147	generatingfunction
2694	T	binomial(n+k-1,n)	1147	explicitformula
2695	T	 binomial(n+k-1 ,n)*(n-k)*binomial(2*m+n-k-1,m-1)/m	1147	explicitformula
2696	U	(sqrt(((-8*x)-8)*y+1)+1)/4	1148	generatingfunction
2697	T	2^(-k)	1148	explicitformula
2698	T	0	1148	explicitformula
2699	T	-k*2^(m-k)*(binomial(m,n))*(binomial(2* m-k-1,m-1))/m	1148	explicitformula
2700	U	((y-1)*sqrt((y+4*x-1)/(y-1))+y-1)/2	1149	generatingfunction
2701	T	(-1)^(m+k)*binomial(k,m)	1149	explicitformula
2702	T	(-1)^(k -1)*(k*((binomial(2*n-k-1,n-1))))/n*binomial(m+n-k-1,m)	1149	explicitformula
2714	U	 (sqrt(2)*sqrt(8*x**2*y-2*x-sqrt(1-4*x)+1)-sqrt(1-4 *x)+1)/(4*x)	1154	generatingfunction
2718	U	((-sqrt((-4*x*y)-4*y+1))-2*x*y-2*y+1)/(2*y**2)	1155	generatingfunction
2719	T	(k*binomial(2*m+2*k,n+m)*binomial(n+m,n))/(m+k)	1155	explicitformula
2720	U	((-sqrt((-4*x*y)-4*x+1))-2*x*y-2*x+1)/(2*x**2)	1156	generatingfunction
2721	T	 (k*binomial(n+m,n)*binomial(2*n+2*k,n+m))/(n+k)	1156	explicitformula
2722	U	(2*sin(arcsin((3**(3/2)*sqrt(x))/2)/3)*(y+1))/(sqrt( 3)*sqrt(x))	1157	generatingfunction
2723	T	(k*binomial(k,m)*binomial(3*n+k-1,n))/(2*n+k)	1157	explicitformula
2724	U	 (2*(x+1)*sin(arcsin((3**(3/2)*sqrt(y))/2)/3))/(sqrt( 3)*sqrt(y))	1158	generatingfunction
2726	U	-(2*sin(arcsin((3**(3/2)*sqrt(x))/2)/3))/(2*sin(arcsin ((3**(3/2)*sqrt(x))/2)/3)*y-sqrt(3)*sqrt(x))	1159	generatingfunction
2727	T	 (k*binomial(m+k,m)*binomial(3*n+m+k-1,n))/(2*n+m+ k)	1159	explicitformula
2728	U	(sqrt(3)*sqrt(x)-sqrt(3*x-16*sin(asin((3**(3/2)*sqrt(x))/2)/3)**2*y))/(4*sin(arcsin((3**(3/2)*sqrt(x))/ 2)/3)*y)	1160	generatingfunction
2729	T	(k*binomial(2*m+k,m)*binomial(3*n+2*m+k-1,n))/(2* n+2*m+k)	1160	explicitformula
2730	U	 -(2*sin(arcsin((3**(3/2)*sqrt(y))/2)/3))/(2*x*sin(arcsin((3**(3/2)*sqrt(y))/2)/3)-sqrt(3)*sqrt(y))	1161	generatingfunction
2731	T	(k*binomial(n+k,n)*binomial(n+3*m+k-1,m))/(n+2*m+k)	1161	explicitformula
2732	U	 (sqrt(3)*sqrt(y)-sqrt(3*y-16*x*sin(arcsin((3**(3/2)*sqrt(y))/2)/3)**2))/(4*x*sin(arcsin((3**(3/2)*sqrt(y))/2)/3))	1162	generatingfunction
2733	T	(k*binomial(2*n+k,n)*binomial(2*n+3*m+k-1,m))/(2* n+2*m+k)	1162	explicitformula
2734	U	 (2*sin(arcsin((3**(3/2)*sqrt(y))/2)/3))/(sqrt(3)*sqrt(y))+x	1163	generatingfunction
2738	U	 (2*sin(arcsin((3**(3/2)*sqrt(x))/2)/3))/(sqrt(3)*sqrt(x)*(1-y))	1164	generatingfunction
2739	T	(k*binomial(m+k-1,m)*binomial(3*n+k-1,n))/(2*n+k)	1164	explicitformula
2740	U	 (2*sin(arcsin((3**(3/2)*sqrt(y))/2)/3))/(sqrt(3)*(1- x)*sqrt(y))	1165	generatingfunction
2741	T	 (k*binomial(3*m+k-1,m)*binomial(n+k-1,n))/(2*m+k)	1165	explicitformula
2742	U	(sqrt(3)*sqrt(x)-sqrt(3*x-8*sqrt(3)*sin(arcsin((3**( 3/2)*sqrt(x))/2)/3)*sqrt(x)*y))/(2*sqrt(3)*sqrt(x )*y)	1166	generatingfunction
2743	T	 (k*binomial(2*m+k-1,m)*binomial(3*n+m+k-1,n))/(2* n+m+k)	1166	explicitformula
2744	U	 (sqrt(3)*sqrt(y)-sqrt(3*y-8*sqrt(3)*x*sin(arcsin((3**(3/2)*sqrt(y))/2)/3)*sqrt(y)))/(2*sqrt(3)*x*sqrt (y))	1167	generatingfunction
2745	T	 (k*binomial(n+3*m+k-1,m)*binomial(2*n+k-1,n))/(n+ 2*m+k)	1167	explicitformula
2746	U	(2/sqrt(3*(x+y)))*sin((1/3)*arcsin(sqrt(27*(x+y)/4)))	1168	generatingfunction
2747	T	(k*binomial(n+m,m)*binomial(3*n+3*m+k-1,n+m))/(2* n+2*m+k)	1168	explicitformula
2748	U	 (2*sin(arcsin((3**(3/2)*sqrt(x))/2)/3))/(sqrt(3)*sqrt(x)*(1-y)**2)	1169	generatingfunction
2749	T	 (k*binomial(m+2*k-1,m)*binomial(3*n+k-1,n))/(2*n+ k)	1169	explicitformula
2750	U	(2*sin(arcsin((3**(3/2)*sqrt(y))/2)/3))/(sqrt(3)*(1- x)**2*sqrt(y))	1170	generatingfunction
2751	T	 (k*binomial(3*m+k-1,m)*binomial(n+2*k-1,n))/(2*m+ k)	1170	explicitformula
2752	U	(sqrt(3)*((4*sin(arcsin((3**(3/2)*sqrt(y))/2)/3)**2)/ (3*y)+x)*sqrt(y))/(2*sin(arcsin((3^(3/2)*sqrt(y))/2 )/3))	1171	generatingfunction
2753	T	((binomial(2*n-2*m -k-1,m-1))*(-1)**(m-1)*(k-2*n)*(binomial(k,n)))/m	1171	explicitformula
2754	T	binomial(k,n)	1171	explicitformula
2755	U	 ((1-sqrt(1-4*x))*sin(arcsin((3**(3/2)*sqrt(y))/2)/3) )/(sqrt(3)*x*sqrt(y))	1172	generatingfunction
2756	T	 (k**2*binomial(3*m+k-1,m)*binomial(2*n+k-1,n))/((2 *m+k)*(n+k))	1172	explicitformula
2757	U	(x+1)^2*(sin(asin(216*y^2-1)/3)/(6*y)+1/(12*y))	1173	generatingfunction
2758	T	1	1173	explicitformula
2759	T	k/(m+k)*4^m*binomial((3*m+k)/ 2-1,m)	1173	explicitformula
2760	T	k/(m+k)*((binomial((3*m+k-1)/2,m))* ( binomial(3*m+k-1,(3*m+k-1)/2)))/binomial(m+k-1,(m +k-1)/2)	1173	explicitformula
2761	U	-(4*sin(arcsin((3**(3/2)*sqrt(y))/2)/3)**2)/(3*(x-(2* sin(arcsin((3**(3/2)*sqrt(y))/2)/3))/(sqrt(3)*sqrt(y )))*y)	1174	generatingfunction
2762	T	((-1)**(m-1)*(k-n)*binomial(n+k-1,n)*binomial(n-2* m-k-1,m-1))/m	1174	explicitformula
2763	T	1	1174	explicitformula
2764	U	((-sqrt(((-4*x)-4)*y+1))-(2*x+2)*y+1)/((2*x+2)*y**2)	1175	generatingfunction
2765	T	(k*binomial(m+k,n)*binomial(2*(m+k),m))/(m+k)	1175	explicitformula
2766	U	 (x+1)/sqrt(1-4*y)	1176	generatingfunction
2725	T	(k*((binomial(3*n-k-1,n-1))*(-1)^(n-1)))/n	1158	explicitformula
2715	T	1	1154	explicitformula
2736	T	binomial(k,n)*((binomial(3*m+k-n-1,m))*(k-n))/(2*m+k-n)	1163	explicitformula
2735	T	binomial(k,n)	1163	explicitformula
2767	T	 binomial(k,n)*4**m*binomial(m+k/2-1,m)	1176	explicitformula
2768	U	 1/(sqrt(1-4*y)-x)	1177	generatingfunction
2769	T	4**m*binomial(n+k-1,n)*binomial((n+k)/2+m-1,m)	1177	explicitformula
2770	U	((x+1)*((-2*y)-sqrt(1-4*y)+1))/(2*y**2)	1178	generatingfunction
2771	T	(k*binomial(k,n)*binomial(2*m+2*k,m))/(m+k)	1178	explicitformula
2772	U	 (sqrt(y**4+x*((-4*y**2)+8*y-2)+x*sqrt(1-4*y)*(2-4*y ))-y**2)/(x*(2*y-1)+x*sqrt(1-4*y))	1179	generatingfunction
2773	T	(k*binomial(2*n+k,n)*binomial(2*(2*n+k)+2*m,m))/( 2*n+m+k)	1179	explicitformula
2774	U	1/(3*sqrt(1-4*y))+1/(9*(1/(27*(1-4*y)**(3/2))+sqrt (x*(4/(1-4*y)**(3/2)+27*x))/(2*3**(3/2))+x/2)**(1/3) *(1-4*y))+(1/(27*(1-4*y)**(3/2))+sqrt(x*(4/(1-4*y)**(3/2)+27*x))/(2*3**(3/2))+x/2)**(1/3)	1180	generatingfunction
2777	T	1	1181	explicitformula
2621	U	(2*sin(asin((3^(3/2)*sqrt(x/(1-y)^3))/2)/3))/(sqrt(3)*sqrt(x/(1-y))*(1-y))	1111	generatingfunction
2780	U	1/sqrt(x**2*y**2-2*x**2*y-2*x*y+x**2-2*x+1)	1184	generatingfunction
2781	T	binomial(n+k,m)*binomial(n+k,m+k)	1184	explicitformula
264	T	(binomial(k,m)*binomial(m,n+m-k)  )	131	explicitformula
1303	T	 (k*binomial(2*(m+k),m)*binomial(2*n+2*(m+k),n))/( n+m+k)	535	explicitformula
286	T	binomial(k,n)*binomial(m+k-1,m)	142	explicitformula
2803	T	k/(m+n)*binomial(m+ n,n)*binomial(2*n,m+n-k)	269	explicitformula
468	T	2**(m-1)*((-1)**m+1)*binomial((m+k-2)/2,m/2)*binomial(n+m+k-1,n)	225	explicitformula
875	T	(k*((-1)**m+1)*binomial(m+k,m/2)*binomial(n+m+k-1, n))/(2*(m+k))	393	explicitformula
700	T	 binomial(k,m)*binomial(n+2*m-k-1,n)	316	explicitformula
479	T	(k*4**n*binomial((n+k)/2,(k-n)/2)*binomial(n+m+k-1 ,m))/(n+k)	229	explicitformula
706	T	 (k*binomial(2*m-k-1,n)*binomial(n+k,m))/(n+k)	319	explicitformula
364	T	1	179	explicitformula
2786	T	2*k*binomial(n+m,m)*binomial(n+m+2*k-1,m+2*k)/(n+m)	241	explicitformula
523	T	(k*4**n*(binomial(n+k,m ))*(binomial((n-m+k)/2,n)))/(n+k)	245	explicitformula
525	T	(k*binomial((m+k)/2,n)*binomial(2*m+k-1,m)*4**n)/( m+k)	246	explicitformula
2549	T	(k*(-1)*(binomial(n-k-1,m-1))*(binomial(n-1, n-m)))/m	1080	explicitformula
2787	T	0	1080	explicitformula
2776	U	((-sqrt((4*x-4)*y+x^2-2*x+1))+x-1)/(2*x-2)	1181	generatingfunction
2788	T	(k* (binomial(2*m-k-1,m-1))*(-1)*(binomial(n+m-1,n))) /m	1181	explicitformula
2789	T	0	1181	explicitformula
2791	T	(k*binomial((-n)+k-1,n+m-1)*binomial(n+m,m))/(n+m)	165	explicitformula
2792	T	 (k*binomial(k-m-1,n+m-1)*binomial(n+m,n))/(n+m)	166	explicitformula
2553	T	binomial(n-m+k, k)*binomial(2*(n-m+k),n-m+k)/binomial(2*k,k)	1082	explicitformula
2554	T	4**(n-m)*binomial(n-m+k,k)	1082	explicitformula
2800	T	(k*( binomial(n-m+k-1,m-1))*(binomial(2*n+k-1,n)))/m	179	explicitformula
2810	T	 binomial(n+m,m)*k/(n+m )*binomial(2*n+2*m,n+m-k)	218	explicitformula
2811	T	2*((binomial(k-1,m ))*k*(binomial(2*n-2*m+2*k-1,n-1)))/n	338	explicitformula
2794	T	(k*binomial(2*m+2*k,2*m) *binomial(n,m)*binomial(n+k,m)*binomial(2*n+2*k,n ))/(binomial(m+k,k)*(n+k)*binomial(2*n+2*k,2*m))	250	explicitformula
2799	T	binomial(m+k-1,m)*((binomial(m+(k-1)/2,m)*binomial(2*m+(k-1),m+(k-1)/2))/binomial(k-1,(k-1)/2))	331	explicitformula
2797	T	binomial(n+k -1,n)*k*binomial(k-m-1,m-1)/m	178	explicitformula
2795	T	1	250	explicitformula
2801	T	k/n*binomial(2 *n-k-1,n-1)*(-1)**(n-1)*binomial(m+k-1,m)	262	explicitformula
2802	T	k/n* binomial(2*n-m-k-1,n-1)*(-1)**(n-1)*binomial(2*m+k -1,m)	263	explicitformula
2798	T	binomial(2*m,n)*(binomial(m+(k-1)/2,m)*binomial(2*m+(k-1),m+(k-1)/2)/binomial((k-1),(k-1)/2))	330	explicitformula
2796	T	binomial(m,n)*(binomial(m+(k-1)/2,m)*binomial(2*m+(k-1),m+(k-1)/2)/binomial((k-1),(k-1)/2))	329	explicitformula
2793	T	binomial(n+m-1,n)*(binomial(m+(k-1)/2,m)*binomial(2*m+k-1,m+(k-1)/2)/binomial(k-1,(k-1)/2))	328	explicitformula
2790	T	binomial(n+4*m+2*k-1,n)*(binomial(m+(k-1)/2, m)*binomial(2*m+k-1, m+(k-1)/2)/binomial(k-1, (k-1)/2))	327	explicitformula
2804	T	k*binomial(2*n+k-1,n)/(n+k)*binomial(m+(n+k-1)/2,m)*binomial(2*m+(n+k-1),m+(n+k-1)/2)/binomial((n+k-1),(n+k-1)/2)	332	explicitformula
2805	T	binomial(n+2*k-1,n)*binomial(m+(k-1)/2,m)*binomial(2*m+k-1,m+(k-1)/2)/binomial(k-1,(k-1)/2)	333	explicitformula
2806	T	(k*binomial((-2*n)+m+2*k-1,m)*binomial((-n)+k-1,n -1))/n	198	explicitformula
2807	T	(k*binomial((-m)+k-1,m-1)*binomial(n-2*m+2*k-1,n) )/m	200	explicitformula
2808	T	k/n*binomial(2*n-k -1,n-1)*(-1)**(n-1)*binomial(k,m)	208	explicitformula
2809	T	binomial(n+m,m)*k/(n+m )*binomial(2*n+2*m-k-1,n+m-k)	214	explicitformula
2812	T	(binomial(k,m)*m*binomial(2*(n+m-k)+2*m,n+m-k))/( n+2*m-k)	340	explicitformula
754	T	binomial(k,m)*binomial(n+3*m-k-1,n+m-k)	341	explicitformula
756	T	binomial(k,m)*binomial(n+4*m-k-1,n+m-k)	342	explicitformula
762	T	binomial(k,m)*binomial(m+k,n+m-k)	344	explicitformula
2813	U	 y^2+x^2	1187	generatingfunction
2713	T	(((-1)**m+1)*(binomial(k,k-m/2))*(binomial(n+m-k-1,n+m-2*k)))/2	1090	explicitformula
2814	T	(delta(k,(n+m)/2)*((-1)**m+1)*binomial(n/2+m/ 2,n/2)*((-1)**n+1))/4	1187	explicitformula
814	T	((-1)**m+1)*binomial(n+m/2,n)*binomial(n+m/2+(k-1)/2,n+m/2)*binomial(2*(n+m/2)+k-1,n+m/2+(k-1)/2)/(binomial(k-1,(k-1)/2)*2)	365	explicitformula
2816	U	y+(1-sqrt(1-4*x))/(2*x)	1188	generatingfunction
2817	T	0	1188	explicitformula
2775	T	1	1180	explicitformula
2815	T	((-1)**n+1)*binomial(m+n/2,m)*binomial(m+n/2+(k-1)/2,m+n/2)*binomial(2*(m+n/2)+k-1,m+n/2+(k-1)/2)/(binomial(k-1,(k-1)/2)*2)	366	explicitformula
2818	T	binomial(k,m)	1188	explicitformula
2819	T	binomial(k,m)*(k-m)/(n+k-m)*binomial(2*n+k-m-1,n)	1188	explicitformula
2827	T	delta(0,n%3)*binomial(k,n/3)*binomial(k -n/3,n/3+m-k)	382	explicitformula
2854	T	k*binomial (n-k-1,m-1)*(-1)**(m-1)*(binomial(2*n-m-2*k,n)*(-1 )**n)/m	298	explicitformula
2828	T	delta(0,m%3)*binomial(k,m/3)*binomial(k -m/3,n+m/3-k)	381	explicitformula
2820	T	(k*(binomial(m-k-1 ,n-1))*(-1)**(-n+m-1)*(binomial(n+m-k,m)))/n	367	explicitformula
2821	T	(2*(binomial(k-1,n ))*k*(binomial(-2*n+2*m+2*k-1,m-1)))/m	368	explicitformula
2822	T	binomial(k,m)*binomial(n+(k-m-1)/2,n)*binomial(2*n+k-m-1,n+(k-m-1)/2)/binomial(k-m-1,(k-m-1)/2)	371	explicitformula
831	T	k*binomial(2*m+k-1,m)*binomial(n+(k+m)/2,n)*binomial(2*n+k+m,n+(k+m)/2)/(binomial(k+m,(k+m)/2)*(m+k))	373	explicitformula
2823	T	k*binomial(2*m+k-1,m)*binomial(n+(k+m-1)/2,n)*binomial(2*n+k+m-1,n+(k+m-1)/2)/(binomial(k+m-1,(k+m-1)/2)*(m+k))	373	explicitformula
2824	T	 (binomial((-m)+k-1,n)*(-1)**(m-1)*binomial(n+m-k-1 ,m-1))/m	377	explicitformula
2825	T	 (binomial(k,m/2)*binomial(k-m/2,n+m/2-k)*((-1)**m+ 1))/2	379	explicitformula
2826	T	(binomial(k,m)*binomial(k-m,(n+m-k)/2)*((-1)**(n+m -k)+1))/2	383	explicitformula
2829	T	(binomial(k,n/2)*binomial(k-n/2,n/2+m-k)*((-1)**n+ 1))/2	380	explicitformula
2830	T	(binomial(k,n)*binomial(k-n,(n+m-k)/2)*((-1)**(n+m -k)+1))/2	384	explicitformula
2831	T	(binomial(k,m)*binomial(k-m,n/2)*((-1)**n+1))/2	389	explicitformula
2737	T	0	1163	explicitformula
2855	T	 2*k*(-1)**(n-1)*( binomial(2*n-2*k-2*m-1,n-1))/n	298	explicitformula
2856	T	(binomial(k-1,n))* k*(binomial(n-m-k-1,m-1)*(-1)**(m-1))/(m)	310	explicitformula
2832	U	 (sqrt(2*sqrt(3)*sin(arcsin((3**(3/2)*sqrt(x))/2)/3)* sqrt(x)*y+sin(arcsin((3**(3/2)*sqrt(x))/2)/3)**2)+sin (arcsin((3**(3/2)*sqrt(x))/2)/3))/(sqrt(3)*sqrt(x))	1189	generatingfunction
2833	T	1	1189	explicitformula
2834	T	(k*((binomial(2*m-k-1,m-1))*(-1)**(m-1)))/m	1189	explicitformula
2835	T	 k*((binomial(k-m,m) )*(binomial(m-2*n-k-1,n-1)))*(-1)**(n+1)/(n)	1189	explicitformula
2838	U	y+(2*sin(arcsin((3**(3/2)*sqrt(x))/2)/3))/(sqrt(3)*sqrt(x))	1191	generatingfunction
2839	T	binomial(k,m)	1191	explicitformula
2840	T	(binomial(k,m)*(k-m)*binomial(3*n-m+k-1,n))/(2*n-m+k)	1191	explicitformula
2836	U	 (sqrt(2*sqrt(3)*x*sin(asin((3**(3/2)*sqrt(y))/2)/3 )*sqrt(y)+sin(asin((3**(3/2)*sqrt(y))/2)/3)**2)+sin(arcsin((3**(3/2)*sqrt(y))/2)/3))/(sqrt(3)*sqrt(y))	1190	generatingfunction
2837	T	1	1190	explicitformula
2841	T	k*((binomial(k-n,n) )*(binomial(n-2*m-k-1,m-1)))*(-1)**(m+1)/m	1190	explicitformula
2842	T	 ((binomial(n-m -k-1,m-1))*(-1)**(m-1)*(k-n)*(binomial(n+k-1,n)))/m	395	explicitformula
2843	T	(binomial(k,n)*((-1)**(m-1))*(k-2*n)*binomial(2*n-m-k-1,m-1))/m	396	explicitformula
602	T	1	276	explicitformula
2844	T	0	276	explicitformula
2845	T	 k/ n*binomial(2*n-k-1,n-1)*(-1)**(n-1)*binomial(2*(n) ,m)	276	explicitformula
2846	T	0	280	explicitformula
2847	T	 (k/m*(binomial(2*m-k-1,m-1)*(-1)**(m-1))*(binomial(n+ 2*(m)-1,n)))	280	explicitformula
2848	T	0	284	explicitformula
2849	T	 k/m *((binomial(2*m-k-1,m-1))*(-1)**(m-1))*(binomial(n +3*m-1,n))	284	explicitformula
2850	T	 (k*(binomial(k,n)) *(binomial(2*m-k-1,m-1)))/(m)*(-1)**(m-1)	288	explicitformula
2851	T	(k*(binomial(2*m-k -1,m-1)*(-1)^(m-1))*(binomial(m+k,n)))/m	296	explicitformula
2853	T	k*binomial(n+m -k-1,m-1)*(-1)**(m-1)*(binomial(2*n+m-2*k,n)*(-1)**n)/m	297	explicitformula
2857	U	((-sqrt(2)*sqrt(sqrt(1-4*y)*((-4*x*y**3)+2*y-1)+4*x*y**3+2*y**2-4*y+1))+2*y+sqrt(1-4*y)-1)/(2*sqrt(1- 4*y)*y-2*y)	1192	generatingfunction
2868	T	0	1194	explicitformula
2858	T	binomial(2*m+k-1,m)*k/(m+k)	1192	explicitformula
2859	T	k*binomial(2*n-k-1,n-1)*(-1)**(n-1)/n	1192	explicitformula
2852	T	2*k*(-1)**(n-1)*( binomial(2*n-2*k-1,n-1))/n	297	explicitformula
2860	T	k*((binomial(3*n-m-k-1,m-1))*(-1)**(m-1)*(k-3*n)* (binomial(2*n-k-1,n-1)*(-1)**(n-1)))/m/n	1192	explicitformula
908	T	 binomial(m+2*k-1,m)	405	explicitformula
909	T	k*((binomial (2*(k-3*n)+m-1,m))*(binomial(k-n-1,n-1)))/n	405	explicitformula
2861	U	 (sqrt(3*x*y+sin(arcsin((3**(3/2)*sqrt(x))/2)/3)**2)+sin(arcsin((3**(3/2)*sqrt(x))/2)/3))/(sqrt(3)*sqrt(x))	1193	generatingfunction
2862	T	1	1193	explicitformula
2863	T	(k*(binomial(3*n+k-1,n)))/(2*n+k)	1193	explicitformula
2865	U	 (sin(arcsin((3**(3/2)*sqrt(x))/2)/3)-sqrt(3*x*y+sin( arcsin((3**(3/2)*sqrt(x))/2)/3)**2))/(sqrt(3)*sqrt(x))	1194	generatingfunction
2866	T	k*((binomial(2*m-k-1,m-1))*(-1)**(m))/m	1194	explicitformula
2867	T	(k*(binomial(k-m-1,m-1))*(k-2*m)*(binomial(-2*n+2*m-k-1,n-1)*(-1)**n))/(n)/m	1194	explicitformula
2869	U	(sqrt(2)*sqrt(sqrt(1-4*y)*((-4*x*y**3)+2*y-1)+4*x* y**3+2*y**2-4*y+1)+2*y+sqrt(1-4*y)-1)/(2*sqrt(1-4*y )*y-2*y)	1195	generatingfunction
2870	T	(k*(binomial(2*n-k-1,n-1))*(-1)**(n))/n	1195	explicitformula
2871	T	k*((binomial(3*n-m-k-1,m-1))*(-1)**(m-1)*(k-3*n)*(binomial(2*n-k-1,n-1)*(-1)**(n)))/m/n	1195	explicitformula
2872	T	0	1195	explicitformula
2873	T	(k*(binomial( -m+k-1,n-m))*(binomial(n-k-1,m-1))*(-1)**(n-m+1))/m	409	explicitformula
2874	T	(k*( (binomial(2*m-k-1,m-1))*(-1)**(m-1)))/m*k/(n+k)*binomial(2*n+k-1,n)	415	explicitformula
2875	T	 ((k-n)*((binomial(2*m+n-k-1,m-1))*(-1)**(m-1)))/m*binomial(n+k-1 ,n)	416	explicitformula
2876	T	((k-2*n)*((binomial(2*m+2*n-k-1,m-1))*(-1)**(m-1)))/m*binomial(k,n)	417	explicitformula
2877	T	(k*((binomial(2*n-k-1,n-1))*(-1)**(n-1)))/n	418	explicitformula
2878	T	(k*((binomial(2*m-k-1,m-1))*(-1)**(m-1)))/m	418	explicitformula
2879	T	((k-3*n)*((binomial(2*m+3*n-k-1,m-1))*(-1)**(m-1)))/m*binomial(k-n-1,n-1)*k/n	418	explicitformula
2717	T	binomial(2*m-k-1,m-1)*(-1)**(m-1)*k/m	1154	explicitformula
2880	T	 -(k*((binomial(2*n -k-1,n-1))*(-1)**(n-1)))/n	419	explicitformula
2881	T	-((k-3*n)*((binomial(2*m+3*n-k-1,m-1))*(-1)**(m-1)))/m*binomial(k-n-1,n-1)*k/n	419	explicitformula
2882	T	(2*k*binomial((-2*n)+2*k-1,n-1)*binomial((-2*n)+m +k-1,m))/n	427	explicitformula
2885	T	k/(m+k)*binomial(2*m+2*k,m)	431	explicitformula
2886	T	2*k*binomial(2*k-2*n-1,n-1)/n	431	explicitformula
2887	T	 (4*k*binomial(2*(k-n)-1,n-1)*binomial((-4*n)+2*m+ 2*k-1,m-1)*(k-2*n))/(m*n)	431	explicitformula
982	T	(2*k*binomial(2*(k-2*n)+m-1,m)*binomial(2*(k-n)-1 ,n-1))/n	434	explicitformula
2888	T	-(k*binomial((-n)+k-1,n+m-1) *binomial(n+m,m))/(n+m)	439	explicitformula
1012	T	0	446	explicitformula
2892	T	 (k*binomial((-2*n)+k-1,n+m-1)*binomial(n+m,m))/(n +m)	448	explicitformula
2893	T	-(k*binomial((-2*n)+m+k-1,m) *binomial((-n)+k-1,n-1))/n	450	explicitformula
2895	T	(k*binomial((-3*n)+m+k-1,m)*binomial((-2*n)+k-1,n -1))/n	451	explicitformula
2894	T	binomial(-k+n-1,m-1)*(-1)**(m-1)*k/m	451	explicitformula
2901	T	4**m*binomial(m+(k-2*n)/2-1,m)*binomial(n-k-1,n-1)*(-1)**(n-1)*k/(n)	458	explicitformula
2900	T	(k*4**m*(binomial((n-k)/2-1,m-1)*(-1)^(m-1))/(2*m)) 	458	explicitformula
2905	T	4**m*binomial(m+(k-3*n)/2-1,m)*binomial(2*n-k-1,n-1)*(-1)**(n-1)/(n)*k	1197	explicitformula
2904	T	k*4**m*(binomial((2*n-k)/2-1,m-1)*(-1)**(m-1))/(2*m)	1197	explicitformula
2883	T	2*binomial(2*k-2*n-1,n-1)/n	428	explicitformula
2884	T	 (2*k*(-1)**(m-1)*binomial(2*(k-n)-1,n-1)*(k-2*n)*binomial(2*n-m-k-1,m-1))/(m*n)	428	explicitformula
975	T	1	431	explicitformula
2889	T	2*binomial(2*k-2*n-1,m-1)*k/m	447	explicitformula
2890	T	(k*(-1)**(n-1)*(binomial(3*n-k-1,n-1)))/n	447	explicitformula
2891	T	(k*binomial(2*k-6*n,m)*binomial((-2*n)+k-1,n-1))/n	447	explicitformula
2896	T	(k*binomial((-4*n)+m+2*k-1,m)*binomial((-n)+k-1,n -1))/n	453	explicitformula
2897	U	 (1-sqrt(4*x*y**4-16*x*y^3+24*x*y**2-16*x*y+4*x+1))/ (2*y**2-4*y+2)	1196	generatingfunction
2898	T	0	1196	explicitformula
2899	T	 -(k*binomial((-4*n)+m+2*k-1, m)*binomial((-n)+k-1,n-1))/n	1196	explicitformula
2902	U	 (sqrt(sqrt(1-4*y)*(4*x-16*x*y)+1)+1)/(2*sqrt(1-4* y))	1197	generatingfunction
2903	T	1	1197	explicitformula
2906	U	sqrt(1+4*x)*(1+y)	1198	generatingfunction
2907	T	Tsqrt(n, k)*binomial(k, m)	1198	explicitformula
2908	U	-sqrt(4*x+1)/(sqrt(4*x+1)*y-1)	1199	generatingfunction
2909	T	k/(m+k) * Tsqrt(n, m+k)*binomial(m+k, m)	1199	explicitformula
2910	U	 (1-sqrt(((-16*x)-4)*y+1))/(2*sqrt(4*x+1)*y)	1200	generatingfunction
2911	T	k/(2*m+k) * Tsqrt(n, 2*m+k)*binomial(2*m+k, m)	1200	explicitformula
2913	T	k/(m+k) * Tsqrt(n, m+k)*binomial(2*m+2*k, m)	1201	explicitformula
2912	U	((-sqrt(1-4*sqrt(4*x+1)*y))-2*sqrt(4*x+1)*y+1)/(2 *sqrt(4*x+1)*y^2)	1201	generatingfunction
2914	U	sqrt(4*x+1)/(1-y)^2	1202	generatingfunction
2915	T	Tsqrt(n, k)*binomial(m+2*k-1,m)	1202	explicitformula
2916	U	x*sqrt(4*y+1)+1	1203	generatingfunction
2917	T	Tsqrt(m, n)*binomial(k, n)	1203	explicitformula
2918	U	 (y+1)*sqrt(4*x^2*y^2+8*x^2*y+4*x^2+1)+2*x*y^2+4*x *y+2*x	1204	generatingfunction
2919	T	k/(n+k) * Tsqrt(n, n+k)*binomial(n+k, m)	1204	explicitformula
2920	U	x*sqrt(4*x^2*y^2+4*y+1)+2*x^2*y+1	1205	generatingfunction
2921	T	k/(m+k) * Tsqrt(m, n)*binomial(m+k, n)	1205	explicitformula
2922	U	sqrt(4*y+1)+x*(4*y+1)	1206	generatingfunction
2923	T	Tsqrt(m, n+k)*binomial(k, n)	1206	explicitformula
2924	U	(1-sqrt(1-4*x*sqrt(4*y+1)))/(2*x*sqrt(4*y+1))	1207	generatingfunction
2925	T	Tsqrt(m, n)*(k/(n+k))*binomial(2*n+k-1, n)	1207	explicitformula
2926	U	 ((-sqrt(1-4*x*sqrt(4*y+1)))-2*x*sqrt(4*y+1)+1)/(2 *x^2*(4*y+1))	1208	generatingfunction
2927	T	k/(n+k) * Tsqrt(m, n)*binomial(2*n+2*k, n)	1208	explicitformula
2928	T	 -(k*4**m*binomial((k-3*n)/2+m -1,m)*(-1)**(n-1)*binomial(2*n-k-1,n-1))/n	459	explicitformula
2949	T	-(k*4**m*binomial((k-n)/2+m-1 ,m)*binomial((-n)+k-1,n-1))/n	473	explicitformula
1047	T	 (k*4**m*binomial((k-4*n)/2+m-1,m)*(-1)**(n-1)*binomial(3*n-k-1,n-1))/n	460	explicitformula
2929	U	 (sqrt((y+1)**2+4*x*(y+1))+y+1)/2	1209	generatingfunction
2931	U	(sqrt(4*x*sqrt(4*y+1)+1)+1) / 2	1210	generatingfunction
2932	T	Tsqrt(m, n)*TA271825(n, k)	1210	explicitformula
2930	T	binomial(k,m)	1209	explicitformula
2933	T	 (k*binomial((-n)+k-1,n-1)*binomial(k-n,m))/n	1209	explicitformula
2935	T	(k*binomial((-2*n)+k-1,n-1)*binomial(k-2*n,m))/n	462	explicitformula
2934	T	binomial(k-n-1,m-1)*k/m	462	explicitformula
2936	T	(k*binomial((-n)+k-1,n-1)*binomial((-n)+m+k-1,m)) /n	463	explicitformula
2937	T	-(k*binomial((-n)+k-1,n-1)*binomial((-n)+m+k-1,m))/n	464	explicitformula
2939	T	 (k*binomial((-2*n)+k-1,n-1)*binomial((-2*n)+m+k-1 ,m))/n	465	explicitformula
2941	T	Tsqrt(m, n) * TA984(n, k)	1211	explicitformula
2938	T	binomial(n-k-1,m-1)*(-1)**(m-1)*k/m	465	explicitformula
2940	U	sqrt((4*x+1)/(1-4*y))	1211	generatingfunction
2942	U	-sqrt(4*y+1)/(x*(4*y+1)-1)	1212	generatingfunction
2943	T	k/(n+k) * Tsqrt(m, 2*n+k)*binomial(n+k, n)	1212	explicitformula
2944	T	 (k*binomial((-n)+k-1,n-1)*binomial(2*(k-n),m))/n	469	explicitformula
1719	T	k/(2*n+k) * Tsqrt(m, 3*n+k)*binomial(2*n+k, n)	688	explicitformula
2945	T	-(k*binomial((-n)+k-1,n-1)*binomial(2*(k-n),m))/n	470	explicitformula
2946	U	(1/sqrt(1-4*y)+sqrt((4*x)/sqrt(1-4*y)+1/(1-4*y))) /2	1213	generatingfunction
2947	T	4**m*binomial(m+k/2-1,m)	1213	explicitformula
2948	T	k*binomial(k-n-1,n-1)*binomial(m+(k-n)/2-1,m)*4**m/n	1213	explicitformula
1729	T	( k * ((-1)**m + 1) * binomial(m+k, n) * binomial(-n+m+k, m/2) ) / (2*(m+k))	693	explicitformula
2951	T	1/2*4**m*binomial((n-k)/2-1,m-1)*(-1)**(m-1)*k/(m)	474	explicitformula
2950	T	 (k*4**m*binomial((k-2*n)/2+m-1,m)*binomial((-2*n)+ k-1,n-1))/n	474	explicitformula
2954	U	(sqrt(2)*sqrt(8*x**4*y+2*x**2+sqrt(1-4*x)*(2*x-1)-4 *x+1)-2*x-sqrt(1-4*x)+1)/(4*x**2)	1214	generatingfunction
2953	T	(k*(-1)**(m-1)*binomial(k-n,n)*binomial(n-m-k-1,m-1))/m	475	explicitformula
2952	T	k*((binomial(2*n-k-1,n-1))*(-1)**(n-1))/n	475	explicitformula
2864	T	k*((binomial(2*m-k-1,m-1))*(-1)**(m-1))/m	1193	explicitformula
2955	T	binomial(k-m-1,m-1)*k/(m)	1214	explicitformula
2957	U	 ((-sqrt(2)*sqrt(8*x*y^2-2*y-sqrt(1-4*y)+1))-sqrt( 1-4*y)+1)/(4*y)	1215	generatingfunction
2956	T	(2*k*(binomial(-m+k-1,m))*(binomial (2*n-2*m+2*(k-m)-1,n-1)))/n	1214	explicitformula
2958	T	0	1215	explicitformula
2959	T	-binomial(2*n-k-1,n-1)*(-1)**(n-1)*k/n	1215	explicitformula
2960	T	-(k*(-1)**(m+n-1)*(binomial(2*n-k,n))*(binomial(2*n-m-k-1,m-1)))/m	1215	explicitformula
2716	T	 k*(binomial(2*m-k,m))*( binomial(-n+2*m-k-1,n-1)*(-1)**(n+m-1))/n	1154	explicitformula
2963	U	6	1217	generatingfunction
2964	T	6	1217	explicitformula
2961	U	((1-(4*(sin((asin((3^((3)/(2))*sqrt(-x))/(2)))/(3))^(2)))/(3))^(2))/(1-y)	1216	generatingfunction
2962	T	binomial(m+k-1, m)	1216	explicitformula
2965	T	2*k * binomial(m+k-1, m) * (-1)**(n-1) * binomial(3*n-2*k-1,n-1) / n	1216	explicitformula
2389	T	1	1009	explicitformula
2966	T	(3*binomial(k,n)*n*binomial(3*n+2*m-1,m))/(3*n+m)	1048	explicitformula
2967	T	(2*binomial(k,n)*n*binomial(4*n+2*m,m))/(2*n+m)	1049	explicitformula
2968	T	(3*binomial(k,n)*n*binomial(6*n+2*m,m))/(3*n+m)	1050	explicitformula
2969	T	(binomial(2*k,n)*n*binomial(n+2*m-1,m))/(n+m)	1057	explicitformula
2970	T	(2*binomial(2*k,n)*n*binomial(2*n+2*m-1,m))/(2*n+ m)	1058	explicitformula
2971	T	(3*binomial(2*k,n)*n*binomial(3*n+2*m-1,m))/(3*n+m)	1059	explicitformula
2972	T	(2*binomial(2*k,n)*n*binomial(4*n+2*m,m))/(2*n+m)	1060	explicitformula
2973	T	 (3*binomial(2*k,n)*n*binomial(6*n+2*m,m))/(3*n+m)	1061	explicitformula
2974	T	 (binomial(3*k,n)*n*binomial(n+2*m-1,m))/(n+m)	1068	explicitformula
2975	T	(2*binomial(3*k,n)*n*binomial(2*n+2*m-1,m))/(2*n+ m)	1069	explicitformula
2976	T	binomial(2*k, n) * binomial(n+m+k-1, m)	701	explicitformula
2977	U	((1-(4*(sin((asin((3^((3)/(2))*sqrt(-x))/(2)))/(3))^(2)))/(3))^(2))/((1-y)^(2))	1218	generatingfunction
2978	T	binomial(m+2*k-1, m)	1218	explicitformula
2979	T	2*k * binomial(m+2*k-1, m) * (-1)**(n-1) * binomial(3*n-2*k-1,n-1) / n	1218	explicitformula
1759	T	k*binomial(2*n+2*k, n) * binomial(4*n+m+2*k-1, m) / (n+k)	706	explicitformula
2980	U	(1-(4*(sin((asin((3^((3)/(2))*sqrt(-x))/(2)))/(3))^(2)))/(3))^(3) * (1+y)	1219	generatingfunction
2981	T	binomial(k, m)	1219	explicitformula
2982	T	3*k*binomial(k,m)*(-1)**(n-1)*binomial(3*n-3*k-1,n-1)/n	1219	explicitformula
2983	U	(1-(4*(sin((asin((3^((3)/(2))*sqrt(-x))/(2)))/(3))^(2)))/(3))^(3) * (1+y)**2	1220	generatingfunction
2984	T	binomial(2*k, m)	1220	explicitformula
2985	T	3*k*binomial(2*k,m)*(-1)**(n-1)*binomial(3*n-3*k-1, n-1) / n	1220	explicitformula
2986	U	(1-(4*(sin((asin((3^((3)/(2))*sqrt(-x))/(2)))/(3))^(2)))/(3))^(4) * (1+y)	1221	generatingfunction
2987	T	binomial(k, m)	1221	explicitformula
2988	T	4*k * binomial(k, m) * (-1)**(n-1) * binomial(3*n-4*k-1,n-1) / n	1221	explicitformula
2989	U	((1-(4*(sin((asin((3^((3)/(2))*sqrt(-x))/(2)))/(3))^(2)))/(3))^(2))/((2*y)) * (1-sqrt(1-4*y))	1222	generatingfunction
2990	T	k*binomial(2*m+k - 1, m) / (m+k)	1222	explicitformula
2991	T	2 * (k ** 2)  * binomial(2*m+k-1, m) * (-1)**(n-1) * binomial(3*n-2*k-1,n-1) / (n*(m+k))	1222	explicitformula
2992	U	x**2 * (1-sqrt(1-4*y)) ** 3 / (8 * y**3) + (x*(1-sqrt(1-4*y)) **2) / (2 * y**2) + (1-sqrt(1-4*y)) / (2*y)	1223	generatingfunction
2993	T	binomial(2*k, n) * (n+k) * binomial(n+2*m+k-1, m) / (n+m+k)	1223	explicitformula
2995	T	k*(2*n+k) * binomial(2*n+2*k, n) * binomial(2*n+2*m+k-1, m) / ((n+k) * (2*n+m+k))	1224	explicitformula
3016	T	3*k / (2*n + 3*k) * binomial(2*n+3*k, n) * TLeftA271825(m, n+k)	1234	explicitformula
2994	U	(4 * (1 - sqrt(1 - (x*(1-sqrt(1-4*y))**2)/(y**2) ) - (x*(1-sqrt(1-4*y))**2)/(2*y**2)) * y**3) / (x**2 * ((1-sqrt(1-4*y))**3)) 	1224	generatingfunction
2996	U	((1-(4*(sin((asin((3^((3)/(2))*sqrt(-x))/(2)))/(3))^(2)))/(3))^(2))/((2*y ** 2)) * (1-sqrt(1-4*y) - 2*y)	1225	generatingfunction
2997	T	k*binomial(2*m+2*k, m) / (m+k)	1225	explicitformula
2998	T	2*k **2 * binomial(2*m+2*k, m) * (-1)**(n-1) * binomial(3*n-2*k-1,n-1) / ((m+k)*n)	1225	explicitformula
2999	U	((1-(4*(sin((asin((3^((3)/(2))*sqrt(-x))/(2)))/(3))^(2)))/(3))^(2))/(sqrt(1-4*y))	1226	generatingfunction
3000	T	TA984(m, k) * TLeftA271825(n, 2*k)	1226	explicitformula
3001	U	((1-sqrt(1-(4*x)/(1-y)))^3*(1-y)^2)/(8*x^3)	1227	generatingfunction
3002	T	3*k*binomial(n+m+k-1, m) * binomial(2*n+3*k, n) / (2*n+3*k)	1227	explicitformula
3003	U	(1-sqrt(1-4*x*(y+1)^2))^3/(8*x^3*(y+1)^4)	1228	generatingfunction
3004	T	(3*k*binomial(2*n+2*k,m)*binomial(2*n+3*k,n))/(2* n+3*k)	1228	explicitformula
3005	U	((1-sqrt(1-(4*x)/(1-y)^2))^3*(1-y)^4)/(8*x^3)	1229	generatingfunction
3006	T	(3*k*binomial(2*n+3*k,n)*binomial(2*n+m+2*k-1,m)) /(2*n+3*k)	1229	explicitformula
3007	U	((1-sqrt(1-(2*x*(1-sqrt(1-4*y)))/y))^3*y^2)/(2*x^ 3*(1-sqrt(1-4*y))^2)	1230	generatingfunction
3008	T	(3*k*(n+k)*binomial(n+2*m+k-1,m)*binomial(2*n+3*k ,n))/((n+m+k)*(2*n+3*k))	1230	explicitformula
3009	U	(1-sqrt(1-2*x*(sqrt(4*y+1)+1)))^3/(2*x^3*(sqrt(4* y+1)+1)^2)	1231	generatingfunction
3010	T	3*k / (2*n + 3*k) * binomial(2*n+3*k, n) * TA271825(m, n+k)	1231	explicitformula
3011	U	(1-sqrt(1-4*x*sqrt(4*y+1)))^3/(8*x^3*(4*y+1))	1232	generatingfunction
3012	T	3*k / (2*n + 3*k) * binomial(2*n+3*k, n) * Tsqrt(m, n+k)	1232	explicitformula
3013	U	((1-sqrt(1-(4*x)/sqrt(1-4*y)))^3*(1-4*y))/(8*x^3)	1233	generatingfunction
3014	T	3*k / (2*n + 3*k) * binomial(2*n+3*k, n) * TA984(m, n+k)	1233	explicitformula
3017	U	(3*(1-sqrt(1-(8*x*sin((arcsin((3^((3)/(2))*sqrt(y))/(2)))/(3)))/(sqrt(3)*sqrt(y))))^(3)*y)/(32*x^(3)*(sin((arcsin(3^((3)/(2))*(sqrt(y))/(2)))/(3)))^(2))	1235	generatingfunction
3015	U	((1-sqrt(1-4*x*(1-(4*(sin((arcsin((3^((3)/(2))*sqrt(-y))/(2)))/(3)))^(2))/(3))))^(3))/(8*x^(3)*(1-(4*(sin((arcsin((3^((3)/(2))*sqrt(-y))/(2)))/(3)))^(2))/(3))^(2))	1234	generatingfunction
3018	T	3*k * (n + k) * binomial(n+3*m+k-1, m) * binomial(2*n+3*k, n) / ((n+2*m+k)*(2*n+3*k))	1235	explicitformula
3020	T	Tsqrt(m,k) * TLeftA271825(n, 2*k)	1236	explicitformula
3019	U	((1-(4*(sin((arcsin((3^((3)/(2))*sqrt(-x))/(2)))/(3))^(2)))/(3))^(2)) * sqrt(1+4*y)	1236	generatingfunction
3021	U	(2*(1-(4*(sin((asin((3^((3)/(2))*sqrt(-x))/(2)))/(3))^(2)))/(3))^(2) * sin(arcsin(3^(3/2)*sqrt(y)/2)/3))/(sqrt(3)*sqrt(y))	1237	generatingfunction
3022	T	k/(n+k) * TLeftA271825(n, 2*k) * binomial(3*m+k-1, m)	1237	explicitformula
3023	U	(2*sin((arcsin((3^((3)/(2))*sqrt(y))/(2)))/(3))*(1+(2*x*sin((arcsin((3^((3)/(2))*sqrt(y))/(2)))/(3)))/(sqrt(3)*sqrt(y)))^(2))/(sqrt(3)*sqrt(y))	1238	generatingfunction
3024	T	(binomial(2*k,n)*(n+k)*binomial(n+3*m+k-1,m))/(n+ 2*m+k)	1238	explicitformula
3152	T	k/(2*m+k)*4^ m*binomial((4*m+k)/2-1,m)	1285	explicitformula
3025	U	(3^((3)/(2))*(1-sqrt(1-(16*x*(sin((arcsin((3^((3)/(2))*sqrt(y))/(2)))/(3))^(2)))/(3*y))-(8*x*(sin((arcsin((3^((3)/(2))*sqrt(y))/(2)))/(3)))^(2))/(3*y))*y^((3)/(2)))/(16*x^(2)*(sin((arcsin((3^((3)/(2))*sqrt(y))/(2)))/(3))^(3)))	1239	generatingfunction
3026	T	(k*(2*n+k)*binomial(2*n+2*k,n)*binomial(2*n+3*m+k -1,m))/((n+k)*(2*n+2*m+k))	1239	explicitformula
3027	U	(4*(sin((arcsin((3^((3)/(2))*sqrt(x))/(2)))/(3)))^(2)*(1+y))/(3*x)	1240	generatingfunction
3028	T	(k*binomial(k,m)*binomial(3*n+2*k-1,n))/(n+k)	1240	explicitformula
3029	U	(4*(sin((arcsin((3^((3)/(2))*sqrt(x))/(2)))/(3)))^(2)*(1+y)^(2))/(3*x)	1241	generatingfunction
3030	T	(k*binomial(2*k,m)*binomial(3*n+2*k-1,n))/(n+k)	1241	explicitformula
3031	U	(4*(sin((arcsin((3^((3)/(2))*sqrt(x))/(2)))/(3)))^(2))/(3*x*(1-y))	1242	generatingfunction
3032	T	(k*binomial(m+k-1,m)*binomial(3*n+2*k-1,n))/(n+k)	1242	explicitformula
3033	U	(4*(sin((arcsin((3^((3)/(2))*sqrt(x))/(2)))/(3)))^(2))/(3*x*(1-y)^(2))	1243	generatingfunction
3034	T	(k*binomial(m+2*k-1,m)*binomial(3*n+2*k-1,n))/(n+ k)	1243	explicitformula
3035	U	(2*(sin((arcsin((3^((3)/(2))*sqrt(x))/(2)))/(3)))^(2)*(1-sqrt(1-4*y)))/(3*x*y)	1244	generatingfunction
3036	T	(k^2*binomial(2*m+k-1,m)*binomial(3*n+2*k-1,n))/( (m+k)*(n+k))	1244	explicitformula
3037	U	(2*(sin((arcsin((3^((3)/(2))*sqrt(x))/(2)))/(3)))^(2)*(1-sqrt(1-4*y)-2*y))/(3*x*y^(2))	1245	generatingfunction
3038	T	k**2*binomial(2*m+2*k,m)*binomial(3*n+2*k-1,n)/((m+k)*(n+k))	1245	explicitformula
3039	U	(8*(sin((arcsin((3^((3)/(2))*sqrt(x))/(2)))/(3)))^(3)*(1+y))/(3^((3)/(2))*x^((3)/(2)))	1246	generatingfunction
3040	T	3*k*binomial(k,m)*binomial(3*n+3*k-1,n)/(2*n+3*k)	1246	explicitformula
3041	U	(8*(sin((arcsin((3^((3)/(2))*sqrt(x))/(2)))/(3)))^(3)*(1+y)^(2))/(3^((3)/(2))*x^((3)/(2)))	1247	generatingfunction
3042	T	3*k*binomial(2*k,m)*binomial(3*n+3*k-1,n) / (2*n+ 3*k)	1247	explicitformula
3043	U	(2*(1-cos((2*arcsin((3^((3)/(2))*sqrt(x))/(2)))/(3))))/(3*x*(1-(2*(1-cos((2*arcsin((3^((3)/(2))*sqrt(x))/(2)))/(3)))*y)/(3*x)))	1248	generatingfunction
3044	T	(k*binomial(m+k,m)*binomial(3*n+2*(m+k)-1,n))/(n+ m+k)	1248	explicitformula
3045	U	(3*x*(1-sqrt(1-(16*(1-cos((2*arcsin((3^((3)/(2))*sqrt(x))/(2)))/(3)))^(2)*y)/(9*x^(2)))))/(4*(1-cos((2*arcsin((3^((3)/(2))*sqrt(x))/(2)))/(3)))*y)	1249	generatingfunction
3046	T	k*binomial(2*m+k,m)*binomial(3*n+4*m+2*k-1,n)/( n+2*m+k)	1249	explicitformula
3047	U	(3*x*(1-(4*(1-cos((2*arcsin((3^((3)/(2))*sqrt(x))/(2)))/(3)))*y)/(3*x)-sqrt(1-(8*(1-cos((2*arcsin((3^((3)/(2))*sqrt(x))/(2)))/(3)))*y)/(3*x))))/(4*(1-cos((2*arcsin((3^((3)/(2))*sqrt(x))/(2)))/(3)))*y^(2))	1250	generatingfunction
3048	T	k*binomial(2*(m+k),m)*binomial(3*n+2*(m+k)-1,n) /(n+m+k)	1250	explicitformula
3049	U	(1-sqrt(1-(8*(1-cos((2*arcsin((3^((3)/(2))*sqrt(x))/(2)))/(3)))*y)/(3*x)))/(2*y)	1251	generatingfunction
3050	T	k*binomial(2*m+k-1,m)*binomial(3*n+2*(m+k)-1,n) /(n+m+k)	1251	explicitformula
3051	U	(2*(1-cos((2*arcsin((3^((3)/(2))*sqrt(x))/(2)))/(3))))/(3*(x+y))	1252	generatingfunction
3052	T	2*k*binomial(n+m,m)*binomial(3*(n+m)+2*k-1,n+m) /(2*(n+m)+2*k)	1252	explicitformula
3053	U	(2*sin((arcsin((3^((3)/(2))*sqrt(x*(1+y)))/(2)))/(3)))/(sqrt(3)*sqrt(x*(1+y)))	1253	generatingfunction
3054	T	k * binomial(n, m) * binomial(3 * n + k - 1,n) / (2 * n + k)	1253	explicitformula
3055	U	(2*(1-cos((2*arcsin((3^((3)/(2))*sqrt(x*(1+y)))/(2)))/(3))))/(3*x*(1+y))	1254	generatingfunction
3056	T	(k*binomial(n, m) * binomial(3*n+2*k-1,n) )/(n+k)	1254	explicitformula
3057	U	(2*sin((arcsin((3^((3)/(2))*sqrt((x)/(1-y)))/(2)))/(3)))/(sqrt(3)*sqrt((x)/(1-y)))	1255	generatingfunction
3058	T	k*binomial(n+m-1,m)*binomial(3*n+k-1,n) / (2*n+k)	1255	explicitformula
3059	U	(2*(1-cos((2*arcsin((3^((3)/(2))*sqrt((x)/(1-y)))/(2)))/(3)))*(1-y))/(3*x)	1256	generatingfunction
3060	T	k*binomial(n+m-1,m)*binomial(3*n+2*k-1,n) /(n+k)	1256	explicitformula
3061	U	(1+y)/(1-x)**2	199	generatingfunction
1330	U	((1-sqrt(1-(4*x)/(1-y)^6))*(1-y)^4)/(2*x)	547	generatingfunction
3062	T	 (k*((binomial(2* n-k-1,n-1))*(-1)^(n-1)))/n*binomial(2*k,m)	551	explicitformula
3063	T	((2*k+1)*(binomial(2*n+2*k,n-m))*(binomial(n+m+2*k+1,m)))/((binomial(n+k,m))*(n+m+2*k+1))*(binomial(m+k,k))	251	explicitformula
3065	T	(k*(-1)**(m+1)*binomial(k-2*n,n)*binomial(2*n-2*m- k-1,m-1))/m	1257	explicitformula
3064	U	(2*sin(asin((3**(3/2)*sqrt(y))/2)/3))/(3**(3/2)*sqrt(y))+(4*sin(asin((3**(3/2)*sqrt(y))/2)/3)**2)/(27*((sin(asin((3**(3/2)*sqrt(y))/2)/3)*sqrt(x*((16*sin(asin((3**(3/2)*sqrt(y))/2)/3)**2)/(3*y)+27*x)))/( 9*sqrt(y))+(x*sin(asin((3**(3/2)*sqrt(y))/2)/3))/( sqrt(3)*sqrt(y))+(8*sin(asin((3**(3/2)*sqrt(y))/2) /3)**3)/(3**(9/2)*y**(3/2)))**(1/3)*y)+((sin(asin((3**(3/2)*sqrt(y))/2)/3)*sqrt(x*((16*sin(asin((3**(3/2 )*sqrt(y))/2)/3)**2)/(3*y)+27*x)))/(9*sqrt(y))+(x* sin(asin((3**(3/2)*sqrt(y))/2)/3))/(sqrt(3)*sqrt(y ))+(8*sin(asin((3**(3/2)*sqrt(y))/2)/3)**3)/(3**(9/2 )*y**(3/2)))**(1/3)	1257	generatingfunction
3066	T	k*binomial(k-2*n-1 ,n-1)/n	484	explicitformula
3067	T	(k*((binomial(2*m+2*n-k-1,m-1))*(-1) **(m-1)))/m*binomial(k-2*n,n)	484	explicitformula
3068	T	binomial(k,n)	485	explicitformula
3069	T	(k*((binomial(2*m+ n-k-1,m-1))*(-1)**(m-1)))/m*binomial(k-1,n)	485	explicitformula
1108	T	 k*binomial(k-n-1,n-1)/n	482	explicitformula
1109	T	(k*((binomial(2*m+n-k-1,m-1))*(-1)^(m-1)))/m*binomial(k-n,n)	482	explicitformula
3070	T	1/2*(binomial(-(k-n)/2-1,m-1))*4**m*(-1)**(m-1)/m	1180	explicitformula
3071	T	 (k*4**m*(binomial((k-3*n)/2+m-1,m))*(binomial(k-2*n-1,n-1)))/(n)	1180	explicitformula
3072	U	(sin(arcsin((3^(3/2)*sqrt(x))/2)/3)*(sqrt(4*y+1)+1) )/(sqrt(3)*sqrt(x))	1258	generatingfunction
3073	T	k*(binomial(3*n+k-1,n))/(2*n+k)	1258	explicitformula
3074	T	k*(binomial(3*n+k-1,n))/(2*n+k)*(k*((binomial(2* m-k-1,m-1))*(-1)^(m-1)))/m	1258	explicitformula
1523	T	k*(binomial(2*n+k-1,n))/(n+k)	623	explicitformula
1525	T	(binomial(n+k-1,n))	624	explicitformula
1113	T	-(k*((binomial(2*m+n-k-1,m-1))*(-1)^(m-1)))/m*binomial(k-n,n)	483	explicitformula
3075	T	k *(binomial(2*n+k-1,n))/(n+k)*((k-n)*((binomial(2* m+n-k-1,m-1))*(-1)^(m-1)))/m	623	explicitformula
3078	U	 (1-(4*sin(arcsin((3^(3/2)*sqrt(-y))/2)/3)^2)/3)/(1- x)	1259	generatingfunction
3079	T	binomial(n+k-1,n)	1259	explicitformula
3080	T	binomial(n+k-1 ,n)*(k*((binomial(3*m-k-1,m-1))*(-1)^(m-1)))/m	1259	explicitformula
3096	T	(k*( (binomial(2*n-k-1,n-1))*(-1)^(n-1)))/n*binomial(2 *m+k-1,m)*k/(m+k)	553	explicitformula
1332	T	(k*binomial(2*n+k,n)*binomial(2*(n+k)+4*n+m-1,m)) /(2*n+k)	547	explicitformula
3097	T	(k*((binomial(2*n-k-1,n-1))*(-1)^(n-1)))/n*binomial(2*m+2*k,m)*k/(m+k)	554	explicitformula
3099	T	(k*(binomial(2*( k-4*n),m))*(binomial(k-n-1,n-1)))/(n)	566	explicitformula
3076	T	(binomial(n+ k-1,n))*((k-2*n)*((binomial(2*m+2*n-k-1,m-1))*(-1 )^(m-1)))/m	624	explicitformula
1545	T	k*((binomial(k-n-1,n-1)/n))*binomial(m+(k-4*n)/2-1,m)*4^m	630	explicitformula
3081	U	(-(4*sin(asin((3^(3/2)*sqrt(-y))/2)/3)^2)/3)+x+1	1260	generatingfunction
3082	T	binomial(k,n)	1260	explicitformula
3083	T	 binomial(k,n)*((k-n)*((binomial(3*m+n-k-1,m-1))*(-1)^(m-1)))/m	1260	explicitformula
3084	U	 (1-(4*sin(asin((3^(3/2)*sqrt(-y))/2)/3)^2)/3)/(1- x)^2	1261	generatingfunction
3085	T	 binomial(n+2*k-1,n)	1261	explicitformula
3086	T	 binomial(n+2 *k-1,n)*(k*((binomial(3*m-k-1,m-1))*(-1)^(m-1)))/m	1261	explicitformula
3088	T	 k/(n+k)*binomial(2*n+2*k,n)	1262	explicitformula
3089	T	 k/(n +k)*binomial(2*n+2*k,n)*(k*((binomial(3*m-k-1,m-1 ))*(-1)^(m-1)))/m	1262	explicitformula
3130	U	(y+1)^3*sqrt(4*x^2*(y+1)^4+1)+2*x*(y+1)^5	1279	generatingfunction
3087	U	 (((-2*x)-sqrt(1-4*x)+1)*(1-(4*sin(arcsin((3^(3/2)*sqrt(-y))/2)/3)^2)/3))/(2*x^2)	1262	generatingfunction
3090	U	((1-(4*sin(arcsin((3^(3/2)*sqrt(-y))/2)/3)^2)/3)^2+ 2*x*(1-(4*sin(arcsin((3^(3/2)*sqrt(-y))/2)/3)^2)/3) +x^2)/(1-(4*sin(arcsin((3^(3/2)*sqrt(-y))/2)/3)^2)/ 3)	1263	generatingfunction
3091	T	binomial(2*k,n)	1263	explicitformula
3092	T	binomial(2*k,n)* ((k-n)*((binomial(3*m+n-k-1,m-1))*(-1)^(m-1)))/m	1263	explicitformula
3093	T	 (-1)^(k+1 )*k*binomial((n-k)/2-1,n-1)*binomial(2*k-2*n,m)*4^n/(2*n)	635	explicitformula
3094	T	(-1)^(n-1)*k *binomial((n-k)/2-1,n-1)*binomial(m+2*k-2*n-1,m)* 4^n/(2*n)	638	explicitformula
3095	T	(k*((binomial (2*n-k-1,n-1))*(-1)**(n-1)))/n*binomial(m+2*k-1,m)	552	explicitformula
1356	T	 (k*(3*n+k)*binomial(2*n+k,n)*binomial(2*(2*n+k)+2 *n+2*m,m))/((2*n+k)*(3*n+m+k))	557	explicitformula
3098	T	(k*(binomial(k-4*n ,m))*(binomial(k-n-1,n-1)))/n	561	explicitformula
3101	T	(k*binomial(3*n+k,n)*binomial(6*n+3*k,m))/(3*n+k)	1265	explicitformula
3100	U	(2*sin(asin((3**(3/2)*sqrt(x)*(y+1)**3)/2)/3))/(sqrt(3)*sqrt(x))	1265	generatingfunction
3102	U	(2*sin(asin((3^(3/2)*sqrt(x)*(y+1)^4)/2)/3))/(sqrt(3)*sqrt(x))	1266	generatingfunction
3103	T	(k*binomial(4*(2*n+k),m)*binomial(3*n+k-1,n))/(2* n+k)	1266	explicitformula
3104	U	(1-sqrt(1-(4*x)/(1-4*y)**(3/2)))/(2*x)	1267	generatingfunction
3105	T	(k*4**m*binomial(2*n+k-1,n)*binomial((3*(n+k))/2+m -1,m))/(n+k)	1267	explicitformula
3106	U	(2*sin(asin((3**(3/2)*sqrt(x/(1-4*y)**3))/2)/3))/(sqrt(3)*sqrt(x/(1-4*y)**3)*(1-4*y)**(3/2))	1268	generatingfunction
3107	T	(k*4**m*binomial(3*n+k-1,n)*binomial((3*(2*n+k))/2 +m-1,m))/(2*n+k)	1268	explicitformula
3108	U	(2*sin(asin((3**(3/2)*sqrt(x/(1-4*y)))/2)/3))/(sqrt(3)*sqrt(x/(1-4*y))*sqrt(1-4*y))	1269	generatingfunction
3109	T	(k*4**m*binomial(3*n+k-1,n)*binomial((2*n+k)/2+m-1 ,m))/(2*n+k)	1269	explicitformula
3110	U	(2*sin(asin((3**(3/2)*sqrt(x)*(1-sqrt(1-4*y)))/(4* y))/3))/(sqrt(3)*sqrt(x))	1270	generatingfunction
3111	T	(k*binomial(2*n+2*m+k-1,m)*binomial(3*n+k-1,n))/( 2*n+m+k)	1270	explicitformula
3112	U	(2*sin(asin((3**(3/2)*sqrt(x)*((-2*y)-sqrt(1-4*y)+1))/(4*y**2))/3))/(sqrt(3)*sqrt(x))	1271	generatingfunction
3113	T	(k*binomial(3*n+k-1,n)*binomial(4*n+2*m+2*k,m))/( 2*n+m+k)	1271	explicitformula
3114	U	(2*sin(asin((3**(3/2)*sqrt(x)*(1-sqrt(1-4*y))**3)/( 16*y**3))/3))/(sqrt(3)*sqrt(x))	1272	generatingfunction
3115	T	(3*k*binomial(3*n+k-1,n)*binomial(6*n+2*m+3*k-1,m ))/(6*n+m+3*k)	1272	explicitformula
3116	U	(2*sin(asin((3^(3/2)*sqrt(x/(1-y)^3))/2)/3))/(sqrt(3)*sqrt(x/(1-y))*(1-y))	1273	generatingfunction
3117	T	(k*binomial(3*n+k-1,n)*binomial(3*n+m+3*k-1,m))/( 2*n+k)	1273	explicitformula
3118	U	(2*sin(asin((3^(3/2)*sqrt(x))/2)/3))/(sqrt(3)*sqrt(x)*(1-y)^3)	1274	generatingfunction
3119	T	(k*binomial(m+3*k-1,m)*binomial(3*n+k-1,n))/(2*n+ k)	1274	explicitformula
3120	U	((1-sqrt(1-4*x))^3*((-2*y)-sqrt(1-4*y)+1)^2)/(32*x^3*y^4)	1275	generatingfunction
3121	T	(6*k^2*binomial(2*m+4*k,m)*binomial(2*n+3*k-1,n)) /((m+2*k)*(n+3*k))	1275	explicitformula
3122	U	((-sqrt(1-4*x*(y+1)))-2*x*(y+1)+1)/(2*x^2*(y+1)^2)	1276	generatingfunction
3123	T	(k*binomial(n,m)*binomial(2*n+2*k,n))/(n+k)	1276	explicitformula
3124	U	(2*((-(x*(1-sqrt(1-4*y)))/y)-sqrt(1-(2*x*(1-sqrt( 1-4*y)))/y)+1)*y^2)/(x^2*(1-sqrt(1-4*y))^2)	1277	generatingfunction
3126	U	((1-sqrt(1-(4*x)/(1-y)^2))^3*(1-y)^4)/(8*x^3)	1278	generatingfunction
3131	T	binomial(2*n+3*k,m)/(2*n+k)*(-1)^(n-k)*binomial(2*n,n)*bi nomial(n,k)/binomial(2*n,2*k)	1279	explicitformula
3128	T	binomial(3*k,m)*(-1)^(n-(k+1/2))*binomial(2*n,n)*binomial(n,(k+1/2))/binomial(2*n,2*(k+1/2))	1278	explicitformula
3132	T	binomial(2*n+3*k,m)/(2*n+k)*binomial(2*k,2 *n)*binomial(2*n,n)/binomial(k,n)	1279	explicitformula
3133	U	((x+1)^2*sqrt((1-sqrt(1-16*y))/y))/2^(3/2)	1280	generatingfunction
3134	T	1	1280	explicitformula
3127	T	binomial(3*k,m)*binomial(k/2,n)*4^n	1278	explicitformula
3129	T	binomial(3*k,m)*binomial(2*(k+1/2),2*n)*binomial(2*n,n)/binomial((k+1/2),n)	1278	explicitformula
3136	T	k/(2*m+k)*((binomial ((4*m+k-1)/2,m))*(binomial(4*m+k-1,(4*m+k-1)/2))) /binomial(2*m+k-1,(2*m+k-1)/2)	1280	explicitformula
3135	T	k/(2*m+k)*4**m* binomial((4*m+k)/2-1,m)	1280	explicitformula
3137	U	(x+1)*(sin(asin(216*y^2-1)/3)/(6*y)+1/(12*y))	1281	generatingfunction
3138	T	1	1281	explicitformula
3139	T	k/(m+k)*4^m*binomial((3*m+k)/2-1,m)	1281	explicitformula
3140	T	k/(m+k)*((binomial((3*m+k-1)/2,m))*(binomial(3*m+k-1,(3*m+k-1)/2)))/binomial(m+k-1,(m+k-1)/2)	1281	explicitformula
3141	U	((-sqrt(1-4*x*(y+1)))-2*x*(y+1)+1)^2/(4*x^4*(y+1)^4)	1282	generatingfunction
3142	T	(2*k*binomial(n,m)*binomial(2*n+4*k,n))/(n+2*k)	1282	explicitformula
3150	U	sqrt((1-sqrt(1-16*y))/y)/(2^(3/2)*(1-x))	1285	generatingfunction
1527	T	((k-3*n)*((binomial(2*m+3*n-k-1,m-1))*(-1)^(m-1)) )/m	625	explicitformula
3143	U	(64*((-(x*((-2*y)-sqrt(1-4*y)+1)^2)/(2*y^4))-sqrt(1-(x*((-2*y)-sqrt(1-4*y)+1)^2)/y^4)+1)^2*y^16)/(x^4*((-2*y)-sqrt(1-4*y)+1)^8)	1283	generatingfunction
3144	T	(4*k*n*binomial(2*n+4*k,n)*binomial(4*n+2*m,m))/( (n+2*k)*(2*n+m))	1283	explicitformula
3145	T	0	1283	explicitformula
3146	U	sqrt(4*x+1)*(y+1)^3	1284	generatingfunction
3147	T	1	1284	explicitformula
3148	T	k/(m+k)*4^m*binomial((3*m +k)/2-1,m)	1284	explicitformula
3149	T	k/(m+k)*((binomial((3*m+k-1)/2,m) )* (binomial(3*m+k-1,(3*m+k-1)/2)))/binomial(m+k- 1,(m+k-1)/2)	1284	explicitformula
3154	U	(sin(asin(216*y^2-1)/3)/(6*y)+1/(12*y))/(1-x)	1286	generatingfunction
3155	T	1	1286	explicitformula
3156	T	k/(m+k)*4^m*binomial((3*m+k )/2-1,m)	1286	explicitformula
3157	T	k/(m+k)*((binomial((3*m+k-1)/2,m))* (binomial(3*m+k-1,(3*m+k-1)/2)))/binomial(m+k-1, (m+k-1)/2)	1286	explicitformula
3158	U	(1-x-sqrt(1-2*x+x^2-4*y)-2*y)/(2*x*y+2*y^2)	1287	generatingfunction
3159	T	(k*binomial(n+m+k-1,n)*binomial(n+2*(m+k),m))/(m+ k)	1287	explicitformula
3160	U	x+y+y^2	1288	generatingfunction
3161	T	binomial(k,n)*binomial(k-n,n+m-k)	1288	explicitformula
3170	U	1/(1-y)^2*2/sqrt(3*x)*sin(1/3*asin(sqrt(27*x/(1-y)^2/4)))	1293	generatingfunction
3171	T	(k*(binomial(3*n+k-1,n)))/(2*n+k)*binomial(m+2*n+3*k-1,m)	1293	explicitformula
3174	U	 ((1-sqrt(1-4*y))*(y+x))/(2*y)	1295	generatingfunction
3181	U	 ((-sqrt(16*y**2+sqrt(1-4*y)*(16*x*y-4*x)-8*y+1))-4*y-2*x*sqrt(1-4*y)+1)/(2*x**2)	1298	generatingfunction
3184	U	1/(1-x/sqrt(1-4*y))**2	1299	generatingfunction
3217	U	 (2*sin(asin((3**(3/2)*sqrt(x/sqrt(1-4*y)))/2)/3))/ (sqrt(3)*sqrt(x/sqrt(1-4*y))*sqrt(1-4*y))	1312	generatingfunction
3218	T	(binomial(3*n+k-1,n))/(2*n+k)*((binomial(m+k/2,m))*(binomial(2*m+k,m+k/2)))/(binomial(k, k/2))	1312	explicitformula
3222	T	(binomial(3*n+k-1,n))*k/(2*n+k)*((binomial(m+(k-1)/2,m))*(binomial(2*m+(k-1),m+(k-1)/2)))/(binomial((k-1),(k-1)/2))	1313	explicitformula
1907	T	(binomial(2*n+k-1,n))*k/(n+k)*((binomial(m+(k-1)/2,m))*(binomial(2*m+(k-1),m+(k-1)/2)))/(binomial((k-1),(k-1)/2))	779	explicitformula
3223	T	(binomial(2*n+k-1,n))*k/(n+k)*((binomial(m+k/2,m))*(binomial(2*m+k,m+k/2)))/(binomial(k, k/2))	779	explicitformula
3228	T	(2*k*binomial(k,m)*(-1)**(n-1)*binomial(2*n-2*k-1, n-1))/n	786	explicitformula
3182	T	binomial(2*k+2*n,n)*k/(n+k)*((binomial(m+k/2,m))*(binomial(2*m+k,m+k/2)))/(binomial(k, k/2))	1298	explicitformula
3183	T	binomial(2*k+2*n,n)*k/(n+k)*((binomial(m+(k-1)/2,m))*(binomial(2*m+(k-1),m+(k-1)/2)))/(binomial((k-1),(k-1)/2))	1298	explicitformula
3185	T	binomial(n+2*k-1,n)*(binomial(m+k/2,m))*(binomial(2*m+k,n+k/2))/(binomial(k,k/2))	1299	explicitformula
3186	T	binomial(n+2*k-1,n)*(binomial(m+(k-1)/2,m))*(binomial(2*m+k-1,m+(k-1)/2))/(binomial(k-1,(k-1)/2))	1299	explicitformula
1829	T	binomial(k,n)*binomial(4*k-3*n,m)	740	explicitformula
3190	U	((-sqrt(9*y**2-8*3**(3/2)*x*sin(asin((3**(3/2)*sqrt(y))/2)/3)*y**(3/2)))+3*y-4*sqrt(3)*x*sin(asin((3**( 3/2)*sqrt(y))/2)/3)*sqrt(y))/(8*x**2*sin(asin((3**(3/2)*sqrt(y))/2)/3)**2)	1301	generatingfunction
3199	U	 (2*sin(asin((3^(3/2)*sqrt(x))/(2*(1-y)))/3)*(1-y) )/(sqrt(3)*sqrt(x))	1305	generatingfunction
3200	T	(k*binomial(2*n+m-1,m)*binomial(3*n+k-1,n))/(2*n+ k)	1305	explicitformula
3201	U	 (2*sin(asin((3**(3/2)*sqrt(x)*(y+1))/2)/3))/(sqrt( 3)*sqrt(x)*(y+1))	1306	generatingfunction
3202	T	 (k*binomial(2*n,m)*binomial(3*n+k-1,n))/(2*n+k)	1306	explicitformula
3203	T	 (2*k*binomial(m+k-1,m)*(-1)**(n-1)*binomial(2*n-2* k-1,n-1))/n	766	explicitformula
3204	T	 (2*k*(-1)**(n+m-1)*binomial(n+m,n)*binomial(2*n-2* k-1,n+m-1))/(n+m)	767	explicitformula
3210	U	 (2*(y+1)**3*sin(asin((3**(3/2)*sqrt(x*(y+1)))/2)/3) )/(sqrt(3)*sqrt(x*(y+1)))	1309	generatingfunction
3211	T	(k*binomial(n+3*k,m)*binomial(3*n+k-1,n))/(2*n+k)	1309	explicitformula
3212	U	 (2*sin(asin((3**(3/2)*sqrt(x/(1-y)))/2)/3))/(sqrt( 3)*sqrt(x/(1-y))*(1-y)**3)	1310	generatingfunction
3213	T	 (k*binomial(n+m+3*k-1,m)*binomial(3*n+k-1,n))/(2* n+k)	1310	explicitformula
3230	U	 (2*(1-cos((2*asin((3**(3/2)*sqrt(x/(1-y)))/2))/3)) )/(3*x)	1314	generatingfunction
3231	T	 (k*binomial(n+m+k-1,m)*binomial(3*n+2*k-1,n))/(n+ k)	1314	explicitformula
3232	U	 (2*(1-cos((2*asin((3**(3/2)*sqrt(x/(1-y)))/2))/3)) )/(3*x*(1-y))	1315	generatingfunction
3233	T	(k*binomial(n+m+2*k-1,m)*binomial(3*n+2*k-1,n))/( n+k)	1315	explicitformula
3235	U	(2*(1-cos((2*asin((3**(3/2)*sqrt(x/(1-y)))/2))/3)) )/(3*x*(1-y)**2)	1316	generatingfunction
3236	T	(k*binomial(n+m+3*k-1,m)*binomial(3*n+2*k-1,n))/( n+k)	1316	explicitformula
3175	T	1	1295	explicitformula
3191	T	1	1301	explicitformula
3153	T	k/(2*m+k)*((binomial((4*m+k-1)/2,m))*(binomial(4*m+k-1,(4*m+k-1)/2) ))/binomial(2*m+k-1,(2*m+k-1)/2)	1285	explicitformula
3162	U	(2*sin(asin((3^(3/2)*sqrt(x)*(y+1)^5)/2)/3))/(sqrt(3)*sqrt(x))	1289	generatingfunction
3163	T	(k*binomial(3*n+k,n)*binomial(10*n+5*k,m))/(3*n+k)	1289	explicitformula
3164	U	1/(1-y)^2*(1+x/(1-y))^3	1290	generatingfunction
3165	T	binomial(3*k,n)*binomial(m+n+2*k-1,m)	1290	explicitformula
3166	U	2/sqrt(3*x)*sin(1/3*asin(sqrt(27*x/(1-y)^2/4)))	1291	generatingfunction
3167	T	(k*(binomial(3*n+k-1,n)))/(2*n+k)*binomial(m+2*n+k-1,m)	1291	explicitformula
3168	U	1/(1-y)*2/sqrt(3*x)*sin(1/3*asin(sqrt(27*x/(1-y)^2/4)))	1292	generatingfunction
3169	T	(k*(binomial(3*n+k-1,n)))/(2*n+k)*binomial(m+2*n+2*k-1,m)	1292	explicitformula
3172	U	(1+y)*(2*sin(asin((3^(3/2)*sqrt(x*(y+1)^2))/2)/3))/(sqrt(3)*sqrt(x*(y+1)^2))	1294	generatingfunction
3173	T	(k*(binomial(2*n+k,m))*(binomial(3*n+k-1,n)))/(2*n+k)	1294	explicitformula
3176	U	 (((-2*y)-sqrt(1-4*y)+1)*(y+x))/(2*y**2)	1296	generatingfunction
3178	U	(x/sqrt(1-4*y)+1)**2	1297	generatingfunction
3240	T	0	728	explicitformula
3221	T	(binomial(3*n+k-1,n))*k/(2*n+k)*((binomial(m+k/2,m))*(binomial(2*m+k,m+k/2)))/(binomial(k, k/2))	1313	explicitformula
3187	T	((binomial(m+(k-1)/2,m))*(binomial(2*m+k-1,m+(k-1)/2)))/(binomial(k-1,(k-1)/2))*((binomial(n+(k-1)/2,n))*(binomial(2*n+k-1,n+(k-1)/2)))/(binomial(k-1,(k-1)/2))	737	explicitformula
3188	U	 ((2*x*sin(asin((3**(3/2)*sqrt(y))/2)/3))/(sqrt(3)*sqrt(y))+1)**2	1300	generatingfunction
3192	U	 1/(1-(2*x*sin(asin((3**(3/2)*sqrt(y))/2)/3))/(sqrt(3)*sqrt(y)))**2	1302	generatingfunction
3255	U	(x/(1-y)+1)^3/(1-y)^2	1318	generatingfunction
3196	U	 (2*sin(asin((3^(3/2)*sqrt(x))/2)/3)*(y+x))/(sqrt( 3)*sqrt(x))	1304	generatingfunction
3197	T	0	1304	explicitformula
3198	T	 (k*binomial(k,m)*binomial(3*(n+m)-2*k-1,n+m-k))/(2*n+2*m-k)	1304	explicitformula
3224	T	 k*binomial(3*n+k-1,n)/(2*m+2*n +k)*4**m*binomial((4*m+2*n+k)/2-1,m)	780	explicitformula
3225	T	 binomial (3*n+k-1,n)*k/(2*m+2*n+k)*((binomial((4*m+2*n+k-1 )/2,m))*(binomial(4*m+2*n+k-1,(4*m+2*n+k-1)/2)))/ binomial(2*m+2*n+k-1,(2*m+2*n+k-1)/2)	780	explicitformula
3179	T	binomial(2*k,n)*((binomial(m+k/2,m))*(binomial(2*m+k,m+k/2)))/(binomial(k,k/2))	1297	explicitformula
3180	T	binomial(2*k,n)*((binomial(m+(k-1)/2,m))*(binomial(2*m+(k-1),m+(k-1)/2)))/(binomial(k-1,(k-1)/2))	1297	explicitformula
1875	T	 (k*binomial(n+m+4*k-1,m)*binomial(2*n+k-1,n))/(n+k)	763	explicitformula
3205	T	(2*k*binomial((-2*n)+m+3*k-1,m)*(-1)**(n-1)*binomial(2*n-2*k-1,n-1))/n	769	explicitformula
3206	U	 (2*(y+1)*sin(asin((3**(3/2)*sqrt(x*(y+1)))/2)/3))/ (sqrt(3)*sqrt(x*(y+1)))	1307	generatingfunction
3207	T	(k*binomial(n+k,m)*binomial(3*n+k-1,n))/(2*n+k)	1307	explicitformula
3208	U	(2*(y+1)**2*sin(asin((3**(3/2)*sqrt(x*(y+1)))/2)/3) )/(sqrt(3)*sqrt(x*(y+1)))	1308	generatingfunction
3209	T	(k*binomial(n+2*k,m)*binomial(3*n+k-1,n))/(2*n+k)	1308	explicitformula
1899	T	binomial(k,n)*binomial(3*k-8*n,m)	775	explicitformula
3214	U	(2*sin(asin((3**(3/2)*sqrt(x/sqrt(1-4*y)))/2)/3))/ (sqrt(3)*sqrt(x/sqrt(1-4*y)))	1311	generatingfunction
3226	T	(2*k*binomial(2*k-3*n,m)*(-1)**(n-1)*binomial(2*n-2*k-1,n-1))/n	782	explicitformula
3227	T	(2*k*binomial(3*k-5*n,m)*(-1)**(n-1)*binomial(2*n-2*k-1,n-1))/n	784	explicitformula
3229	T	(2*k*binomial(3*k-4*n,m)*(-1)**(n-1)*binomial(2*n-2*k-1,n-1))/n	788	explicitformula
3234	T	(2*k*binomial((-3*n)+m+2*k-1,m)*(-1)**(n-1)*binomial(2*n-2*k-1,n-1))/n	790	explicitformula
3215	T	(binomial(3*n+k-1,n))/(2*n+k)*((binomial(m+(k-1)/2,m))*(binomial(2*m+(k-1),m+(k-1)/2)))/(binomial((k-1),(k-1)/2))	1311	explicitformula
3216	T	(binomial(3*n+k-1,n))/(2*n+k)*((binomial(m+k/2,m))*(binomial(2*m+k,m+k/2)))/(binomial(k, k/2))	1311	explicitformula
3219	T	(binomial(3*n+k-1,n))/(2*n+k)*((binomial(m+(k-1)/2,m))*(binomial(2*m+(k-1),m+(k-1)/2)))/(binomial((k-1),(k-1)/2))	1312	explicitformula
3220	U	(2*sin(asin((3**(3/2)*sqrt(x/sqrt(1-4*y)))/2)/3))/ (sqrt(3)*sqrt(x/sqrt(1-4*y))*(1-4*y))	1313	generatingfunction
3237	T	(2*k*binomial((-5*n)+m+3*k-1,m)*(-1)**(n-1)*binomial(2*n-2*k-1,n-1))/n	792	explicitformula
2670	T	(k*binomial(2*n+m+k-1,m)*binomial(3*n+2*k-1,n))/( n+k)	1135	explicitformula
3241	T	0	730	explicitformula
3238	T	binomial(n+k-1,n)*(-1)**(n-(k+1)/2)*binomial(n,(k+1)/2)*binomial(2*n,n)/binomial(2*n,k+1)	738	explicitformula
3239	T	binomial(n+k-1,n)*binomial(k+1,2*n)*binomial(2*n,n)/binomial((k+1)/2,n)	738	explicitformula
3242	T	 (n*binomial(n+2*k-1,n)*binomial(n+2*m-1,m))/(n+m)	734	explicitformula
3125	T	1	1277	explicitformula
3243	T	 (k*n*binomial(n+2*m-1,m)*binomial(2*n+2*k,n))/((n +k)*(n+m))	1277	explicitformula
3244	T	 (k*binomial(k,n)*binomial(2*(n+m)-k-1,n+m-k))/(n+ m)	1295	explicitformula
3177	T	1	1296	explicitformula
3245	T	(k*binomial(k,n)*binomial(2*n+2*m,n+m-k))/(n+m)	1296	explicitformula
3189	T	1	1300	explicitformula
3246	T	(binomial(2*k,n)*n*binomial(n+3*m-1,m))/(n+2*m)	1300	explicitformula
3247	T	 (k*n*binomial(n+3*m-1,m)*binomial(2*n+2*k,n))/((n +k)*(n+2*m))	1301	explicitformula
3193	T	1	1302	explicitformula
3248	T	(n*binomial(n+2*k-1,n)*binomial(n+3*m-1,m))/(n+2*m)	1302	explicitformula
3249	T	2	795	explicitformula
3250	T	0	795	explicitformula
3251	T	k*binomial(2*n+k,m)*binomial(2*n+k,n)/(2*n+k)	795	explicitformula
3252	T	0	1158	explicitformula
1	U	x+y	1	generatingfunction
3259	T	(k*(-1)**(n-1)*binomial(3*n-k-1,n-1))/m	1257	explicitformula
3257	T	binomial(k-n-1,n-1)*k/(n)	1318	explicitformula
3258	T	(2*(binomial(k-n-1,n))* k*(binomial(-4*n+2*m+2*k-1,m-1)))/m	1318	explicitformula
3256	T	0	1318	explicitformula
3260	T	1	1257	explicitformula
3077	T	 binomial(k,n)	625	explicitformula
3262	T	((k-4*n)*((binomial(2* m+4*n-k-1,m-1))*(-1)^(m-1)))/m	626	explicitformula
3263	T	k*(binomial(k -n-1,n-1)/n)*((k-4*n)*((binomial(2*m+4*n-k-1,m-1) )*(-1)^(m-1)))/m	626	explicitformula
3261	T	k*(binomial(k-n-1 ,n-1))/n	626	explicitformula
3264	T	(k*(binomial(-m+k-1,n))*(binomial(n-k-1,m-1)*(-1)^(m-1)))/(m)	495	explicitformula
3267	T	1	495	explicitformula
\.


--
-- Data for Name: generatingfunction; Type: TABLE DATA; Schema: public; Owner: prog
--

COPY public.generatingfunction (id, ismain) FROM stdin;
1	t
3	t
5	t
7	t
9	t
11	t
13	t
16	t
18	t
20	t
22	t
24	t
26	t
28	t
30	t
32	t
34	t
36	t
38	t
40	t
42	t
44	t
46	t
48	t
50	t
52	t
54	t
56	t
58	t
61	t
63	t
65	t
67	t
69	t
71	t
73	t
75	t
77	t
79	t
81	t
83	t
85	t
87	t
89	t
91	t
93	t
95	t
97	t
99	t
101	t
103	t
105	t
107	t
109	t
111	t
113	t
115	t
117	t
119	t
121	t
123	t
125	t
127	t
129	t
131	t
133	t
135	t
137	t
139	t
141	t
143	t
145	t
147	t
149	t
151	t
153	t
155	t
157	t
159	t
161	t
163	t
165	t
167	t
169	t
171	t
173	t
175	t
177	t
179	t
181	t
183	t
185	t
187	t
189	t
191	t
193	t
195	t
197	t
199	t
201	t
203	t
205	t
207	t
209	t
211	t
213	t
215	t
217	t
219	t
221	t
223	t
225	t
227	t
229	t
231	t
233	t
235	t
237	t
239	t
241	t
243	t
245	t
247	t
249	t
251	t
253	t
255	t
257	t
259	t
261	t
263	t
265	t
267	t
269	t
271	t
273	t
275	t
277	t
279	t
281	t
283	t
285	t
287	t
289	t
291	t
293	t
295	t
297	t
299	t
301	t
303	t
305	t
307	t
309	t
311	t
313	t
315	t
317	t
319	t
321	t
324	t
327	t
329	t
331	t
333	t
335	t
337	t
339	t
341	t
343	t
345	t
347	t
349	t
352	t
355	t
357	t
359	t
361	t
363	t
365	t
367	t
369	t
371	t
373	t
375	t
377	t
381	t
385	t
387	t
389	t
391	t
393	t
395	t
397	t
399	t
401	t
403	t
405	t
412	t
414	t
416	t
418	t
421	t
424	t
426	t
428	t
430	t
432	t
435	t
438	t
440	t
442	t
445	t
447	t
449	t
451	t
453	t
455	t
457	t
459	t
461	t
463	t
465	t
467	t
469	t
471	t
474	t
477	t
480	t
483	t
486	t
489	t
492	t
495	t
498	t
501	t
503	t
505	t
507	t
510	t
512	t
514	t
518	t
522	t
524	t
526	t
528	t
532	t
537	t
539	t
541	t
543	t
545	t
547	t
549	t
551	t
554	t
557	t
559	t
561	t
563	t
565	t
567	t
570	t
572	t
577	t
579	t
581	t
583	t
587	t
591	t
593	t
595	t
597	t
601	t
603	t
605	t
607	t
611	t
613	t
615	t
617	t
620	t
622	t
624	t
626	t
628	t
630	t
632	t
634	t
637	t
642	t
647	t
649	t
651	t
653	t
655	t
657	t
659	t
661	t
663	t
665	t
667	t
669	t
672	t
677	t
681	t
683	t
685	t
687	t
689	t
691	t
693	t
695	t
697	t
701	t
703	t
705	t
707	t
709	t
711	t
713	t
715	t
717	t
719	t
721	t
723	t
725	t
727	t
729	t
731	t
733	t
735	t
738	t
740	t
745	t
747	t
749	t
751	t
753	t
755	t
757	t
759	t
763	t
765	t
767	t
769	t
771	t
773	t
775	t
778	t
780	t
783	t
786	t
788	t
790	t
792	t
794	t
796	t
798	t
800	t
804	t
809	t
812	t
815	t
817	t
819	t
821	t
823	t
826	t
828	t
830	t
832	t
834	t
836	t
838	t
840	t
842	t
844	t
846	t
848	t
850	t
852	t
854	t
856	t
858	t
860	t
862	t
864	t
869	t
871	t
874	t
876	t
878	t
880	t
882	t
884	t
886	t
888	t
891	t
894	t
899	t
903	t
907	t
910	t
913	t
916	t
919	t
922	t
925	t
928	t
931	t
936	t
940	t
942	t
944	t
946	t
948	t
950	t
952	t
954	t
956	t
959	t
961	t
963	t
966	t
968	t
970	t
972	t
974	t
976	t
978	t
980	t
983	t
985	t
987	t
989	t
991	t
993	t
995	t
998	t
1002	t
1004	t
1006	t
1009	t
1013	t
1015	t
1017	t
1020	t
1022	t
1024	t
1026	t
1028	t
1032	t
1035	t
1039	t
1041	t
1043	t
1045	t
1048	t
1050	t
1052	t
1054	t
1056	t
1058	t
1061	t
1063	t
1065	t
1067	t
1069	t
1072	t
1076	t
1078	t
1080	t
1082	t
1086	t
1090	t
1094	t
1097	t
1101	t
1106	t
1110	t
1115	t
1117	t
1119	t
1124	t
1129	t
1132	t
1135	t
1140	t
1143	t
1146	t
1156	t
1161	t
1166	t
1170	t
1172	t
1176	t
1181	t
1185	t
1187	t
1189	t
1194	t
1198	t
1203	t
1207	t
1209	t
1214	t
1218	t
1223	t
1227	t
1229	t
1231	t
1234	t
1237	t
1242	t
1245	t
1247	t
1249	t
1254	t
1257	t
1260	t
1263	t
1268	t
1271	t
1276	t
1279	t
1282	t
1287	t
1292	t
1295	t
1299	t
1302	t
1304	t
1306	t
1311	t
1313	t
1315	t
1317	t
1319	t
1321	t
1323	t
1325	t
1327	t
1330	t
1333	t
1336	t
1339	t
1341	t
1343	t
1345	t
1347	t
1349	t
1351	t
1354	t
1357	t
1359	t
1361	t
1363	t
1365	t
1368	t
1370	t
1372	t
1374	t
1376	t
1378	t
1381	t
1384	t
1386	t
1388	t
1390	t
1393	t
1396	t
1398	t
1401	t
1404	t
1407	t
1409	t
1412	t
1415	t
1421	t
1423	t
1425	t
1428	t
1431	t
1437	t
1440	t
1443	t
1445	t
1447	t
1450	t
1452	t
1454	t
1456	t
1459	t
1461	t
1463	t
1465	t
1468	t
1470	t
1472	t
1474	t
1477	t
1479	t
1481	t
1483	t
1486	t
1488	t
1490	t
1492	t
1494	t
1496	t
1498	t
1501	t
1503	t
1505	t
1507	t
1510	t
1513	t
1516	t
1522	t
1524	t
1526	t
1528	t
1530	t
1533	t
1539	t
1543	t
1546	t
1549	t
1552	t
1555	t
1558	t
1560	t
1565	t
1570	t
1572	t
1577	t
1582	t
1584	t
1589	t
1594	t
1597	t
1602	t
1605	t
1608	t
1613	t
1618	t
1623	t
1628	t
1631	t
1633	t
1635	t
1637	t
1643	t
1645	t
1647	t
1649	t
1652	t
1654	t
1656	t
1658	t
1660	t
1662	t
1664	t
1666	t
1668	t
1671	t
1673	t
1675	t
1678	t
1680	t
1682	t
1684	t
1686	t
1689	t
1694	t
1697	t
1699	t
1701	t
1704	t
1707	t
1712	t
1714	t
1716	t
1718	t
1720	t
1722	t
1724	t
1726	t
1728	t
1730	t
1732	t
1734	t
1736	t
1739	t
1741	t
1744	t
1746	t
1749	t
1751	t
1754	t
1756	t
1758	t
1761	t
1764	t
1766	t
1768	t
1770	t
1772	t
1774	t
1776	t
1778	t
1780	t
1782	t
1784	t
1786	t
1788	t
1790	t
1792	t
1794	t
1796	t
1798	t
1800	t
1802	t
1804	t
1806	t
1808	t
1810	t
1812	t
1814	t
1816	t
1818	t
1820	t
1822	t
1824	t
1826	t
1828	t
1830	t
1832	t
1834	t
1836	t
1838	t
1840	t
1842	t
1844	t
1846	t
1848	t
1850	t
1852	t
1854	t
1856	t
1858	t
1860	t
1862	t
1864	t
1866	t
1868	t
1870	t
1872	t
1874	t
1876	t
1878	t
1880	t
1882	t
1884	t
1886	t
1888	t
1890	t
1892	t
1894	t
1896	t
1898	t
1900	t
1902	t
1904	t
1906	t
1908	t
1910	t
1912	t
1914	t
1916	t
1918	t
1920	t
1922	t
1924	t
1926	t
1928	t
1930	t
1932	t
1934	t
1936	t
1941	t
1943	t
1946	t
1948	t
1950	t
1952	t
1954	t
1957	t
1959	t
1962	t
1964	t
1966	t
1968	t
1972	t
1975	t
1978	t
1981	t
1983	t
1985	t
1987	t
1990	t
1993	t
1996	t
1998	t
2000	t
2002	t
2004	t
2006	t
2008	t
2010	t
2012	t
2016	t
2019	t
2022	t
2025	t
2028	t
2030	t
2032	t
2034	t
2036	t
2038	t
2040	t
2042	t
2044	t
2046	t
2048	t
2051	t
2054	t
2056	t
2058	t
2060	t
2062	t
2064	t
2066	t
2068	t
2070	t
2072	t
2074	t
2076	t
2078	t
2080	t
2082	t
2084	t
2086	t
2088	t
2090	t
2092	t
2094	t
2096	t
2098	t
2100	t
2102	t
2104	t
2106	t
2108	t
2110	t
2112	t
2114	t
2116	t
2118	t
2120	t
2122	t
2124	t
2126	t
2128	t
2130	t
2132	t
2134	t
2136	t
2138	t
2140	t
2142	t
2144	t
2146	t
2148	t
2150	t
2152	t
2154	t
2156	t
2158	t
2160	t
2162	t
2164	t
2166	t
2168	t
2170	t
2172	t
2174	t
2176	t
2178	t
2180	t
2182	t
2184	t
2186	t
2188	t
2190	t
2192	t
2194	t
2196	t
2198	t
2200	t
2202	t
2204	t
2206	t
2208	t
2210	t
2212	t
2214	t
2216	t
2218	t
2220	t
2222	t
2224	t
2226	t
2228	t
2230	t
2232	t
2234	t
2236	t
2238	t
2240	t
2242	t
2244	t
2246	t
2248	t
2250	t
2252	t
2254	t
2256	t
2258	t
2260	t
2262	t
2264	t
2266	t
2268	t
2270	t
2272	t
2274	t
2276	t
2278	t
2280	t
2282	t
2284	t
2286	t
2288	t
2290	t
2292	t
2294	t
2296	t
2298	t
2300	t
2302	t
2304	t
2306	t
2308	t
2310	t
2312	t
2314	t
2316	t
2318	t
2320	t
2322	t
2324	t
2326	t
2328	t
2330	t
2332	t
2334	t
2336	t
2338	t
2340	t
2342	t
2344	t
2346	t
2348	t
2350	t
2352	t
2354	t
2356	t
2358	t
2360	t
2362	t
2364	t
2366	t
2368	t
2370	t
2372	t
2374	t
2376	t
2378	t
2380	t
2382	t
2384	t
2386	t
2388	t
2390	t
2392	t
2394	t
2396	t
2398	t
2400	t
2402	t
2404	t
2406	t
2408	t
2410	t
2412	t
2414	t
2416	t
2418	t
2420	t
2422	t
2424	t
2426	t
2428	t
2430	t
2432	t
2434	t
2436	t
2438	t
2440	t
2442	t
2444	t
2446	t
2448	t
2450	t
2452	t
2454	t
2456	t
2458	t
2460	t
2462	t
2464	t
2466	t
2468	t
2470	t
2472	t
2474	t
2476	t
2478	t
2480	t
2482	t
2484	t
2486	t
2488	t
2490	t
2492	t
2494	t
2496	t
2498	t
2500	t
2502	t
2504	t
2506	t
2508	t
2510	t
2512	t
2516	t
2520	t
2524	t
2528	t
2530	t
2534	t
2538	t
2541	t
2544	t
2547	t
2550	t
2552	t
2555	t
2557	t
2559	t
2562	t
2565	t
2567	t
2569	t
2572	t
2580	t
2582	t
2584	t
2587	t
2589	t
2591	t
2593	t
2595	t
2597	t
2599	t
2601	t
2603	t
2605	t
2607	t
2609	t
2611	t
2613	t
2615	t
2617	t
2619	t
2621	t
2623	t
2625	t
2627	t
2629	t
2631	t
2633	t
2635	t
2637	t
2639	t
2641	t
2643	t
2645	t
2647	t
2649	t
2651	t
2653	t
2655	t
2657	t
2659	t
2661	t
2663	t
2665	t
2667	t
2669	t
2671	t
2673	t
2675	t
2677	t
2679	t
2681	t
2683	t
2685	t
2687	t
2689	t
2691	t
2693	t
2696	t
2700	t
2714	t
2718	t
2720	t
2722	t
2724	t
2726	t
2728	t
2730	t
2732	t
2734	t
2738	t
2740	t
2742	t
2744	t
2746	t
2748	t
2750	t
2752	t
2755	t
2757	t
2761	t
2764	t
2766	t
2768	t
2770	t
2772	t
2774	t
2776	t
2780	t
2813	t
2816	t
2832	t
2836	t
2838	t
2857	t
2861	t
2865	t
2869	t
2897	t
2902	t
2906	t
2908	t
2910	t
2912	t
2914	t
2916	t
2918	t
2920	t
2922	t
2924	t
2926	t
2929	t
2931	t
2940	t
2942	t
2946	t
2954	t
2957	t
2961	t
2963	t
2977	t
2980	t
2983	t
2986	t
2989	t
2992	t
2994	t
2996	t
2999	t
3001	t
3003	t
3005	t
3007	t
3009	t
3011	t
3013	t
3015	t
3017	t
3019	t
3021	t
3023	t
3025	t
3027	t
3029	t
3031	t
3033	t
3035	t
3037	t
3039	t
3041	t
3043	t
3045	t
3047	t
3049	t
3051	t
3053	t
3055	t
3057	t
3059	t
3061	t
3064	t
3072	t
3078	t
3081	t
3084	t
3087	t
3090	t
3100	t
3102	t
3104	t
3106	t
3108	t
3110	t
3112	t
3114	t
3116	t
3118	t
3120	t
3122	t
3124	t
3126	t
3130	t
3133	t
3137	t
3141	t
3143	t
3146	t
3150	t
3154	t
3158	t
3160	t
3162	t
3164	t
3166	t
3168	t
3170	t
3172	t
3174	t
3176	t
3178	t
3181	t
3184	t
3188	t
3190	t
3192	t
3196	t
3199	t
3201	t
3206	t
3208	t
3210	t
3212	t
3214	t
3217	t
3220	t
3230	t
3232	t
3235	t
3255	t
\.


--
-- Data for Name: pyramid; Type: TABLE DATA; Schema: public; Owner: prog
--

COPY public.pyramid (id, sequence_number, user_id, __special_hashed_value__, data) FROM stdin;
44	1278	2	73407adb93cd6f5cac47d0932ee1c676bb067271690652fc1367cc36af1c370e	{1,6,27,110,429,1638,6188,2,24,180,1088,5814,28728,134596,5,90,945,7590,51750,315900,1781325,14,336,4536,45472,377580,2749824,18179392,42,1260,20790,249900,2447550,20727252,157373580,132,4752,92664,1298880,14661108,141604848,1214879688,429,18018,405405,6492486,82990908,900539640,8617664055}
6	1128	3	e2aa183229a50e402cbb4125650e2c0bbf3a13bc4bf6a8d533ba4a1796c36774	{None,0,0,0,0,0,0,3,12,42,144,495,1716,6006,3,24,132,624,2730,11424,46512,1,12,90,544,2907,14364,67298,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
14	1006	6	8069ac92c34d78b530156a657bec1a635e84428502a1a0afe0870957550b1e26	{1,6,27,110,429,1638,6188,1,6,27,110,429,1638,6188,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
18	1009	6	fa014a309e26a39d42a0888760b196d17b7902a919ddea44d5e4a779c8f90f75	{1,2,3,4,5,6,7,2,4,6,8,10,12,14,1,2,3,4,5,6,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
23	1013	6	f1b8327df5a99a3377814680fea2c2b8b4888bff14bcc4060595f9c7abb653cf	{1,3,9,28,90,297,1001,2,6,18,56,180,594,2002,1,3,9,28,90,297,1001,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
28	1259	2	50a0845adf7d9b739b8cd5e48f6989d6366d74ba2d2ea3a7404d3f2101a9b82f	{1,3,6,10,15,21,28,3,18,63,168,378,756,1386,6,54,270,990,2970,7722,18018,10,120,780,3640,13650,43680,123760,15,225,1800,10200,45900,174420,581400,21,378,3591,23940,125685,553014,2119887,28,588,6468,49588,297528,1487640,6446440}
34	1265	2	95b97ab3ad5aacfa3024743cc943c8271996a723f02e5463b456f1abc631131f	{1,6,27,110,429,1638,6188,3,36,270,1632,8721,43092,201894,6,108,1134,9108,62100,379080,2137590,10,240,3240,32480,269700,1964160,12985280,15,450,7425,89250,874125,7402590,56204850,21,756,14742,206640,2332449,22528044,193276314,28,1176,26460,423752,5416656,58776480,562458260}
39	1272	2	bf91074850bc315e4df9edd6f63739110eaec07cb48dac8a9a506d38a4d92b2f	{1,3,3,1,0,0,0,2,12,30,40,30,12,2,5,45,180,420,630,630,420,14,168,924,3080,6930,11088,12936,42,630,4410,19110,57330,126126,210210,132,2376,20196,107712,403920,1130976,2450448,429,9009,90090,570570,2567565,8729721,23279256}
47	1287	2	ceff1911b535b424f4e7fcfde51f6f6965dd2431a85d31b8ae1522dca788b10c	{1,3,9,28,90,297,1001,3,18,81,330,1287,4914,18564,9,81,486,2457,11340,49572,209304,28,336,2520,15232,81396,402192,1884344,90,1350,12150,85500,519750,2869020,14800500,297,5346,56133,450846,3073950,18764460,105810705,1001,21021,252252,2277275,17216199,115216101,705520816}
52	1303	2	a62c801612c908b8f9a0a9fd7eaed5ffb09d22a39c8bd859875c549da9e7e65e	{1,1,1,1,1,1,1,4,8,12,16,20,24,28,14,42,84,140,210,294,392,48,192,480,960,1680,2688,4032,165,825,2475,5775,11550,20790,34650,572,3432,12012,32032,72072,144144,264264,2002,14014,56056,168168,420420,924924,1849848}
57	1308	2	c92b491df9aa892f8c0e11414b19b41d849ea4efffd4cc4c93e77c764a159156	{1,3,9,28,90,297,1001,4,24,108,440,1716,6552,24752,14,126,756,3822,17640,77112,325584,48,576,4320,26112,139536,689472,3230304,165,2475,22275,156750,952875,5259870,27134250,572,10296,108108,868296,5920200,36138960,203783580,2002,42042,504504,4554550,34432398,230432202,1411041632}
62	1314	2	7c05445026fcb74ec8225e4ffc4c87522d216f1328481b2380278992b8f1b3c2	{1,3,3,1,0,0,0,6,36,90,120,90,36,6,27,243,972,2268,3402,3402,2268,110,1320,7260,24200,54450,87120,101640,429,6435,45045,195195,585585,1288287,2147145,1638,29484,250614,1336608,5012280,14034384,30407832,6188,129948,1299480,8230040,37035180,125919612,335785632}
70	1323	2	d55a6d3db85a3351b63c80b21b699b9f5a5408bd156de64a25c2bd0f05848ece	{1,6,27,110,429,1638,6188,6,72,540,3264,17442,86184,403788,27,486,5103,40986,279450,1705860,9619155,110,2640,35640,357280,2966700,21605760,142838080,429,12870,212355,2552550,24999975,211714074,1607458710,1638,58968,1149876,16117920,181931022,1757187432,15075552492,6188,259896,5847660,93649192,1197080976,12989602080,124303275460}
75	1330	2	ef20ddf8b41b31a3c4a248c323223ff663cf09d83539a98c73e403b483eb9a4e	{1,3,6,10,15,21,28,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
79	1334	2	a61d7fc6c1acd97d218a229f21de75cf45945e557b39f5af9db800e0887d3ce7	{1,4,10,20,35,56,84,1,2,3,4,5,6,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
84	1343	2	2d26e71e8f9f82a12d9bd1d9915491311a9f8709e7ffffba08bb1f9270e6e078	{1,4,6,4,1,0,0,1,4,6,4,1,0,0,1,4,6,4,1,0,0,1,4,6,4,1,0,0,1,4,6,4,1,0,0,1,4,6,4,1,0,0,1,4,6,4,1,0,0}
88	1348	2	170666a752403c159add54de9f9efdacf358b17484977e8bcec1eebdae60d696	{1,0,0,0,0,0,0,1,4,6,4,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
95	1016	6	e9d135eb37028e2ff10d023e052d68fb18619238f7ddada78a3d93d60e8fb295	{1,6,27,110,429,1638,6188,2,12,54,220,858,3276,12376,1,6,27,110,429,1638,6188,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
100	1021	6	d772fd4ece981f5d006784de61c3aaaa44011e9b573badac649f92c67be0b799	{1,2,3,4,5,6,7,3,6,9,12,15,18,21,3,6,9,12,15,18,21,1,2,3,4,5,6,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
105	1027	6	85fd0237ce4792637c1d211e85c06681254fc9105eeb55b81f8b9de3b893b58f	{1,4,14,48,165,572,2002,3,12,42,144,495,1716,6006,3,12,42,144,495,1716,6006,1,4,14,48,165,572,2002,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
109	1031	6	fdadd235346173eae54edc94a6291bb75c33cf7d6cd201f837f5757038fd488c	{1,3,9,28,90,297,1001,1,3,9,28,90,297,1001,1,3,9,28,90,297,1001,1,3,9,28,90,297,1001,1,3,9,28,90,297,1001,1,3,9,28,90,297,1001,1,3,9,28,90,297,1001}
114	1036	6	6c758331fcfe96148c52cc40c5708488f7808ae139580a5be2822227b5c5f39a	{1,3,9,28,90,297,1001,2,6,18,56,180,594,2002,3,9,27,84,270,891,3003,4,12,36,112,360,1188,4004,5,15,45,140,450,1485,5005,6,18,54,168,540,1782,6006,7,21,63,196,630,2079,7007}
118	1041	6	e4c05e0236d3633c8645d5e67ef8e2ff18fe179afdd992e732a3a84a76ae1e3f	{1,2,1,0,0,0,0,3,6,3,0,0,0,0,6,12,6,0,0,0,0,10,20,10,0,0,0,0,15,30,15,0,0,0,0,21,42,21,0,0,0,0,28,56,28,0,0,0,0}
123	1046	6	39ab4a4e371171b4b71463e9441fd32b97d347a92b3e41531ef9a79ccc445dc3	{1,1,2,5,14,42,132,3,3,6,15,42,126,396,6,6,12,30,84,252,792,10,10,20,50,140,420,1320,15,15,30,75,210,630,1980,21,21,42,105,294,882,2772,28,28,56,140,392,1176,3696}
128	1052	6	f37768735319164447aaaa3b9388b60b2dcc99a94f58135f47958ede29aabda6	{1,3,3,1,0,0,0,1,3,3,1,0,0,0,2,6,6,2,0,0,0,5,15,15,5,0,0,0,14,42,42,14,0,0,0,42,126,126,42,0,0,0,132,396,396,132,0,0,0}
8	1002	6	f55baac57568edf53ee29279209056e0cd94d5cc2d33a8320cf33cbe0c49825f	{1,3,3,1,0,0,0,1,3,3,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
139	14	1	b50a492ec1339e1bcfc378fcb353e10c44bfbf446edc75c9454dc3ee6820c34a	{1,1,1,1,1,1,1,1,3,6,10,15,21,28,1,6,20,50,105,196,336,1,10,50,175,490,1176,2520,1,15,105,490,1764,5292,13860,1,21,196,1176,5292,19404,60984,1,28,336,2520,13860,60984,226512}
144	19	1	ad21d56b0c32742ef31114a9924782f17f62ed3b64e6110275b0dcd2caf7704b	{1,1,1,1,1,1,1,1,2,3,4,5,6,7,1,3,6,10,15,21,28,1,4,10,20,35,56,84,1,5,15,35,70,126,210,1,6,21,56,126,252,462,1,7,28,84,210,462,924}
151	26	1	a300d79d1a06b0b52f45fd67e37eac530520cb70e56ceb77273e4bdb48ea4890	{1,0,0,0,0,0,0,1,1,0,0,0,0,0,0,3,2,0,0,0,0,0,3,10,5,0,0,0,0,1,20,35,14,0,0,0,0,20,105,126,42,0,0,0,10,175,504,462,132}
157	32	1	186c84e2dd7cc8668e708eff0519d3977957bc426cd13e7fc267ae4dceae5acd	{1,1,1,1,1,1,1,1,4,7,10,13,16,19,1,10,28,55,91,136,190,1,20,84,220,455,816,1330,1,35,210,715,1820,3876,7315,1,56,462,2002,6188,15504,33649,1,84,924,5005,18564,54264,134596}
162	37	1	cc0652ecd34f32042934f81c7e7aeb8df3330ddae6dff64ebb5735c9081a3c44	{1,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
168	43	1	f6365bc405f9e17594a9b747802b026edf081963368ae111ba56e248277a60a1	{1,1,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0}
172	47	1	43c461105fceaf0bfbad55fe6724dba0868b9d0136450610361e529815b31efc	{1,1,1,1,1,1,1,1,2,3,4,5,6,7,2,6,12,20,30,42,56,5,20,50,100,175,280,420,14,70,210,490,980,1764,2940,42,252,882,2352,5292,10584,19404,132,924,3696,11088,27720,60984,121968}
177	52	1	73c1e770c46dcfc27be7a3dbc1d349c37968967a0dce809299df1e81804bfc2c	{1,1,0,0,0,0,0,1,2,0,0,0,0,0,1,3,0,0,0,0,0,1,4,0,0,0,0,0,1,5,0,0,0,0,0,1,6,0,0,0,0,0,1,7,0,0,0,0,0}
183	58	1	eb37e45ec39490404593fa9aee41c912cd26eb2e31d4eb23ac1ba096745a0616	{1,1,0,0,0,0,0,2,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
187	62	1	1f878b9967aff744cf288895c30bfd17ac7cac2e4641c3e55682ec9c87a9a6e7	{1,1,0,0,0,0,0,1,1,0,0,0,0,0,2,2,0,0,0,0,0,5,5,0,0,0,0,0,14,14,0,0,0,0,0,42,42,0,0,0,0,0,132,132,0,0,0,0,0}
191	66	1	8f6222364e5ae9fcbb0a65ba69f3be64f3cf651b00d1c0290542bb0c169ed83c	{1,1,2,5,14,42,132,1,2,5,14,42,132,429,1,3,9,28,90,297,1001,1,4,14,48,165,572,2002,1,5,20,75,275,1001,3640,1,6,27,110,429,1638,6188,1,7,35,154,637,2548,9996}
159	34	1	13b4e2cbb100b7704c3ffb9ed4bd14430f0af80bafdd22f33a03e3ab3d840ae2	{1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
228	103	1	2d28bddb58a81e60ebc38fde41827bb0888a6f4f40c0beef685aecef085cb63e	{1,2,2,0,-2,0,4,1,4,6,0,-10,0,28,1,6,12,0,-30,0,112,1,8,20,0,-70,0,336,1,10,30,0,-140,0,840,1,12,42,0,-252,0,1848,1,14,56,0,-420,0,3696}
232	107	1	de787bed8324dbf93513139ac3aaaa6fb98bbf2f13025982c1841b8b726e00cf	{1,1,1,1,1,1,1,0,1,2,3,4,5,6,0,1,3,6,10,15,21,0,1,4,10,20,35,56,0,1,5,15,35,70,126,0,1,6,21,56,126,252,0,1,7,28,84,210,462}
244	119	1	7ae979c5718e845803667650f59bdaec6d4571e8407ba43e3253d4da753581ec	{1,1,1,1,1,1,1,2,2,2,2,2,2,2,0,-2,-2,-2,-2,-2,-2,4,4,4,4,4,4,4,-10,-10,-10,-10,-10,-10,-10,28,28,28,28,28,28,28,-84,-84,-84,-84,-84,-84,-84}
246	121	1	db507c81208215db28a832c82ed349228f65b1d6acfd8dabcb81e8b88ae302dc	{1,1,2,5,14,42,132,2,4,12,40,140,504,1848,-2,0,12,80,420,2016,9240,4,0,-8,0,280,2688,18480,-10,0,12,0,-140,0,9240,28,0,-24,0,168,0,-3696,-84,0,56,0,-280,0,3696}
252	133	1	fbd5b5ea5021d408cdb634802a7a391debc96d5c3fafe992e86076e3bec5bd96	{0,0,1,0,0,0,0,0,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
258	139	1	a1db4fdff2b2cdb34c37342c7d0386e81ae72871c252b64628595f064d8d3cba	{1,1,2,5,14,42,132,2,4,6,8,10,12,14,5,15,30,50,75,105,140,14,56,140,280,490,784,1176,42,210,630,1470,2940,5292,8820,132,792,2772,7392,16632,33264,60984,429,3003,12012,36036,90090,198198,396396}
198	73	1	81c4b35710b696fa17c8b1d6b9c441501f00f42ab0baa43c8964e0e21dc5530d	{1,2,3,4,5,6,7,1,0,0,0,0,0,0,-1,2,-1,0,0,0,0,2,-8,12,-8,2,0,0,-5,30,-75,100,-75,30,-5,14,-112,392,-784,980,-784,392,-42,420,-1890,5040,-8820,10584,-8820}
203	78	1	9c4e4ad62d7988dff21018000d121ec424ff17500ebf42e0ed21c1ff4428a5f9	{1,1,0,0,0,0,0,2,2,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
207	82	1	83d9ded2500d35cfdef0bcd34d15a7498e801c26f991923f93685db113f6cb8b	{1,1,2,5,14,42,132,2,6,20,70,252,924,3432,1,15,90,455,2142,9702,42900,0,20,240,1820,11424,64680,343200,0,15,420,5005,42840,307230,1973400,0,6,504,10010,119952,1106028,8682960,0,1,420,15015,259896,3133746,30390360}
212	87	1	18b45181d9dba5eaf3680cdc19f77627baaaa9ea6424a7a239887045eb1f9684	{4,4,4,4,4,4,4,None,5,None,None,None,None,None,None,6,None,None,None,None,None,None,7,None,None,None,None,None,None,0,None,None,None,None,None,None,1,None,None,None,None,None,None,2,None,None,None,None,None}
215	90	1	0ab5532ff07fea2b02cb341c2bbf9a830842a9113b2ff34a393e56c67410d4cb	{0,1,1,1,1,1,1,1,2,3,4,5,6,7,1,3,6,10,15,21,28,1,4,10,20,35,56,84,1,5,15,35,70,126,210,1,6,21,56,126,252,462,1,7,28,84,210,462,924}
223	98	1	d0b2ac169a063f06e912e6626e55437bff06f388666913c00558220b93ef0ae0	{1,2,3,4,5,6,7,2,6,12,20,30,42,56,3,12,30,60,105,168,252,4,20,60,140,280,504,840,5,30,105,280,630,1260,2310,6,42,168,504,1260,2772,5544,7,56,252,840,2310,5544,12012}
201	76	1	bd3fad475cb836ad81a843c02a9d519707a9a901566d4638a5207096e8f63878	{1,1,1,1,1,1,1,2,4,6,8,10,12,14,3,10,21,36,55,78,105,4,20,56,120,220,364,560,5,35,126,330,715,1365,2380,6,56,252,792,2002,4368,8568,7,84,462,1716,5005,12376,27132}
325	209	1	753d56f74d71d77de57a9969fe13a7c5914b4f042685e18c19c4d4e3f9a0f23d	{1,1,1,1,1,1,1,2,3,4,5,6,7,8,1,3,6,10,15,21,28,0,1,4,10,20,35,56,0,0,1,5,15,35,70,0,0,0,1,6,21,56,0,0,0,0,1,7,28}
264	145	1	a7dd3cee5aed64a79264bda6d85c6f809874a71b1306f8a3f9b67a16c38011cb	{0,1,0,0,0,0,0,1,2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
269	150	1	eb11f729c3d059428934cd74101c03824cf24c2b149073cb2e5f99e5882eb58e	{0,1,0,0,0,0,0,1,2,1,0,0,0,0,2,6,6,2,0,0,0,5,20,30,20,5,0,0,14,70,140,140,70,14,0,42,252,630,840,630,252,42,132,924,2772,4619,4620,2772,924}
273	154	1	d1a774408c325b9bb6e1c65a767607bd32de5306cc182c747c0fd78c4762a8f1	{1,0,0,0,0,0,0,1,3,3,1,0,0,0,1,6,15,20,15,6,1,1,9,36,84,126,126,84,1,12,66,220,495,792,924,1,15,105,455,1365,3003,5005,1,18,153,816,3060,8568,18564}
278	159	1	c7688e06b5da4ec083b77d5784a44082dd5f21a35d098d743523b59729fd6ab9	{1,1,1,1,1,1,1,0,2,4,6,8,10,12,0,3,10,21,36,55,78,0,4,20,56,120,220,364,0,5,35,126,330,715,1365,0,6,56,252,792,2002,4368,0,7,84,462,1716,5005,12376}
286	167	1	c5c062450d8a9b10754460cd031cd3aca5eb2484f06860e32a2870e662cf37f4	{1,1,1,1,1,1,1,1,3,5,7,9,11,13,0,3,10,21,36,55,78,0,1,10,35,84,165,286,0,0,5,35,126,330,715,0,0,1,21,126,462,1287,0,0,0,7,84,462,1716}
288	169	1	103253e2dd2a698c94c013e5f022b6ccaacb180eb3acb1fe6417510f54254f2f	{1,1,-1,2,-5,14,-42,1,1,-1,2,-5,14,-42,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
293	174	1	6e7ed91fa56db414865a666124532fb87c34595046b9d03b0c24b388fa219536	{1,1,0,0,0,0,0,1,3,0,0,0,0,0,0,3,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
296	177	1	4bac37f4de3a950d50a8e429b786983ee81132ab0fc7b4f638c1237cd949e330	{1,-1,0,-2,-4,-13,-42,1,-2,-1,-10,-21,-79,-297,0,-1,-1,-16,-42,-198,-892,0,0,0,-10,-42,-264,-1487,0,0,0,-2,-21,-198,-1487,0,0,0,0,-4,-79,-892,0,0,0,0,0,-13,-297}
301	183	1	636c4f7e477b080275cb9272aaeba6111f322abcc6ab108ea292dc7fb5c19aa5	{1,-1,1,-1,1,-1,1,-1,1,-1,1,-1,1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
292	173	1	f5b5ad5bcf0176113d23784c9e200bc00e4604f4bf4cc266954235cf39c4c2a8	{1,1,0,0,0,0,0,2,1,0,0,0,0,0,3,1,0,0,0,0,0,4,1,0,0,0,0,0,5,1,0,0,0,0,0,6,1,0,0,0,0,0,7,1,0,0,0,0,0}
312	196	1	1fdc9fbefc1262fcd0b4bcfed1a7ebece8a0e13cf2548113348fa96a5dc22550	{1,1,1,1,1,1,1,1,-1,-3,-5,-7,-9,-11,1,0,3,10,21,36,55,1,0,-1,-10,-35,-84,-165,1,0,0,5,35,126,330,1,0,0,-1,-21,-126,-462,1,0,0,0,7,84,462}
311	195	1	77cea4245c47856dc326ad57251b8be947378826a5f60a8130874ff6c4a48822	{-1,-1,-1,-1,-1,-1,-1,1,0,-1,-2,-3,-4,-5,-1,0,0,-1,-3,-6,-10,1,0,0,0,-1,-4,-10,-1,0,0,0,0,-1,-5,1,0,0,0,0,0,-1,-1,0,0,0,0,0,0}
93	1353	2	d9971ea742de8c01b26f53020c1e5ec2b28fefeb4a35d83d01235beb58136ca0	{1,6,30,140,630,2772,12012,1,6,30,140,630,2772,12012,1,6,30,140,630,2772,12012,1,6,30,140,630,2772,12012,1,6,30,140,630,2772,12012,1,6,30,140,630,2772,12012,1,6,30,140,630,2772,12012}
334	218	1	4fb81043082c1b9469882c0ad8dfde5b4c94298faa3f2d025e7a37288562a523	{1,2,6,20,70,252,924,1,2,6,20,70,252,924,2,4,12,40,140,504,1848,5,10,30,100,350,1260,4620,14,28,84,280,980,3528,12936,42,84,252,840,2940,10584,38808,132,264,792,2640,9240,33264,121968}
338	223	1	70e91dedefb33bb2e17e07df41043be8767bb7c6e12589cf68732cffe46459c8	{1,1,0,0,0,0,0,2,0,0,0,0,0,0,5,0,0,0,0,0,0,14,0,0,0,0,0,0,42,0,0,0,0,0,0,132,0,0,0,0,0,0,429,0,0,0,0,0,0}
343	229	1	11bdcbc83937dea938c5a4a275e3618addf367686c5c2f61a1f09d4177819e8e	{0,1,0,0,0,0,0,1,1,0,0,0,0,0,2,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
347	233	1	2d7bb8925b009027e54194f83c3f42700adbaa082c963e0d87fd8f795ace340c	{0,1,0,0,0,0,0,1,2,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
352	239	1	05f9b2fcd4472f4913c38aa64f483b53fa3cc74747db93e3e2e4862b59c49e3d	{0,1,0,0,0,0,0,1,1,0,0,0,0,0,2,1,0,0,0,0,0,3,1,0,0,0,0,0,4,1,0,0,0,0,0,5,1,0,0,0,0,0,6,1,0,0,0,0,0}
360	249	1	024de534345b2a917907c574fb3194b20c18fffea83e28b95c389dcf61e45db9	{1,0,1,0,1,0,1,1,0,2,0,3,0,4,1,0,3,0,6,0,10,1,0,4,0,10,0,20,1,0,5,0,15,0,35,1,0,6,0,21,0,56,1,0,7,0,28,0,84}
367	258	1	11b7362c807066aae3e759bad0d2de1076068243580088307d5103f66d4b7b0b	{1,1,0,0,0,0,0,1,-1,1,-1,1,-1,1,1,-1,0,2,-5,9,-14,1,-1,0,0,5,-21,56,1,-1,0,0,0,14,-84,1,-1,0,0,0,0,42,1,-1,0,0,0,0,0}
370	261	1	7ddbf1f552d76313ab28ce2d1244fa2e0aec9fe9b25084f09db20f71e489c28b	{1,2,6,20,70,252,924,None,0,0,0,0,0,0,None,0,0,0,0,0,0,None,None,0,0,0,0,0,None,None,0,0,0,0,0,None,None,None,0,0,0,0,None,None,None,0,0,0,0}
375	266	1	c3cff5b125f0ec316e30c1610423ceca707b1983114859eb5a31ff721f3a2167	{1,0,1,0,2,0,5,1,0,4,0,15,0,56,2,0,15,0,84,0,420,5,0,56,0,420,0,2640,14,0,210,0,1980,0,15015,42,0,792,0,9009,0,80080,132,0,3003,0,40040,0,408408}
386	279	1	2f6d04f52415a96b63182276e564f439b0ec7f9ae405a8709e7649c2cb52a469	{1,0,1,0,0,0,0,1,0,1,0,0,0,0,1,0,1,0,0,0,0,1,0,1,0,0,0,0,1,0,1,0,0,0,0,1,0,1,0,0,0,0,1,0,1,0,0,0,0}
363	252	1	90e64dbdcd4d9cdf28be98a2d5112379bd55a773ea34becd45ed4bfee05b0d24	{1,1,2,5,14,42,132,0,0,0,0,0,0,0,1,3,10,35,126,462,1716,0,0,0,0,0,0,0,1,6,30,140,630,2772,12012,0,0,0,0,0,0,0,1,10,70,420,2310,12012,60060}
384	277	1	ab8f789a57516b0023d7cd428f9e3de6ffc8670efb32fcbac79b62b18641bc27	{0,1,0,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
133	8	1	a8361296e1f47c1f7bbe881c885ef29bd2c837fe258e79993c45a73fe43ef36b	{0,1,1,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
398	312	1	279417251bb5a1742d2c2054a727784ed10b6bbee65bdac090bc3c072fc24db5	{1,1,1,1,1,1,1,1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
404	318	1	a21104ae6a0e55218ca20981fed2fd0a0e4d6a61363df57e575d3e1a822603e2	{1,2,3,4,5,6,7,1,-2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
416	333	1	0b42b16e603987edcce677f67fe2d759971b558689c17daff1fae246e538d294	{1,1,-1,2,-5,14,-42,1,0,0,0,0,0,0,1,-1,2,-5,14,-42,132,1,-2,5,-14,42,-132,429,1,-3,9,-28,90,-297,1001,1,-4,14,-48,165,-572,2002,1,-5,20,-75,275,-1001,3640}
421	338	1	320b7081bf459ef166483d549805715c061d503714df4eb7aa08a83a5575f164	{1,1,2,5,14,42,132,2,2,6,20,70,252,924,1,0,5,28,135,616,2730,0,-2,0,14,120,770,4368,0,-1,0,0,42,495,4004,0,0,2,0,0,132,2002,0,0,1,0,0,0,429}
425	342	1	d4217adf85d8eaefa15610bfdf7c111f6ee41b14312ffe343211535f51524c47	{None,-1,1,-10,41,-168,659,None,-2,-1,0,0,0,0,None,-1,-1,3,-15,55,-210,None,0,1,-4,15,-56,210,None,0,0,-2,9,-36,140,None,0,-2,0,3,-16,70,None,0,-5,0,0,-4,25}
436	353	1	6022ad815bdd9c4a3577018059db7003c1f7f9aa67abd166bbee63bf06b8f5d2	{1,3,6,10,15,21,28,2,0,0,0,0,0,0,1,-3,3,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
440	357	1	fed66fb55f47b1a516881ae8402fd7acfc060318db0e48e1563a9dc2ac2b576c	{1,2,1,0,0,0,0,1,2,1,0,0,0,0,1,2,1,0,0,0,0,1,2,1,0,0,0,0,1,2,1,0,0,0,0,1,2,1,0,0,0,0,1,2,1,0,0,0,0}
446	363	1	60b496c495a607c62c7ddcdecdb7dc6064cbc144cfd3cf6371f01da6802382e0	{0,0,0,0,0,0,0,None,2,-3,4,-5,6,-7,None,-6,21,-56,126,-252,462,None,20,-110,440,-1430,4004,-10010,None,-70,525,-2800,11900,-42840,135660,None,252,-2394,15960,-83790,368676,-1413258,None,-924,10626,-85008,531300,-2762760,12432420}
452	369	1	59f197a3beb00556e571860eac298c6c25b80b116d9fe5c58f76ebfbb3068314	{1,2,3,4,5,6,7,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
408	325	1	2d74df9069729ef9ed957d970ff38ed2f3e128cb84a4fb68f65883001c09b171	{1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,1,1,1,0,0,0,0,-1,-1,-1,-1,0,0,0,1,1,1,1,1,0,0,-1,-1,-1,-1,-1,-1,0,1,1,1,1,1,1,1}
414	331	1	51c27dc38cb8c9f8a5f5f43f0303441e15fb42a95887075ab15a7bd7bebb40e5	{0,0,0,0,0,0,0,0,-1,1,-1,1,-1,1,0,-1,3,-6,10,-15,21,0,-1,6,-20,50,-105,196,0,-1,10,-50,175,-490,1176,0,-1,15,-105,490,-1764,5292,0,-1,21,-196,1176,-5292,19404}
467	388	1	75ffcda5fedb8ecc03fd3e1798f91081976681975519aceac33fd4f531c2d8b1	{1,2,1,0,0,0,0,1,4,6,4,1,0,0,1,6,15,20,15,6,1,1,8,28,56,70,56,28,1,10,45,120,210,252,210,1,12,66,220,495,792,924,1,14,91,364,1001,2002,3003}
473	397	1	01b836372965ee6de1a865c1e8d13d97373ac7b18ee5b0ffaf23f6460980d173	{0,0,0,0,0,0,0,-1,0,0,0,0,0,0,1,-2,-2,-4,-10,-28,-84,-2,8,0,0,0,0,0,5,-30,30,20,30,60,140,-14,112,-224,0,0,0,0,42,-420,1260,-840,-420,-504,-840}
486	414	1	5b2a8a8a8b8a4f82df6065aa178401a4c994c884e9e51b95094de7be4623be02	{None,0,0,0,0,0,0,1,-1,2,-5,14,-42,132,-1,3,-9,28,-90,297,-1001,2,-10,40,-150,550,-2002,7280,-5,35,-175,770,-3185,12740,-49980,14,-126,756,-3822,17640,-77112,325584,-42,462,-3234,18480,-94248,447678,-2027718}
479	405	1	0dbf40677efd2e77d3e2c6cacc15df89d702ed65c80fa5519b9ea648d418d888	{1,2,5,14,42,132,429,None,0,0,0,0,0,0,None,2,1,2,5,14,42,None,-8,4,0,-2,-8,-28,None,30,-45,10,0,0,5,None,-112,280,-224,28,0,0,None,420,-1470,2100,-1050,84,0}
487	415	1	8ca25141ca0e78a9b2ceda90132a51cf322fb57cf7f317fad3568465e010e018	{0,0,0,0,0,0,0,-1,0,0,0,0,0,0,1,3,7,26,87,294,1002,-2,-10,-35,-156,-542,-2010,-7271,5,35,157,793,3158,12768,49950,-14,-126,-693,-3738,-17545,-77212,-325479,42,462,3003,18172,93901,447308,2027333}
478	403	1	07fcd4e191a9033190729d3733a76710f0274fc310f44e00dffd6f635d6e7c58	{0,0,0,0,0,0,0,1,4,14,48,165,572,2002,1,6,27,110,429,1638,6188,1,8,44,208,910,3808,15504,1,10,65,350,1700,7752,33915,1,12,90,544,2907,14364,67298,1,14,119,798,4655,24794,123970}
498	429	1	add000beb12aafe17a7923ae1b71c01dbefa054c85baec9abaf0d50bbecf939d	{1,1,0,0,0,0,0,2,4,0,0,0,0,0,3,10,0,0,0,0,0,4,20,0,0,0,0,0,5,35,0,0,0,0,0,6,56,0,0,0,0,0,7,84,0,0,0,0,0}
502	436	1	14840eb98f5c78e12652d1fdb6f6c765ccd246ed54399782a6f9e28dd181d750	{1,2,1,0,0,0,0,2,4,2,0,0,0,0,3,6,3,0,0,0,0,4,8,4,0,0,0,0,5,10,5,0,0,0,0,6,12,6,0,0,0,0,7,14,7,0,0,0,0}
507	441	1	6d2c7cb272ba29165d8b8b967874842d4d8a73716705d9cc90f2b48a2c9998f4	{0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,-1,0,0,0,0,0,-2,4,-2,0,0,0,0,5,-15,15,-5,0,0,0,-14,56,-84,56,-14,0,0,42,-210,420,-420,210,-42,0}
511	445	1	c989bcfea90466c033c31fc8f574c3f666ca8a6e18a842a6ef2ad2997f5e0420	{1,None,None,None,None,None,None,1,2,2,2,2,2,2,1,-1,-1,-1,-1,-1,-1,1,2,2,2,2,2,2,1,-5,-5,-5,-5,-5,-5,1,14,14,14,14,14,14,1,-42,-42,-42,-42,-42,-42}
516	450	1	fa96a46e354d47cca1598c2146ce528260311d51f6c07079c99a89135d37a7ab	{0,0,0,0,0,0,0,-1,2,-3,4,-5,6,-7,1,-5,15,-35,70,-126,210,-2,16,-72,240,-660,1584,-3432,5,-55,330,-1430,5005,-15015,40040,-14,196,-1470,7840,-33320,119952,-379848,42,-714,6426,-40698,203490,-854658,3133746}
457	375	1	73c9af7bf2888140f001ce83afb0f4cc60ff8803c26adb8d79b81b719a2df4a9	{1,2,6,20,70,252,924,1,0,0,0,0,0,0,1,-2,-2,-4,-10,-28,-84,1,-4,0,0,0,0,0,1,-6,6,4,6,12,28,1,-8,16,0,0,0,0,1,-10,30,-20,-10,-12,-20}
464	384	1	3d1f7cebaa60d0e05b20df95b37364cbc56723bf16987e24b9c4981b13580b3f	{0,0,0,0,0,0,0,-1,0,0,0,0,0,0,1,-1,0,0,0,0,0,-2,4,-2,0,0,0,0,5,-15,15,-5,0,0,0,-14,56,-84,56,-14,0,0,42,-210,420,-420,210,-42,0}
548	501	1	add7433dcfeaa2b7c3ea3820913cdfe99ce96af6663d2474225f2e67909f67aa	{1,1,2,5,14,42,132,1,2,5,14,42,132,429,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
552	505	1	198e0774e4fcf85c44853c93c5cc45e3acfc96c205440ea3c4d914b39466ce88	{1,2,3,4,5,6,7,1,2,3,4,5,6,7,-1,-2,-3,-4,-5,-6,-7,2,4,6,8,10,12,14,-5,-10,-15,-20,-25,-30,-35,14,28,42,56,70,84,98,-42,-84,-126,-168,-210,-252,-294}
563	517	1	db7adfa7b1c056abef3078eed79dd042bf74337c11453b09e6bcd0acbe074511	{1,2,1,0,0,0,0,1,0,0,0,0,0,0,2,-4,6,-8,10,-12,14,5,-20,50,-100,175,-280,420,14,-84,294,-784,1764,-3528,6468,42,-336,1512,-5040,13860,-33264,72072,132,-1320,7260,-29040,94380,-264264,660660}
525	460	1	5e1a40566ac29f4c2e788dc9ab4f63707e2031106217dcfe52fbb4bb397a634a	{1,1,1,1,1,1,1,None,1,0,0,0,0,0,None,1,0,0,0,0,0,None,1,0,0,0,0,0,None,1,-1,0,0,0,0,None,1,-1,1,0,0,0,None,1,-2,2,-1,0,0}
529	464	1	d82ba0bd790c9cc6108b70149085771feddee5bafb304409e7f3bf0c4de5d677	{1,1,0,0,0,0,0,0,1,0,0,0,0,0,0,-2,0,0,0,0,0,0,7,0,0,0,0,0,0,-30,0,0,0,0,0,0,143,0,0,0,0,0,0,-728,0,0,0,0,0}
534	481	1	9b1ef2bec44eab4d16a173071f5b295f8344c0f53eb46feeaceae118f8309030	{1,1,3,12,55,273,1428,2,0,0,0,0,0,0,1,-1,-2,-7,-30,-143,-728,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
540	493	1	a41219fc1f99d9f163c07e009e9c535e12bb3e78d8b32ef0d4b0e8821735ad7f	{1,2,3,4,5,6,7,1,4,10,20,35,56,84,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
545	498	1	ea2a4865cf9e96ec92b3ed69ae0020b6fa6e7ef7a7d7ebee5b9d87899dec9257	{1,1,2,5,14,42,132,1,4,14,48,165,572,2002,2,14,70,308,1274,5096,19992,5,50,325,1750,8500,38760,169575,14,182,1456,9282,51870,266266,1289288,42,672,6384,47040,297528,1700160,9041760,132,2508,27588,230736,1630200,10270260,59567508}
569	523	1	62a802a91a29d79f203bd51ccdbd7bdaa938b5082530d52e2deb53d061951b24	{0,0,0,0,0,0,0,-1,3,-3,1,0,0,0,1,-7,21,-35,35,-21,7,-2,22,-110,330,-660,924,-924,5,-75,525,-2275,6825,-15015,25025,-14,266,-2394,13566,-54264,162792,-379848,42,-966,10626,-74382,371910,-1413258,4239774}
574	528	1	2cb4a1bda2abe36527ae0eca683822511beb2a00975d218e09fd0cb30ef57003	{0,0,0,0,0,0,0,-1,6,-15,20,-15,6,-1,1,-14,91,-364,1001,-2002,3003,-2,44,-462,3080,-14630,52668,-149226,5,-150,2175,-20300,137025,-712530,2968875,-14,532,-9842,118104,-1033410,7027188,-38649534,42,-1932,43470,-637560,6853770,-57571668,393406398}
579	533	1	8cb70df3f7c7d03b3e0c83ff6f206154d48dc52c47fa2bfb6e4ed3292075f82c	{1,2,5,14,42,132,429,1,2,5,14,42,132,429,3,6,15,42,126,396,1287,12,24,60,168,504,1584,5148,55,110,275,770,2310,7260,23595,273,546,1365,3822,11466,36036,117117,1428,2856,7140,19992,59976,188496,612612}
584	540	1	1ba40fc8e610eeacd9b7d7863bc066e4a187bacb8d4ffe3ee3eeb2ba6d197284	{1,None,None,None,None,None,None,1,None,None,None,None,None,None,2,None,None,None,None,None,None,5,None,None,None,None,None,None,14,None,None,None,None,None,None,42,None,None,None,None,None,None,132,None,None,None,None,None,None}
237	112	1	2566d62261f56a90482b6e8107a52cf5d00f3247ff2aae3ddb2a589e894b5b91	{None,0,0,0,0,0,0,1,1,1,1,1,1,1,2,5,9,14,20,27,35,5,21,56,120,225,385,616,14,84,300,825,1925,4004,7644,42,330,1485,5005,14014,34398,76440,132,1287,7007,28028,91728,259896,659736}
590	552	1	aa8782e5ef0e72d4bf093ef994ae2789a39c4bba4712b1b3daeaf7789d40df2c	{1,2,1,0,0,0,0,1,6,15,20,15,6,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
594	558	1	bfa170f9de8168b64d58dd095055aa1ab9f76d5b1406a9a01391fa0daa32153e	{1,1,1,1,1,1,1,1,4,10,20,35,56,84,1,7,28,84,210,462,924,1,10,55,220,715,2002,5005,1,13,91,455,1820,6188,18564,1,16,136,816,3876,15504,54264,1,19,190,1330,7315,33649,134596}
604	571	1	e5f001e134dfccd1f3ad50a5eba475e0d68450adb502ed0267a1492e6b271b78	{1,2,5,14,42,132,429,1,4,14,48,165,572,2002,-1,-6,-27,-110,-429,-1638,-6188,2,16,88,416,1820,7616,31008,-5,-50,-325,-1750,-8500,-38760,-169575,14,168,1260,7615,40698,201096,942171,-42,-588,-4998,-33516,-195510,-1041348,-5206740}
609	577	1	8ab81a12a1e6755c84586a156baf77f13d9e9c44814137053eee63d6d1968a92	{1,2,6,20,70,252,924,1,6,30,140,630,2772,12012,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
614	584	1	aecef9b9fbf276ab7bfe2e3584a65522a2222a1c0ce2c8617a7b671b6fa77c90	{1,1,3,12,55,273,1428,1,5,25,130,700,3876,21945,2,18,126,816,5130,31878,197340,5,65,585,4550,32890,228150,1543815,14,238,2618,23800,194922,1497734,11037488,42,882,11466,119364,1093680,9236304,73785474,132,3300,49500,580800,5890500,54285660,467867400}
618	594	1	49fe3d98e2a130c7243b3e46231107b9b4736a1779c0341f5629c7167097eabd	{1,0,1,0,0,0,0,1,0,5,0,10,0,10,2,0,18,0,72,0,168,5,0,65,0,390,0,1430,14,0,238,0,1904,0,9519,42,0,882,0,8820,0,55860,132,0,3300,0,39599,0,303600}
626	604	1	362bcdadc24ac1439927e0e4d2d70ea623eb5c5b46dde2de386e6cf08f92dfd1	{1,2,6,20,70,252,924,1,-4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
633	625	1	d21cf7cf0e5b06daebbf02c17703830df56d7664ff0702d3c41fdbd3af34f5ff	{1,2,3,4,5,6,7,2,0,0,0,0,0,0,2,-4,2,0,0,0,0,0,0,0,0,0,0,0,-2,12,-30,40,-30,12,-2,0,0,0,0,0,0,0,4,-40,180,-480,840,-1008,840}
640	632	1	29fa0d010851eb9eafa95f729ad9ca3332ea36cd9108a6c2bb92a8544c7776e7	{-1,None,None,None,None,None,None,-1,2,2,2,2,2,2,-1,-2,-2,-2,-2,-2,-2,-1,0,0,0,0,0,0,-1,2,2,2,2,2,2,-1,0,0,0,0,0,0,-1,-4,-4,-4,-4,-4,-4}
645	637	1	05d86b69b9aeb1871b230febe13d09e24543bbe9197d6e532e389a2b070b31a2	{1,None,None,None,None,None,None,1,2,2,2,2,2,2,1,2,2,2,2,2,2,1,0,0,0,0,0,0,1,-2,-2,-2,-2,-2,-2,1,0,0,0,0,0,0,1,4,4,4,4,4,4}
649	644	1	5df8b29f57bcc462c8be273966836ad70281b3577dde74492572119df498f783	{1,1,-1,2,-5,14,-42,1,2,-1,2,-5,14,-42,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
320	204	1	c5d4aa144b96662b843591dfdbfc411f49cd7127046e258ca20fdd5b2585ab5d	{1,1,0,0,0,0,0,-1,2,0,0,0,0,0,0,3,0,0,0,0,0,0,4,0,0,0,0,0,0,5,0,0,0,0,0,0,6,0,0,0,0,0,0,7,0,0,0,0,0}
701	733	1	c1f1c161902c75b87eb63aa02a77b4f7509639a09cf54be9c6c53615449bac44	{1,1,1,1,1,1,1,2,4,6,8,10,12,14,1,3,6,10,15,21,28,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
708	744	1	b6c3115055aca4885154cfbf1fdb04868563f395abbb6f549df4bc8212cfe289	{1,2,1,0,0,0,0,3,12,18,12,3,0,0,6,36,90,120,90,36,6,10,80,280,560,700,560,280,15,150,675,1800,3150,3780,3150,21,252,1386,4620,10395,16632,19404,28,392,2548,10192,28028,56056,84084}
712	754	1	a68c6a15c622829b4083aa5a6946e2c466fb0dbf0e1c307b0fb65f42bfbdc763	{1,2,6,20,70,252,924,2,12,60,280,1260,5544,24024,1,6,30,140,630,2772,12012,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
654	649	1	05490c56cb7d82ba0aa5acaf3647833bfa58d9c80c3bad570a831789e2721e59	{1,1,3,12,55,273,1428,1,3,12,55,273,1428,7752,1,5,25,130,700,3876,21945,1,7,42,245,1428,8379,49588,1,9,63,408,2565,15939,98670,1,11,88,627,4235,27830,180180,1,13,117,910,6578,45630,308763}
659	662	1	824f75c4ab0099fd1f3c041f98d5930450435147672815fe0667087d32174134	{1,2,1,0,0,0,0,-1,-2,-1,0,0,0,0,1,2,1,0,0,0,0,-1,-2,-1,0,0,0,0,1,2,1,0,0,0,0,-1,-2,-1,0,0,0,0,1,2,1,0,0,0,0}
663	667	1	86b5407aa6e21d2f410a872c39faa9a1b3ba8e5141ea8fb983b13590f2c01f5d	{1,1,1,1,1,1,1,-1,-2,-3,-4,-5,-6,-7,2,6,12,20,30,42,56,-5,-20,-50,-100,-175,-280,-420,14,70,210,490,980,1764,2940,-42,-252,-882,-2352,-5292,-10584,-19404,132,924,3696,11088,27720,60984,121968}
668	672	1	c0759cb5e72377748205cd22af0dd396dc872756c5e57b55b729bccc2c627104	{1,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None}
678	682	1	c9085e59d7a591fd5edc992faee519335c1a956ce4267a7823700f9809312c4c	{1,None,None,None,None,None,None,1,1,1,1,1,1,1,1,-1,-1,-1,-1,-1,-1,1,2,2,2,2,2,2,1,-5,-5,-5,-5,-5,-5,1,14,14,14,14,14,14,1,-42,-42,-42,-42,-42,-42}
683	687	1	4a26455d4e6a6fd26172c0c40ec3ad3d9af069555ca241237a5932ab7b48ce94	{1,0,0,0,0,0,0,1,1,-2,7,-30,143,-728,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
687	697	1	398ecf2d65cb374b4b0b63195d41e44f9d46ecd8affc4163697f9fa4bec876e0	{1,0,0,0,0,0,0,1,0,0,0,0,0,0,1,4,16,64,256,1024,4096,1,4,16,64,256,1024,4096,1,8,48,256,1280,6144,28672,1,8,48,256,1280,6144,28672,1,12,96,640,3840,21504,114688}
689	719	1	ee254a0fb7aa805a5a803b6ae3ab05175ad767002261a4d866a86050953ebef1	{1,2,-2,4,-10,28,-84,1,4,0,0,0,0,0,-1,-6,-6,None,-6,12,-27,2,16,32,0,0,0,0,-5,-50,-150,-100,None,None,100,14,168,672,896,0,0,0,-42,-588,-2940,-5880,-2940,None,None}
718	774	1	d171e0e53f83dec50f868412097d5f5bf0af8af5108a09f2a4104ae9e7ba5b99	{1,1,0,0,0,0,0,2,0,0,0,0,0,0,3,-3,3,-3,3,-3,3,4,-8,12,-16,20,-24,28,5,-15,30,-50,75,-105,140,6,-24,60,-120,210,-336,504,7,-35,105,-245,490,-882,1470}
722	782	1	1de08f7af9808b4c789c93daca79c39222ee20091c04f075a29c78dbf1313682	{None,1,2,5,14,42,132,None,0,0,0,0,0,0,None,-3,-3,-6,-15,-42,-126,None,-8,-4,-8,-20,-56,-168,None,-15,0,-5,-15,-45,-140,None,-24,12,0,-6,-24,-84,None,-35,35,0,0,-7,-35}
729	801	1	1734b9cd15638d0a65f9765b6894ebb0bded1c0e9d96473f5d13a55eb1c4e5f6	{1,0,0,0,0,0,0,2,2,2,2,2,2,2,3,6,9,12,15,18,21,4,12,24,40,60,84,112,5,20,50,100,175,280,420,6,30,90,210,420,756,1260,7,42,147,392,882,1764,3234}
736	809	1	ac8e5d3681df22c71e8693f861c427b8413e5eb8b76d94ef22dc67ff59c9124a	{0,1,2,3,4,5,6,1,2,3,4,5,6,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
743	828	1	9d863317c6c1366b8c65b4ffce78f9f6af967c10475a89dde81d06942634d997	{1,0,0,0,0,0,0,1,0,0,0,0,0,0,2,1,0,0,0,0,0,5,5,1,0,0,0,0,14,21,9,1,0,0,0,42,84,56,14,1,0,0,132,330,300,120,20,1,0}
748	833	1	8af67764f914516fd6b2a94eced1dcaf736d26217c2bc74f097d9f4c41b734d1	{1,3,6,10,15,21,28,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
753	838	1	5b65fdf1e372e9086cad94d7eb2f4247074cef587b8bc8d2d4eb1761a54bd792	{1,3,6,10,15,21,28,1,8,36,120,330,792,1716,2,26,182,910,3640,12376,37128,5,90,855,5700,29925,131670,504735,14,322,3864,32200,209300,1130220,5274360,42,1176,17052,170520,1321530,8457792,46517856,132,4356,74052,863940,7775460,57538404,364409892}
760	845	1	94c10f8f4c6e91c3fb8f5c26143a1bf54a117846057a8bc4469a6d2cc9adb7c7	{1,2,3,4,5,6,7,1,1,1,1,1,1,1,1,0,0,0,0,0,0,1,-1,0,0,0,0,0,1,-2,1,0,0,0,0,1,-3,3,-1,0,0,0,1,-4,6,-4,1,0,0}
763	848	1	23e2bf54a9e7ba65e6ebfa270e388d9f1c98599ff642a7e15ed9d79101e0b304	{1,4,10,20,35,56,84,1,5,15,35,70,126,210,2,12,42,112,252,504,924,5,35,140,420,1050,2310,4620,14,112,504,1680,4620,11088,24024,42,378,1890,6930,20790,54054,126126,132,1320,7260,29040,94380,264264,660660}
768	853	1	1ef3c56f65f0bb48220a1a5ab5787a4080b021352c9fd1eb4b00e583359de128	{1,3,6,10,15,21,28,2,8,20,40,70,112,168,3,15,45,105,210,378,630,4,24,84,224,504,1008,1848,5,35,140,420,1050,2310,4620,6,48,216,720,1980,4752,10296,7,63,315,1155,3465,9009,21021}
772	858	1	eb66a8fc2169af3af2abe3cea208122767bc65099b393d49b8146deb053f830b	{1,2,1,0,0,0,0,1,-3,6,-10,15,-21,28,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
777	866	1	35baea093007c0224e691cc88296873af5c8c7fff592bb333ed665635e003690	{1,2,3,4,5,6,7,1,-1,0,0,0,0,0,1,-4,6,-4,1,0,0,1,-7,21,-35,35,-21,7,1,-10,45,-120,210,-252,210,1,-13,78,-286,715,-1287,1716,1,-16,120,-560,1820,-4368,8008}
749	834	1	448f79064213c1d053407e51ba21da2b400bf107c205d120d3ac16262736c70f	{1,4,10,20,35,56,84,1,5,15,35,70,126,210,1,6,21,56,126,252,462,1,7,28,84,210,462,924,1,8,36,120,330,792,1716,1,9,45,165,495,1287,3003,1,10,55,220,715,2002,5005}
791	896	1	290d81fc9cd0b91a476413d4b507cbda45f1909611c62afd5d49bc4a6554d1f5	{1,3,6,10,15,21,28,2,2,2,2,2,2,2,3,-3,0,0,0,0,0,4,-12,12,-4,0,0,0,5,-25,50,-50,25,-5,0,6,-42,126,-210,210,-126,42,7,-63,252,-588,882,-882,588}
794	902	1	5c15b80af4971019f19b84fe46ae7f8756535e04a93e46c280ea076524646245	{None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None}
800	908	1	9120bd753017d758f0d120701c1300ca2d1db86ee7f84e170c25019d5f44af8d	{1,1,1,1,1,1,1,2,6,12,20,30,42,56,4,24,80,200,420,784,1344,8,80,400,1400,3920,9408,20160,16,240,1680,7840,28224,84672,221760,32,672,6272,37632,169344,620928,1951488,64,1792,21504,161280,887040,3902976,14496768}
804	912	1	63fb705cc4ad78fc8582ed8f4e1192e00d66b4cc28ac262205974eb296a6f6c0	{1,2,4,8,16,32,64,1,2,4,8,16,32,64,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
808	916	1	3afd1eb7929a5e5422f98ca85905d43a73614c9dff57bf6572f677398f10b90b	{1,-1,1,-1,1,-1,1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,-2,-4,-2,0,0,0,0,-5,-15,-15,-5,0,0,0,-14,-56,-84,-56,-14,0,0,-42,-210,-420,-420,-210,-42,0}
813	939	1	e8ee466d8ba55191d16c03201866b8a00f6096f8ccdf082219f2cb7b87baa6a3	{0,0,0,0,1,0,0,0,0,0,4,1,0,0,0,0,6,4,0,0,0,0,4,6,0,0,0,0,1,4,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0}
817	943	1	5aaef1d97cd4086f587c753bf5a8b433a5064610cecf335ba168243c7d5bd08d	{0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,1,2,0,0,0,0,0,0,4,5,0,0,0,0,0,2,15,14,0,0,0,0,0,15,56,42,0,0}
822	959	1	40279ad6b2600a0ac09c6e8d72fd4cf67108eec2da0714541c3483e0b0b19e55	{1,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
826	972	1	1b7ce5709fb1d9305e696fb27d09b05e24c83372a00a3940b363b378886172d1	{1,0,0,0,0,0,0,1,1,0,0,0,0,0,-2,-4,-2,0,0,0,0,7,21,21,7,0,0,0,-30,-120,-180,-120,-30,0,0,143,715,1430,1430,715,143,0,-728,-4368,-10920,-14560,-10920,-4368,-728}
831	983	1	a0b27759ad9d9015ad93fc902c38a73111a6df5b3a5a40b26ef89b44e2eab65d	{1,-2,3,-4,5,-6,7,1,-1,1,-1,1,-1,1,1,0,0,0,0,0,0,1,1,0,0,0,0,0,1,2,1,0,0,0,0,1,3,3,1,0,0,0,1,4,6,4,1,0,0}
835	987	1	5f972230b712ea5d62444ce1925f7db45d7851536e324be1c92725f76d9686d0	{1,2,1,0,0,0,0,2,6,6,2,0,0,0,5,20,30,20,5,0,0,14,70,140,140,70,14,0,42,252,630,840,630,252,42,132,924,2772,4620,4620,2772,924,429,3432,12012,24024,30030,24024,12012}
840	995	1	a6e9e8e3382c459a3fc0c7ee1a143694b432757c09434d6f1e7090011aadcb08	{1,-1,-1,-2,-5,-14,-42,1,0,0,0,0,0,0,1,1,2,5,14,42,132,1,2,5,14,42,132,429,1,3,9,28,90,297,1001,1,4,14,48,165,572,2002,1,5,20,75,275,1001,3640}
845	1133	3	0a4eb27b1f7aedcde27f5a6b3fa65888c9c9e1cb9a0988ca6995b925d5ceaa93	{None,0,0,0,0,0,0,1,6,27,110,429,1638,6188,1,12,90,544,2907,14364,67298,1,18,189,1518,10350,63180,356265,1,24,324,3248,26970,196416,1298528,1,30,495,5950,58275,493506,3746990,1,36,702,9840,111069,1072764,9203634}
1318	427	2	01b836372965ee6de1a865c1e8d13d97373ac7b18ee5b0ffaf23f6460980d173	\N
855	1144	3	7a25f9d43561f6c0e4abf363f05014df3ef2bd0724a8ef3c8ddfef423a2329db	{1,0,0,0,0,0,0,3,6,3,0,0,0,0,6,24,36,24,6,0,0,10,60,150,200,150,60,10,15,120,420,840,1050,840,420,21,210,945,2520,4410,5292,4410,28,336,1848,6160,13860,22176,25872}
860	1149	3	a1516a94d4a6d2b5f2727dc85ca8a2c089935b4068f71eaf6e0ed3f8516eabbb	{None,0,0,0,0,0,0,3,3,6,15,42,126,396,6,12,30,84,252,792,2574,10,30,90,280,900,2970,10010,15,60,210,720,2475,8580,30030,21,105,420,1575,5775,21021,76440,28,168,756,3080,12012,45864,173264}
865	1155	3	f5f6f36f327cbb9da6112f658fc571ec7cbce8feb61dbeb89a0fdfe2add90a01	{1,0,0,0,0,0,0,1,3,6,10,15,21,28,2,12,42,112,252,504,924,5,45,225,825,2475,6435,15015,14,168,1092,5096,19110,61152,173264,42,630,5040,28560,128520,488376,1627920,132,2376,22572,150480,790020,3476088,13325004}
869	1160	3	89e13e51c38ae40c031ad29bb8fab6f2ed55e5848810d0c6912b7e9ebb971e26	{1,0,0,0,0,0,0,2,4,2,0,0,0,0,5,20,30,20,5,0,0,14,84,210,280,210,84,14,42,336,1176,2352,2940,2352,1176,132,1320,5940,15840,27720,33264,27720,429,5148,28314,94380,212355,339768,396396}
874	1166	3	4857cf860f76a7a8845feef4259823740b7b1b99896315615e04431fe9a8cc47	{None,0,0,0,0,0,0,2,8,28,96,330,1144,4004,5,40,220,1040,4550,19040,77520,14,168,1260,7616,40698,201096,942172,42,672,6384,47040,297528,1700160,9041760,132,2640,30360,264000,1930500,12540528,74760840,429,10296,138996,1393392,11570130,84262464,557068512}
879	1171	3	d35d7fcefd6e74cec60582f433a35dc57046b255fcd5f2229818331d39fe1fec	{1,0,0,0,0,0,0,3,3,3,3,3,3,3,9,18,27,36,45,54,63,28,84,168,280,420,588,784,90,360,900,1800,3150,5040,7560,297,1485,4455,10395,20790,37422,62370,1001,6006,21021,56056,126126,252252,462462}
884	1176	3	aa1ce5d5674455891d8679a16fbd0ccd286c2d7c1bda452a94a0deca2643ec26	{None,0,0,0,0,0,0,3,9,27,84,270,891,3003,9,54,243,990,3861,14742,55692,28,252,1512,7644,35280,154224,651168,90,1080,8100,48960,261630,1292760,6056820,297,4455,40095,282150,1715175,9467766,48841650,1001,18018,189189,1519518,10360350,63243180,356621265}
889	1192	3	cf66a1ed54faf0222a45a8872ec4a404aa8b8925b91e4a14f7c4499e9a9c7d8f	{1,0,0,0,0,0,0,4,4,4,4,4,4,4,14,28,42,56,70,84,98,48,144,288,480,720,1008,1344,165,660,1650,3300,5775,9240,13860,572,2860,8580,20020,40040,72072,120120,2002,12012,42042,112112,252252,504504,924924}
895	1200	3	8534461a091e45f3b442a16de302cb97e5eaa9af8cac0f47876893757b10e064	{None,0,0,0,0,0,0,4,24,108,440,1716,6552,24752,14,168,1260,7616,40698,201096,942172,48,864,9072,72864,496800,3032640,17100720,165,3960,53460,535920,4450050,32408640,214257120,572,17160,283140,3403400,33333300,282285432,2143278280,2002,72072,1405404,19699680,222360138,2147673528,18425675268}
900	1205	3	05e68114ce06287940085831a5919d6050c684e43a0f9ea4b37fcc91f01e4b6a	{1,0,0,0,0,0,0,6,12,18,24,30,36,42,27,108,270,540,945,1512,2268,110,660,2310,6160,13860,27720,50820,429,3432,15444,51480,141570,339768,736164,1638,16380,90090,360360,1171170,3279276,8198190,6188,74256,482664,2252432,8446620,27029184,76582688}
905	1211	3	c9a1136fd61ce0d9aca1bee20f1414443cf7c6a928c9772fca80b6cc729c270e	{None,0,0,0,0,0,0,6,24,84,288,990,3432,12012,27,216,1188,5616,24570,102816,418608,110,1320,9900,59840,319770,1580040,7402780,429,6864,65208,480480,3039036,17365920,92355120,1638,32760,376740,3276000,23955750,155616552,927714060,6188,148512,2004912,20098624,166890360,1215422208,8035291264}
910	1216	3	92faa997576151bf7db6f925d089768c9a671467326e9cd072d11b5a910beef8	{1,6,27,110,429,1638,6188,1,12,90,544,2907,14364,67298,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
920	1234	3	a43a60954fee0a7eebcac594c9f2c91966ee8e714fa6bbbe0e703ee800dbcc9a	{1,3,6,10,15,21,28,3,18,63,168,378,756,1386,3,27,135,495,1485,3861,9009,1,12,78,364,1365,4368,12376,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
924	1239	3	e201d570a82b2f7180ee785e1881ea9517ec4ef84f684383f555f2eb112c0337	{1,4,14,48,165,572,2002,3,24,132,624,2730,11424,46512,3,36,270,1632,8721,43092,201894,1,16,152,1120,7084,40480,215280,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
930	1245	3	b3d8910434fbdce7af0afbab12f6cc1e4d72680e9814f3b182f45b70b54de6a2	{1,2,1,0,0,0,0,2,8,12,8,2,0,0,3,18,45,60,45,18,3,4,32,112,224,280,224,112,5,50,225,600,1050,1260,1050,6,72,396,1320,2970,4752,5544,7,98,637,2548,7007,14014,21021}
934	1249	3	491aa0533f769ae00a166648bb005d9f02a734e1a150738e35e60cc697c98aa4	{1,2,5,14,42,132,429,2,8,28,96,330,1144,4004,3,18,81,330,1287,4914,18564,4,32,176,832,3640,15232,62016,5,50,325,1750,8500,38760,169575,6,72,540,3264,17442,86184,403788,7,98,833,5586,32585,173558,867790}
938	1392	5	a1aa154884ca8ef784d2d37201e70708943bac9c7f7a3094e23ae1a285495884	{1,1,0,0,0,0,0,3,4,0,0,0,0,0,6,10,0,0,0,0,0,10,20,0,0,0,0,0,15,35,0,0,0,0,0,21,56,0,0,0,0,0,28,84,0,0,0,0,0}
943	1397	5	2a821c5ab7cf1cd42a548f5818acd7d772e529df4ff70ac4edc7c2924ce2898a	{1,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
947	1401	5	cf638347040e13d599d4eceaed63348df60cef59f12baf38003ee4999f541f59	{1,1,0,0,0,0,0,2,4,0,0,0,0,0,1,6,0,0,0,0,0,0,4,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
952	1406	5	fa1ed5edd840992126cada2346b49a65b5a84e0d4f99dba60904ce9cbb08c894	{1,1,0,0,0,0,0,3,6,0,0,0,0,0,3,15,0,0,0,0,0,1,20,0,0,0,0,0,0,15,0,0,0,0,0,0,6,0,0,0,0,0,0,1,0,0,0,0,0}
956	1410	5	fcee3a32c7478e9ad9833a8800ef0eb151772f07c61fcc4aaa6ec294686aad7e	{1,2,1,0,0,0,0,1,5,10,10,5,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
961	1415	5	182ca856a79d34d149d5eebf4af6d43f248da7b4e53ee02b3d85d4c65d81cb48	{1,2,3,4,5,6,7,1,5,15,35,70,126,210,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
965	1419	5	260cdff1bbe727e67056358db8d3cb3a67c0684bafc78bd25b810a34faa86149	{1,1,1,1,1,1,1,2,5,8,11,14,17,20,3,15,36,66,105,153,210,4,35,120,286,560,969,1540,5,70,330,1001,2380,4845,8855,6,126,792,3003,8568,20349,42504,7,210,1716,8008,27132,74613,177100}
970	1424	5	b22963b23fbc2c57b4c9f3d08e8e82ac89e83e33341371e5b0d171e6602b3290	{1,3,6,10,15,21,28,2,10,30,70,140,252,420,1,7,28,84,210,462,924,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
974	1429	5	78cb80186216f0788c9df01c7e9beceedb2c4e1557434b16a0ca111fd353e572	{1,1,1,1,1,1,1,3,9,18,30,45,63,84,3,15,45,105,210,378,630,1,7,28,84,210,462,924,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
328	212	1	3c37bb0398ce3670332c9e22eb0a17637e2d880047966d29f251b836d87ca795	{1,2,6,20,70,252,924,0,2,12,60,280,1260,5544,0,2,18,120,700,3780,19404,0,2,24,200,1400,8820,51744,0,2,30,300,2450,17640,116424,0,2,36,420,3920,31752,232848,0,2,42,560,5880,52920,426888}
985	1440	5	265b9c24035b8def6a19eb7bc892f3c1f4bc3680f8956de895ef54ad4c9ecaf5	{1,1,0,0,0,0,0,2,6,6,2,0,0,0,3,15,30,30,15,3,0,4,28,84,140,140,84,28,5,45,180,420,630,630,420,6,66,330,990,1980,2772,2772,7,91,546,2002,5005,9009,12012}
994	1449	5	ade2074aa78cb16ecdc6ba0cf1149fbb5546516d14cf740de24a65e92dc8fa59	{1,1,1,1,1,1,1,2,8,20,40,70,112,168,3,21,84,252,630,1386,2772,4,40,220,880,2860,8008,20020,5,65,455,2275,9100,30940,92820,6,96,816,4896,23256,93024,325584,7,133,1330,9310,51205,235543,942172}
999	1454	5	35049cee0ff3d546f15124e366c3bf1ee8550a3eb6bb7e3260f934ceafb97844	{1,2,3,4,5,6,7,2,6,12,20,30,42,56,5,20,50,100,175,280,420,14,70,210,490,980,1764,2940,42,252,882,2352,5292,10584,19404,132,924,3696,11088,27720,60984,121968,429,3432,15444,51480,141570,339768,736164}
1004	1459	5	7a6da3be1bba9b842327ccf360909d453df3677c469032a03c92bf7e679aa557	{1,2,3,4,5,6,7,2,10,30,70,140,252,420,5,40,180,600,1650,3960,8580,14,154,924,4004,14014,42042,112112,42,588,4410,23520,99960,359856,1139544,132,2244,20196,127908,639540,2686068,9848916,429,8580,90090,660660,3798795,18234216,75975900}
1009	1056	6	875552ccc761df23e3c4f753093b4aebdebf7bfb10a6550e31437cd31722d203	{1,4,14,48,165,572,2002,1,4,14,48,165,572,2002,2,8,28,96,330,1144,4004,5,20,70,240,825,2860,10010,14,56,196,672,2310,8008,28028,42,168,588,2016,6930,24024,84084,132,528,1848,6336,21780,75504,264264}
1013	1060	6	244397f6aa2ca88394572e75f7b83d3d554ef660443a393421fa951959628922	{1,4,14,48,165,572,2002,2,8,28,96,330,1144,4004,5,20,70,240,825,2860,10010,14,56,196,672,2310,8008,28028,42,168,588,2016,6930,24024,84084,132,528,1848,6336,21780,75504,264264,429,1716,6006,20592,70785,245388,858858}
1018	1065	6	80e975589a4b54756df96300672c187d1497d29a90511ac84a8014b078543325	{1,1,1,1,1,1,1,3,3,3,3,3,3,3,9,9,9,9,9,9,9,28,28,28,28,28,28,28,90,90,90,90,90,90,90,297,297,297,297,297,297,297,1001,1001,1001,1001,1001,1001,1001}
1023	1070	6	f418afb0d3c37f7e599eb06ae800c24eb9b824185b095bdaed4aa35a78d9107b	{1,3,9,28,90,297,1001,3,9,27,84,270,891,3003,9,27,81,252,810,2673,9009,28,84,252,784,2520,8316,28028,90,270,810,2520,8100,26730,90090,297,891,2673,8316,26730,88209,297297,1001,3003,9009,28028,90090,297297,1002001}
1027	1080	6	0844cecb99234aa5f2a4bfc3f3079b457ca67a7b83a123a0844eeabc3718a301	{1,3,3,1,0,0,0,4,12,12,4,0,0,0,14,42,42,14,0,0,0,48,144,144,48,0,0,0,165,495,495,165,0,0,0,572,1716,1716,572,0,0,0,2002,6006,6006,2002,0,0,0}
1032	1085	6	8a5999742fff49b21131a73b8c7012d149f2b4067530145088acebd490ca567a	{1,2,5,14,42,132,429,4,8,20,56,168,528,1716,14,28,70,196,588,1848,6006,48,96,240,672,2016,6336,20592,165,330,825,2310,6930,21780,70785,572,1144,2860,8008,24024,75504,245388,2002,4004,10010,28028,84084,264264,858858}
1037	1091	6	cc0249f0b66a6542422981f077111d78831236d07a215da37e09f0843c13b838	{1,2,1,0,0,0,0,6,12,6,0,0,0,0,27,54,27,0,0,0,0,110,220,110,0,0,0,0,429,858,429,0,0,0,0,1638,3276,1638,0,0,0,0,6188,12376,6188,0,0,0,0}
1086	193	6	560d2a8ef1f3b1c4a296b6948d3f27b8faeeca4f327968e12c6839fcdcd6cc32	{None,1,2,5,14,42,132,1,-1,-1,-2,-5,-14,-42,-1,3,0,1,3,9,28,2,-10,10,0,0,-2,-10,-5,35,-70,35,0,0,0,14,-126,378,-420,126,0,0,-42,462,-1848,3234,-2310,462,0}
1104	1469	5	5fbd3c428320dd107a95b72c15bf2987b6a9efd02e48182638d20d1a6e096cb2	{1,3,3,1,0,0,0,1,6,15,20,15,6,1,3,27,108,252,378,378,252,12,144,792,2640,5940,9504,11088,55,825,5775,25025,75075,165165,275275,273,4914,41769,222768,835380,2339064,5067972,1428,29988,299880,1899240,8546580,29058372,77488992}
1045	1100	6	e63e8a63174c394e4e4750d203739444f0eb2937d7a4e073f6c32328e2217013	{1,4,14,48,165,572,2002,6,24,84,288,990,3432,12012,27,108,378,1296,4455,15444,54054,110,440,1540,5280,18150,62920,220220,429,1716,6006,20592,70785,245388,858858,1638,6552,22932,78624,270270,936936,3279276,6188,24752,86632,297024,1021020,3539536,12388376}
1050	1105	6	52250ab59a0541aabe24b61cd910dd2f99290b315666055ed8bea75fa3790ddd	{1,0,0,0,0,0,0,1,6,27,110,429,1638,6188,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
1054	1109	6	70751f35362c1856b1674107622edfce20c35d90d57f109d7f5b64cb195d1037	{1,0,0,0,0,0,0,2,2,2,2,2,2,2,1,2,3,4,5,6,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
1059	1114	6	393afd2276ec9235be338f27a9ca84e09bf23f5f3b02d786f6f77a89e9b04aa2	{1,0,0,0,0,0,0,2,6,18,56,180,594,2002,1,6,27,110,429,1638,6188,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
1063	1119	6	8a090a72a044a1fb61c4e81b28f582686b6b3a49dd43665b608f0cfa0bf2eb26	{1,0,0,0,0,0,0,3,6,3,0,0,0,0,3,12,18,12,3,0,0,1,6,15,20,15,6,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
1068	1124	6	dac2fab2f37e88c46b35c7c9568366fe31e09e2d364e2bb124d626e77c21d191	{1,0,0,0,0,0,0,3,3,6,15,42,126,396,3,6,15,42,126,396,1287,1,3,9,28,90,297,1001,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
1074	1049	6	037362a5b3f2b1354e9b154a6d674a0c7a5b8975090e42b8bc51d1e61992455e	{None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None}
1078	1076	6	925b4da0982c857a83a2a89f627160d38481b4da57f98d5136ced25a89711045	{1,2,1,0,0,0,0,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None}
1088	237	6	41a1459a3c37144ee2aff7ce44ab1f530bc3393a31bcdd4290970bea8cff8350	{0,1,0,0,0,0,0,1,3,0,0,0,0,0,3,6,0,0,0,0,0,6,10,0,0,0,0,0,10,15,0,0,0,0,0,15,21,0,0,0,0,0,21,28,0,0,0,0,0}
1093	486	3	bd5e9346d5852263df8ac05f4bb8fddc74d274b4b702e9f9b456eb13df68fc19	{1,1,1,1,1,1,1,None,-1,2,-9,41,-200,1031,None,-1,-2,7,-30,142,-728,None,-1,1,-5,21,-99,500,None,-1,1,-3,14,-66,333,None,-1,0,-2,8,-42,214,None,-1,0,-1,5,-25,132}
1100	538	3	87fd2b41696d389a87f3deb2128e34a7148af6c7a9c38a22190b32197cbabeca	{1,2,5,14,42,132,429,1,2,5,14,42,132,429,3,6,15,42,126,396,1287,12,24,60,168,504,1584,5148,55,110,275,770,2310,7260,23595,273,546,1365,3822,11466,36036,117117,1428,2856,7140,19992,59976,188496,612612}
1154	257	6	560d2a8ef1f3b1c4a296b6948d3f27b8faeeca4f327968e12c6839fcdcd6cc32	{1,1,-1,2,-5,14,-42,1,-1,3,-10,35,-126,462,2,-1,0,10,-70,378,-1848,5,-2,1,0,35,-420,3234,14,-5,3,0,0,126,-2310,42,-14,9,-2,0,0,462,132,-42,28,-10,0,0,0}
1111	1476	5	4e431babb6f5d58e3f832736f4c57ccf0a3f3c6a0bb82a8f8a3c48f2ce7c6868	{1,2,3,4,5,6,7,1,5,15,35,70,126,210,3,24,108,360,990,2376,5148,12,132,792,3432,12012,36036,96096,55,770,5775,30800,130900,471240,1492260,273,4641,41769,264537,1322685,5555277,20369349,1428,28560,299880,2199120,12644940,60695712,252898800}
1130	881	5	2fb512c520ebc7240916ab633ab5721ffa191fdc81d13cfb1983334d9a269763	{1,3,3,1,0,0,0,2,8,12,8,2,0,0,7,35,70,70,35,7,0,30,180,450,600,450,180,30,143,1001,3003,5005,5005,3003,1001,728,5824,20384,40768,50960,40768,20384,3876,34884,139536,325584,488376,488376,325584}
1136	900	5	f00a0c80b86dd2a886b4eb1fcb8074961dd94eda15a4beb6d3360844fb0eaedc	{1,3,6,10,15,21,28,2,10,30,70,140,252,420,7,49,196,588,1470,3234,6468,30,270,1350,4950,14850,38610,90090,143,1573,9438,40898,143143,429429,1145144,728,9464,66248,331240,1324960,4504864,13514592,3876,58140,465120,2635680,11860560,45070128,150233760}
1118	663	3	b2eb722f231908a1c99e2b8a938984b9ab1f23c25013e828da532657a9300af7	{1,2,6,20,70,252,924,1,8,48,256,1280,6144,28672,2,28,252,1848,12012,72072,408408,5,100,1200,11200,89600,645120,4300800,14,364,5460,61880,587860,4938024,37858184,42,1344,24192,322560,3548160,34062336,295206912,132,5016,105336,1615152,20189400,218045520,2107773360}
1127	870	5	463e64f4f410c73c014eb85d7249c2e2f6788d2a2a61992f2672a309c706f026	{1,3,6,10,15,21,28,1,-2,1,0,0,0,0,1,-7,21,-35,35,-21,7,1,-12,66,-220,495,-792,924,1,-17,136,-680,2380,-6188,12376,1,-22,231,-1540,7315,-26334,74613,1,-27,351,-2925,17550,-80730,296010}
1140	952	5	558604b1820408dca11fb26f9e0e1df938774b527e61506bde60fe3586c5738e	{0,1,0,0,0,0,0,1,3,0,0,0,0,0,3,3,0,0,0,0,0,3,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
1144	990	5	c2dd8e38645dc65efb19f41dd1da7a4a019eb4c8a74b9edf79bf0f063a58bd19	{1,-2,3,-4,5,-6,7,1,-1,1,-1,1,-1,1,2,0,0,0,0,0,0,5,5,0,0,0,0,0,14,28,14,0,0,0,0,42,126,126,42,0,0,0,132,528,792,528,132,0,0}
1149	922	5	471ec7b2767e736248df11f67f6f98f476701a634e80e38d39c480d9da070f57	{-2,-3,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1}
1162	290	6	659614d98dc166750f5189a4554686b8c898afafbbae114029b44a9647b766c7	{1,1,3,12,55,273,1428,1,3,12,55,273,1428,7752,2,10,50,260,1400,7752,43890,5,35,210,1225,7140,41895,247940,14,126,882,5712,35910,223146,1381380,42,462,3696,26334,177870,1168860,7567560,132,1716,15444,120120,868296,6023160,40756716}
1167	297	6	ef5aff0ffd9dd221a07be9681ac9f8d0f64629f3a85b612778df89c419148aa4	{1,1,3,12,55,273,1428,1,2,7,30,143,728,3876,2,6,24,110,546,2856,15504,5,20,90,440,2275,12240,67830,14,70,350,1820,9800,54264,307230,42,252,1386,7644,42840,244188,1413258,132,924,5544,32340,188496,1106028,6545616}
1171	304	6	a243348819632b17fa6b5e553610a6bac0586193e68bfb16442a6c005dbab2fc	{1,1,3,12,55,273,1428,1,-1,-2,-7,-30,-143,-728,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
316	200	1	31f3116bc110b3cddfd43105392030a00033cedaadd6b3a0ca6a137523998f3b	{1,1,0,0,0,0,0,-1,1,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0}
1196	371	6	494ded202c8287f10b24a39de96b724206034dd0335110b9f29ab3f29542b1fa	{0,0,0,0,0,0,0,-1,2,-1,0,0,0,0,1,-6,15,-20,15,-6,1,-2,20,-90,240,-420,504,-420,5,-70,455,-1820,5005,-10010,15015,-14,252,-2142,11424,-42840,119952,-259896,42,-924,9702,-64680,307230,-1106028,3133746}
456	374	1	dec15f5a3cbcda793b413701f5ce0c25e88a9806700486e22ae94ea2fb8cbd52	{1,1,0,0,0,0,0,1,0,0,0,0,0,0,1,-1,1,-1,1,-1,1,1,-2,3,-4,5,-6,7,1,-3,6,-10,15,-21,28,1,-4,10,-20,35,-56,84,1,-5,15,-35,70,-126,210}
1155	269	6	4b662ad59efe6418f9b20ce41e2d8f18603485e03f1e71888bcf8b579e988446	{1,2,5,14,42,132,429,2,6,20,70,252,924,3432,1,6,30,140,630,2772,12012,0,2,20,140,840,4620,24024,0,0,5,70,630,4620,30030,0,0,0,14,252,2772,24024,0,0,0,0,42,924,12012}
279	160	1	3afcf4b170e06b1683082116982a59f6d4b9f508ccbeaae9d086b27c567fe79e	{1,1,2,5,14,42,132,0,2,8,30,112,420,1584,0,3,20,105,504,2310,10296,0,4,40,280,1680,9240,48048,0,5,70,630,4620,30030,180180,0,6,112,1260,11088,84084,576576,0,7,168,2310,24024,210210,1633632}
1199	704	1	7f0c908f1ba490b395f07caf6158c8dc2560b4e8df6efa3eb508affe57b2885a	{1,1,1,1,1,1,1,2,4,6,8,10,12,14,-2,0,6,16,30,48,70,4,0,None,0,20,64,140,-10,0,6,0,None,0,70,28,0,-12,0,None,0,None,-84,0,27,0,-20,0,None}
1203	709	1	fe352d144c3da8bdbcaff23c3cb6db69b87ed7b11f39870bfb25b6cb23bc92d5	{1,0,0,0,0,0,0,1,2,-2,4,-10,28,-84,0,0,0,0,0,0,0,0,0,0,None,0,0,0,0,0,0,0,0,0,0,0,0,0,0,None,None,0,0,0,0,0,0,0,0}
1209	380	6	411139ba8ab9f8c81f91b46aae3d7527f40a23a6126aa0f370b99fcea65d3222	{1,1,0,0,0,0,0,1,0,0,0,0,0,0,-1,1,-1,1,-1,1,-1,2,-4,6,-8,10,-12,14,-5,15,-30,50,-75,105,-140,14,-56,140,-280,490,-784,1176,-42,210,-630,1470,-2940,5292,-8820}
688	718	1	49afac9758bd8c8e6b37506c5af92d9f92fb7b7e5020532ab1f758f0abd6ff6a	{1,2,-2,4,-10,28,-84,1,8,16,0,0,0,0,2,28,140,280,140,None,None,5,99,799,3199,6399,5120,0,14,364,4003,24024,84083,168167,168167,42,1344,18816,150528,752640,2408448,4816896,132,5016,85272,852720,5542680,24387792,73163376}
1215	194	6	560d2a8ef1f3b1c4a296b6948d3f27b8faeeca4f327968e12c6839fcdcd6cc32	{0,0,0,0,0,0,0,-1,1,1,2,5,14,42,1,-3,0,-1,-3,-9,-28,-2,10,-10,0,0,2,10,5,-35,70,-35,0,0,0,-14,126,-378,420,-126,0,0,42,-462,1848,-3234,2310,-462,0}
1219	741	1	a8d65919fbdbd356eafcb5160a7da3652e65e26060c212c9815145a1e60528f6	{1,1,0,0,0,0,0,3,3,0,0,0,0,0,-3,-3,0,0,0,0,0,10,10,0,0,0,0,0,-42,-42,0,0,0,0,0,198,198,0,0,0,0,0,-1001,-1001,0,0,0,0,0}
1222	747	1	560d2a8ef1f3b1c4a296b6948d3f27b8faeeca4f327968e12c6839fcdcd6cc32	{1,1,2,5,14,42,132,2,2,4,10,28,84,264,-3,-3,-6,-15,-42,-126,-396,10,10,20,50,140,420,1320,-42,-42,-84,-210,-588,-1764,-5544,198,198,396,990,2772,8316,26136,-1001,-1001,-2002,-5005,-14014,-42042,-132132}
1230	760	1	6569a0ff3cc299ef2d36014d23c3fbc6b85383bd41e9a52ac4c54453dd4dc053	{1,1,2,5,14,42,132,3,6,15,42,126,396,1287,9,27,81,252,810,2673,9009,28,112,392,1344,4620,16016,56056,90,450,1800,6750,24750,90090,327600,297,1782,8019,32670,127413,486486,1837836,1001,7007,35035,154154,637637,2550548,10005996}
1234	765	1	706a7cd15cf14900913e711905555a37fb34224cbaddb57bb1a9ac532c961337	{1,1,-2,7,-30,143,-728,3,6,-9,30,-126,594,-3003,9,27,-27,90,-378,1782,-9009,28,112,-56,224,-980,4704,-24024,90,450,0,450,-2250,11340,-59400,297,1782,891,594,-4455,24948,-137214,1001,7007,7007,0,-7007,49049,-294294}
1237	770	1	560d2a8ef1f3b1c4a296b6948d3f27b8faeeca4f327968e12c6839fcdcd6cc32	{1,3,15,84,495,3003,18564,1,3,15,84,495,3003,18564,-1,-3,-15,-84,-495,-3003,-18564,2,7,37,210,1237,7507,46410,-8,-25,-126,-705,-4158,-25225,-155937,33,99,495,2772,16335,99099,612612,-143,-429,-2145,-12012,-70785,-429429,-2654652}
1241	775	1	11bb717c0d10a2e285cb87351eb5f7e5a193697367d00174b43a52422982758a	{1,2,1,0,0,0,0,2,4,2,0,0,0,0,7,14,7,0,0,0,0,30,60,30,0,0,0,0,143,286,143,0,0,0,0,728,1456,728,0,0,0,0,3876,7752,3876,0,0,0,0}
1245	783	1	70b1db896e743eed8fd7ce1a6055857462443bc93c1531522a5f52125d210cba	{1,2,5,14,42,132,429,2,4,10,28,84,264,858,7,14,35,98,294,924,3003,30,60,150,420,1260,3960,12870,143,286,715,2002,6006,18876,61347,728,1456,3640,10192,30576,96096,312312,3876,7752,19380,54264,162792,511632,1662804}
1263	623	5	71a829a4305ce53c180df01962ffeb540789c810b09669aedbe7568d7544ab4b	{1,-1,-1,-7,-29,-143,-727,2,0,0,0,0,0,0,1,1,2,11,54,272,1427,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
1258	600	\N	5d559e2a88c8b31523e96b583a206304f79035dedf367ddea7560df65b1d8f6d	{1,-1,0,-2,-4,-13,-42,1,-1,0,-2,-4,-13,-42,3,-3,-1,-8,-12,-39,-127,12,-12,-6,-32,-51,-158,-510,55,-55,-27,-146,-233,-726,-2337,273,-273,-136,-728,-1160,-3603,-11602,1428,-1428,-714,-3808,-6069,-18849,-60690}
1262	622	5	b6565773869fac78c4f649545907819ac1ccfabcde318c254d8f448c84782bd0	{1,-1,-1,-7,-29,-143,-727,2,-2,-3,-15,-58,-287,-1454,5,-5,-7,-38,-146,-719,-3635,14,-14,-21,-107,-409,-2013,-10180,42,-42,-63,-322,-1228,-6039,-30541,132,-132,-198,-1012,-3861,-18981,-95986,429,-429,-643,-3289,-12548,-61690,-311954}
1269	1356	2	7c160b5fd7b22ca7243eee46fce0ccb8a4f09e18909a9c6920bb6cafc60ba7b3	{1,2,6,20,70,252,924,1,6,30,140,630,2772,12012,3,30,210,1260,6930,36036,180180,12,168,1512,11088,72072,432432,2450448,55,990,10890,94380,707850,4813380,30484740,273,6006,78078,780780,6636630,50438388,353068716,1428,37128,556920,6311760,59961720,503678448,3861534768}
1274	1478	2	a29949036f5652a2c3afc301b558d3555116e6f218a4d17ad01e2dc084fafcf3	{1,3,6,10,15,21,28,1,3,6,10,15,21,28,3,9,18,30,45,63,84,12,36,72,120,180,252,336,55,165,330,550,825,1155,1540,273,819,1638,2730,4095,5733,7644,1428,4284,8568,14280,21420,29988,39984}
1278	1283	2	9e1848fef3c552de22ff1455bfe9e338570b9942673c3c7ebbcc98895079058a	{1,3,3,1,0,0,0,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None}
491	419	1	96befb2ab0d7a167668862dcb7cd93239514cc044d91a844e18fd2cda3cca2fe	{1,2,-1,2,-5,14,-42,1,None,None,None,None,None,None,1,None,None,None,None,None,None,1,None,None,None,None,None,None,1,None,None,None,None,None,None,1,None,None,None,None,None,None,1,None,None,None,None,None,None}
1287	1325	2	209d90f7cefaa2c92fa7a3553436acd2c41b910542b1e56f8ff2dd0bbde3787c	{1,2,5,14,42,132,429,1,5,21,84,330,1287,5005,1,9,56,300,1485,7007,32032,1,14,120,825,5005,28028,148512,1,20,225,1925,14014,91728,556920,1,27,385,4004,34398,259896,1790712,1,35,616,7644,76440,659736,5116320}
1288	1327	2	583b6e9a81baee141a4cad69caa70f39541c093522aba433d3efdaf4f0a7765b	{0,1,1,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
1293	1473	2	5736ba6d51212e5e039c5927b67623692e02ac4fc3cd3db2ef2a67e22ff89531	{1,3,6,10,15,21,28,1,5,15,35,70,126,210,3,21,84,252,630,1386,2772,12,108,540,1980,5940,15444,36036,55,605,3630,15730,55055,165165,440440,273,3549,24843,124215,496860,1689324,5067972,1428,21420,171360,971040,4369680,16604784,55349280}
1298	816	3	87d715c631cc775ee7c7d09633ddbc6bab91e1b7d55008d647eefc4c8c10fca1	{1,2,6,20,70,252,924,2,4,12,40,140,504,1848,5,10,30,100,350,1260,4620,14,28,84,280,980,3528,12936,42,84,252,840,2940,10584,38808,132,264,792,2640,9240,33264,121968,429,858,2574,8580,30030,108108,396396}
1311	873	6	9fef1a50cc9524f2f2d3cac497babaf46db0e7d4eca4864e671d2e5fa5289d81	{1,2,6,20,70,252,924,1,2,6,20,70,252,924,3,6,18,60,210,756,2772,12,24,72,240,840,3024,11088,55,110,330,1100,3850,13860,50820,273,546,1638,5460,19110,68796,252252,1428,2856,8568,28560,99960,359856,1319472}
1297	815	\N	3383d8a9d2f2909b53c51b9ecaf5727a9e2c4eed52423c2797677f7d4124e4ad	{1,2,6,20,70,252,924,2,4,12,40,140,504,1848,1,2,6,20,70,252,924,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
1309	860	6	a29949036f5652a2c3afc301b558d3555116e6f218a4d17ad01e2dc084fafcf3	{1,3,3,1,0,0,0,1,4,6,4,1,0,0,3,15,30,30,15,3,0,12,72,180,240,180,72,12,55,385,1155,1925,1925,1155,385,273,2184,7644,15288,19110,15288,7644,1428,12852,51408,119952,179928,179928,119952}
1315	892	6	ef21af4f267bb5205faff444a2930b52a02ffe1be59583f052d527bea7965c42	{1,2,3,4,5,6,7,2,6,12,20,30,42,56,7,28,70,140,245,392,588,30,150,450,1050,2100,3780,6300,143,858,3003,8008,18018,36036,66066,728,5096,20384,61152,152880,336336,672672,3876,31008,139536,465120,1279080,3069792,6651216}
1284	1223	2	e20e7bf0241be6ea2b9bb7b5eda85b9ff1bc1c16a8dfd789b2e69425c9acb6e8	{1,2,10,63,462,3583,29172,1,2,10,63,462,3583,29172,1,2,10,63,462,3583,29172,1,2,10,63,462,3583,29172,1,2,10,63,462,3583,29172,1,2,10,63,462,3583,29172,1,2,10,63,462,3583,29172}
1285	1291	2	2bcf99946384986b0cb9016454ca1232455ec4913db8044f5bf1e9b7fbdb0487	{1,2,14,132,1430,16796,208012,1,2,14,132,1430,16796,208012,1,2,14,132,1430,16796,208012,1,2,14,132,1430,16796,208012,1,2,14,132,1430,16796,208012,1,2,14,132,1430,16796,208012,1,2,14,132,1430,16796,208012}
1286	1300	2	aede2d19100aef3cd484256720d8f1fc92ddf86498848808e5a7064745810b8e	{1,2,10,63,462,3583,29172,1,2,10,63,462,3583,29172,1,2,10,63,462,3583,29172,1,2,10,63,462,3583,29172,1,2,10,63,462,3583,29172,1,2,10,63,462,3583,29172,1,2,10,63,462,3583,29172}
3	3	1	cc0652ecd34f32042934f81c7e7aeb8df3330ddae6dff64ebb5735c9081a3c44	{0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
5	6	1	445ddd8cb81d5a3c7434682d1a0e6d03ce6cb9144ed36cabddf75e4854b94b06	{0,1,0,0,0,0,0,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
7	1001	6	e03aa85d7e676493bb1603b64041561d6ff3577516c3e3f54b3956383388282e	{1,-2,-1,-2,-5,-14,-42,1,-1,-1,-2,-5,-14,-42,1,0,0,0,0,0,0,1,1,2,5,14,42,132,1,2,5,14,42,132,429,1,3,9,28,90,297,1001,1,4,14,48,165,572,2002}
9	1129	3	8082d78cdae84fdc652dfd90f8ba0fbe1b7907db726b6741aaf4e3fcee766951	{None,0,0,0,0,0,0,3,18,81,330,1287,4914,18564,3,36,270,1632,8721,43092,201894,1,18,189,1518,10350,63180,356265,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
10	1003	6	ee8e10c986261a3b5d645004a92318a2f5608a7865e1938ff18343ee775e5f4b	{1,3,6,10,15,21,28,1,3,6,10,15,21,28,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
11	1004	6	e10e783331f582e2689296112f1f0882f7ce37a0fbf6d9c41bde7a8dc1fd0242	{1,3,9,28,90,297,1001,1,3,9,28,90,297,1001,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
13	1252	2	dbea2135bf54a1f7767bb3d235c0b02ab8d7abe7713297d4472f55e3b988b919	{1,4,14,48,165,572,2002,2,16,88,416,1820,7616,31008,3,36,270,1632,8721,43092,201894,4,64,608,4480,28336,161920,861120,5,100,1150,10000,73125,475020,2831850,6,144,1944,19488,161820,1178496,7791168,7,196,3038,34496,320705,2588964,18808062}
15	1253	2	b87e701b6fa9ed8293bf2e70af137f541379b87e85ce739408d1eb2c62d35968	{1,6,27,110,429,1638,6188,2,24,180,1088,5814,28728,134596,3,54,567,4554,31050,189540,1068795,4,96,1296,12992,107880,785664,5194112,5,150,2475,29750,291375,2467530,18734950,6,216,4212,59040,666414,6436584,55221804,7,294,6615,105938,1354164,14694120,140614565}
16	1007	6	c8a69472b407188589911a20f8f5ba3bc4d44e1be438d0ec9649b27bca28b50f	{1,2,1,0,0,0,0,2,4,2,0,0,0,0,1,2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
19	1130	3	58d242531b68eef50fbad6fab405854aabbba989f76958fe9f109255006696a9	{1,0,0,0,0,0,0,1,3,6,10,15,21,28,1,6,21,56,126,252,462,1,9,45,165,495,1287,3003,1,12,78,364,1365,4368,12376,1,15,120,680,3060,11628,38760,1,18,171,1140,5985,26334,100947}
20	1010	6	63b39c31516a7c3f884321a0d0121fe1038948b6936e10ba76bd9f2559757385	{1,3,6,10,15,21,28,2,6,12,20,30,42,56,1,3,6,10,15,21,28,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
21	1011	6	60894c6d0ccfe35137d82c361be1ac50cd35f58390dd4ddf20e96b00a678d2a9	{1,1,2,5,14,42,132,2,2,4,10,28,84,264,1,1,2,5,14,42,132,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
22	1012	6	65e311d38409132283a31d1a30a0504c8f4bf141d2b4e34b6922ef11a1253262	{1,2,5,14,42,132,429,2,4,10,28,84,264,858,1,2,5,14,42,132,429,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
24	1015	6	cd3f8f3f25536dff46de1595f25cd4186c932c9d7820f91e75f024d605fec7a7	{1,4,14,48,165,572,2002,2,8,28,96,330,1144,4004,1,4,14,48,165,572,2002,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
26	1257	2	ed7f5dfffe8f01c9eaaf47775d67cef00d07586011d18663de6627a16dc2cf5f	{1,1,1,1,1,1,1,3,6,9,12,15,18,21,6,18,36,60,90,126,168,10,40,100,200,350,560,840,15,75,225,525,1050,1890,3150,21,126,441,1176,2646,5292,9702,28,196,784,2352,5880,12936,25872}
27	1258	2	3e302215606c4be4a52ac9e5a023f8f9b0063777c87359154bdf2ba6ac605bec	{1,2,3,4,5,6,7,3,12,30,60,105,168,252,6,36,126,336,756,1512,2772,10,80,360,1200,3300,7920,17160,15,150,825,3300,10725,30030,75075,21,252,1638,7644,28665,91728,259896,28,392,2940,15680,66640,239904,759696}
30	1260	2	58665fb46ea73ba5b639f6cff5c0acc27872226549f636b67d50cae1f67bfad8	{1,1,2,5,14,42,132,3,6,15,42,126,396,1287,6,18,54,168,540,1782,6006,10,40,140,480,1650,5720,20020,15,75,300,1125,4125,15015,54600,21,126,567,2310,9009,34398,129948,28,196,980,4312,17836,71344,279888}
31	1261	2	68494b58d41e713b884fa7dd70ded147fa0f8171fe37d5e0d50f9fdd606f869a	{1,2,5,14,42,132,429,3,12,42,144,495,1716,6006,6,36,162,660,2574,9828,37128,10,80,440,2080,9100,38080,155040,15,150,975,5250,25500,116280,508725,21,252,1890,11424,61047,301644,1413258,28,392,3332,22344,130340,694232,3471160}
32	1262	2	33032c27af5a65e97aae8f358d17f392f796f9edd3020197f86c89a7a5aa263d	{1,3,9,28,90,297,1001,3,18,81,330,1287,4914,18564,6,54,324,1638,7560,33048,139536,10,120,900,5440,29070,143640,672980,15,225,2025,14250,86625,478170,2466750,21,378,3969,31878,217350,1326780,7481565,28,588,7056,63700,481572,3222828,19734848}
33	1264	2	127693eeffd9607ffd82fe8580d07b331c90efc63e99ac1498b65f3a26aad162	{1,4,14,48,165,572,2002,3,24,132,624,2730,11424,46512,6,72,540,3264,17442,86184,403788,10,160,1520,11200,70840,404800,2152800,15,300,3450,30000,219375,1425060,8495550,21,504,6804,68208,566370,4124736,27269088,28,784,12152,137984,1282820,10355856,75232248}
35	1266	2	155eef278d1e8d198f0b03d611f2a2af4fdbbf0e922ce795f0efb3c9c6f1232d	{1,3,6,10,15,21,28,1,6,21,56,126,252,462,2,18,90,330,990,2574,6006,5,60,390,1820,6825,21840,61880,14,210,1680,9520,42840,162792,542640,42,756,7182,47880,251370,1106028,4239774,132,2772,30492,233772,1402632,7013160,30390360}
36	1267	2	94169822f6b070ebdb9c3e2c06fe566183bb5076d48d96da5c3c1c788745e3b1	{1,3,9,28,90,297,1001,1,6,27,110,429,1638,6188,2,18,108,546,2520,11016,46512,5,60,450,2720,14535,71820,336490,14,210,1890,13300,80850,446292,2302300,42,756,7938,63756,434700,2653560,14963130,132,2772,33264,300300,2270268,15193332,93035712}
37	1268	2	638b96c7e8339f1e75377782e9380b0fc205a353a1991f09da6513cfe60228fc	{1,4,14,48,165,572,2002,1,8,44,208,910,3808,15504,2,24,180,1088,5814,28728,134596,5,80,760,5600,35420,202400,1076400,14,280,3220,28000,204750,1330056,7929180,42,1008,13608,136416,1132740,8249472,54538176,132,3696,57288,650496,6047580,48820464,354666312}
38	1269	2	8a0b6c732c3cdd92b40cd6921442a9415ea1a72917451be62f09685f0bee4e0b	{1,6,27,110,429,1638,6188,1,12,90,544,2907,14364,67298,2,36,378,3036,20700,126360,712530,5,120,1620,16240,134850,982080,6492640,14,420,6930,83300,815850,6909084,52457860,42,1512,29484,413280,4664898,45056088,386552628,132,5544,124740,1997688,25535664,277089120,2651588940}
40	1273	2	468bb64fd54efb5532593672b988ea4aa82c15e849e2e3acfc03f1e195f86a1e	{1,3,6,10,15,21,28,2,12,42,112,252,504,924,5,45,225,825,2475,6435,15015,14,168,1092,5096,19110,61152,173264,42,630,5040,28560,128520,488376,1627920,132,2376,22572,150480,790020,3476088,13325004,429,9009,99099,759759,4558554,22792770,98768670}
42	1275	2	677f679b70513031246e1c90a9130f3e6a73b636b2f23af089b628506a4dfa1a	{1,3,9,28,90,297,1001,2,12,54,220,858,3276,12376,5,45,270,1365,6300,27540,116280,14,168,1260,7616,40698,201096,942172,42,630,5670,39900,242550,1338876,6906900,132,2376,24948,200376,1366200,8339760,47026980,429,9009,108108,975975,7378371,49378329,302366064}
45	1281	2	adea8c74c1b334bda8536b867140222f7e2b8c4bca24bb8da1bf6d048ce5ce4d	{1,3,3,1,0,0,0,3,18,45,60,45,18,3,9,81,324,756,1134,1134,756,28,336,1848,6160,13860,22176,25872,90,1350,9450,40950,122850,270270,450450,297,5346,45441,242352,908820,2544696,5513508,1001,21021,210210,1331330,5990985,20369349,54318264}
46	1284	2	7d938c5d8f2cdeed76c9f0ddfec014d7bd81515170f4eab8536ba978196b5ea4	{1,3,6,10,15,21,28,3,18,63,168,378,756,1386,9,81,405,1485,4455,11583,27027,28,336,2184,10192,38220,122304,346528,90,1350,10800,61200,275400,1046520,3488400,297,5346,50787,338580,1777545,7821198,29981259,1001,21021,231231,1772771,10636626,53183130,230460230}
48	1289	2	6740330ef4d19d66731266719caf3110afd8ecef7e293d59393c7323a8521728	{1,4,14,48,165,572,2002,3,24,132,624,2730,11424,46512,9,108,810,4896,26163,129276,605682,28,448,4256,31360,198352,1133440,6027840,90,1800,20700,180000,1316250,8550360,50973300,297,7128,96228,964656,8010090,58335552,385662816,1001,28028,434434,4932928,45860815,370221852,2689552866}
49	1290	2	75559efd619c288c5ac1698f1a222b5198f59a4edbc45a34f2429b40abbfc3d6	{1,6,27,110,429,1638,6188,3,36,270,1632,8721,43092,201894,9,162,1701,13662,93150,568620,3206385,28,672,9072,90944,755160,5499648,36358784,90,2700,44550,535500,5244750,44415540,337229100,297,10692,208494,2922480,32987493,318610908,2733479298,1001,42042,945945,15149134,193645452,2101259160,20107882795}
50	1301	2	7d900adea80e3da32cdab621dcc15404112eb5481bfb1036bb8bde5bcffc1f41	{1,2,1,0,0,0,0,4,16,24,16,4,0,0,14,84,210,280,210,84,14,48,384,1344,2688,3360,2688,1344,165,1650,7425,19800,34650,41580,34650,572,6864,37752,125840,283140,453024,528528,2002,28028,182182,728728,2004002,4008004,6012006}
51	1302	2	648c24059c50ce5ca6b0a926bb498b95f88024e430abcc9a2f3d45fe9d9bca12	{1,3,3,1,0,0,0,4,24,60,80,60,24,4,14,126,504,1176,1764,1764,1176,48,576,3168,10560,23760,38016,44352,165,2475,17325,75075,225225,495495,825825,572,10296,87516,466752,1750320,4900896,10618608,2002,42042,420420,2662660,11981970,40738698,108636528}
53	1304	2	1a36e4e463c5523cc14c24db67e32aed9307242ea29974c1a4852cb4a42ab979	{1,2,3,4,5,6,7,4,16,40,80,140,224,336,14,84,294,784,1764,3528,6468,48,384,1728,5760,15840,38016,82368,165,1650,9075,36300,117975,330330,825825,572,6864,44616,208208,780780,2498496,7079072,2002,28028,210210,1121120,4764760,17153136,54318264}
54	1305	2	ab41d60564af9fca2860124929b7d51e2a99ba4a19143f3ca5835036646474c6	{1,3,6,10,15,21,28,4,24,84,224,504,1008,1848,14,126,630,2310,6930,18018,42042,48,576,3744,17472,65520,209664,594048,165,2475,19800,112200,504900,1918620,6395400,572,10296,97812,652080,3423420,15063048,57741684,2002,42042,462462,3545542,21273252,106366260,460920460}
55	1306	2	43a8babd164f750a255ea9717a59e78e8d74f96c890064e638454eb71eb13c43	{1,1,2,5,14,42,132,4,8,20,56,168,528,1716,14,42,126,392,1260,4158,14014,48,192,672,2304,7920,27456,96096,165,825,3300,12375,45375,165165,600600,572,3432,15444,62920,245388,936936,3539536,2002,14014,70070,308308,1275274,5101096,20011992}
56	1307	2	3f42253575aa7ddcd913ae33876ccc39191ff6f828d3644ae659adc1f383eb45	{1,2,5,14,42,132,429,4,16,56,192,660,2288,8008,14,84,378,1540,6006,22932,86632,48,384,2112,9984,43680,182784,744192,165,1650,10725,57750,280500,1279080,5595975,572,6864,51480,311168,1662804,8216208,38494456,2002,28028,238238,1597596,9319310,49637588,248187940}
86	1346	2	af1c98281bf3bf07d1c0f6050445c052955b2e0a81ac957634b2f070f104de59	{1,5,10,10,5,1,0,1,5,10,10,5,1,0,1,5,10,10,5,1,0,1,5,10,10,5,1,0,1,5,10,10,5,1,0,1,5,10,10,5,1,0,1,5,10,10,5,1,0}
60	1312	2	8a019ac3148b61cdf2323fb2956d55358dc14db6f4d0edec86e2f27aa504d788	{1,1,0,0,0,0,0,6,12,6,0,0,0,0,27,81,81,27,0,0,0,110,440,660,440,110,0,0,429,2145,4290,4290,2145,429,0,1638,9828,24570,32760,24570,9828,1638,6188,43316,129948,216580,216580,129948,43316}
61	1313	2	f24d6a6a3eb5aa812aac03bff1f57da6b0121d9e5a1328d317288453e884400b	{1,2,1,0,0,0,0,6,24,36,24,6,0,0,27,162,405,540,405,162,27,110,880,3080,6160,7700,6160,3080,429,4290,19305,51480,90090,108108,90090,1638,19656,108108,360360,810810,1297296,1513512,6188,86632,563108,2252432,6194188,12388376,18582564}
63	1315	2	1698b80484f4b204189e97ece9a2256b58d74c52af30123c992396cc4d676141	{1,1,1,1,1,1,1,6,12,18,24,30,36,42,27,81,162,270,405,567,756,110,440,1100,2200,3850,6160,9240,429,2145,6435,15015,30030,54054,90090,1638,9828,34398,91728,206388,412776,756756,6188,43316,173264,519792,1299480,2858856,5717712}
64	1316	2	d4d491a323b01f30c6016f632341226bc8a7e3af0d903190d2081bfab81c2b9b	{1,2,3,4,5,6,7,6,24,60,120,210,336,504,27,162,567,1512,3402,6804,12474,110,880,3960,13200,36300,87120,188760,429,4290,23595,94380,306735,858858,2147145,1638,19656,127764,596232,2235870,7154784,20271888,6188,86632,649740,3465280,14727440,53018784,167892816}
65	1317	2	89235c1b2b6a5fc61ae9741c5d3ca097665025b4acaedf14ebec0c6167e77f2b	{1,3,6,10,15,21,28,6,36,126,336,756,1512,2772,27,243,1215,4455,13365,34749,81081,110,1320,8580,40040,150150,480480,1361360,429,6435,51480,291720,1312740,4988412,16628040,1638,29484,280098,1867320,9803430,43135092,165351186,6188,129948,1429428,10958948,65753688,328768440,1424663240}
1	1	1	9fb33016a5d6b9db334b324e525915174ef38c7fa62554f5c9cdf94255dc7f36	{0,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
12	1005	6	0915faf280c406e956847f20df52b03d1120c4691f77dcc8c400fafdb84effa1	{1,4,14,48,165,572,2002,1,4,14,48,165,572,2002,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
17	1008	6	5143645f69843fb4bd3f5a9a32e13a2c19197006d3d5920c57fef1aada6e5cff	{1,3,3,1,0,0,0,2,6,6,2,0,0,0,1,3,3,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
29	1127	3	2310f4bd5324870120e54bbbe18df9a8f7a560c7f7302226fd04bc138129470b	{1,3,3,1,0,0,0,3,18,45,60,45,18,3,23,210,840,1960,2940,2940,1960,105,1260,6930,23100,51975,83160,97020,1201,18018,126126,546546,1639638,3607203,6012006,6006,108108,918918,4900896,18378360,51459408,111495384,79181,1662804,16628040,105310920,473899140,1611257076,4296685536}
41	1274	2	724d9efbbabd0024f6d4042fd26c650211ece38ea5a4c183216006fdfaafbff5	{1,2,5,14,42,132,429,2,8,28,96,330,1144,4004,5,30,135,550,2145,8190,30940,14,112,616,2912,12740,53312,217056,42,420,2730,14700,71400,325584,1424430,132,1584,11880,71808,383724,1896048,8883336,429,6006,51051,342342,1996995,10636626,53183130}
66	1318	2	c2c41c5557e8aa390e1c86c8dc5932860321cc1729472ffb58419f5a05e9400d	{1,1,2,5,14,42,132,6,12,30,84,252,792,2574,27,81,243,756,2430,8019,27027,110,440,1540,5280,18150,62920,220220,429,2145,8580,32175,117975,429429,1561560,1638,9828,44226,180180,702702,2683044,10135944,6188,43316,216580,952952,3941756,15767024,61855248}
67	1319	2	71b922cbfc51deaf1e357379afbe9ba7f9206337e3159bf0243dadaff2d30a29	{1,2,5,14,42,132,429,6,24,84,288,990,3432,12012,27,162,729,2970,11583,44226,167076,110,880,4840,22880,100100,418880,1705440,429,4290,27885,150150,729300,3325608,14549535,1638,19656,147420,891072,4761666,23528232,110234124,6188,86632,736372,4938024,28805140,153425272,767126360}
69	1322	2	c41095cf77c89f5dea64f7864a3ee84a097df81ec02290be5eea8215a1e613ea	{1,4,14,48,165,572,2002,6,48,264,1248,5460,22848,93024,27,324,2430,14688,78489,387828,1817046,110,1760,16720,123200,779240,4452800,23680800,429,8580,98670,858000,6274125,40756716,242972730,1638,39312,530712,5320224,44176860,321729408,2126988864,6188,173264,2685592,30494464,283503220,2288644176,16626326808}
71	1324	2	de84ea8a7e614aef1b0d21507f19230a05eb5246f461099fca290c3a97485059	{1,5,10,10,5,1,0,1,6,15,20,15,6,1,1,7,21,35,35,21,7,1,8,28,56,70,56,28,1,9,36,84,126,126,84,1,10,45,120,210,252,210,1,11,55,165,330,462,462}
72	1326	2	1457578b8f597901387ac0f9c283f1e42f502e04e1ce51f8eef6ef6e053935eb	{1,5,10,10,5,1,0,1,11,55,165,330,462,462,2,34,272,1360,4760,12376,24752,5,115,1265,8855,44275,168245,504735,14,406,5684,51156,332514,1662570,6650280,42,1470,24990,274890,2199120,13634544,68172720,132,5412,108240,1407120,13367640,98920536,593523216}
73	1328	2	7f96a309e6b3a0503202cf731975d6d7ed33df1f0da442f40b9d49644ef45d3b	{0,0,1,2,1,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
74	1329	2	b2a7b620d5bc88a4eb9ea5aead9bba318b6a6fc4f58f5d46f1340a747293df8c	{1,2,3,4,5,6,7,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
76	1331	2	d1e92d3165a5f312ed2ced8139d7d8f98da7ed7c2c6b8f06b86e8b19677ebae9	{1,4,10,20,35,56,84,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
77	1332	2	cc0dd105573928364407c98ea51dadeee237ed9f61644cc309e7c632bf8ebc6d	{1,5,15,35,70,126,210,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
78	1333	2	0103547921757e935dabbfc81327d801ea44981673345323903cfdb5936a8d53	{1,5,15,35,70,126,210,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
80	1335	2	4385bbed7d46c2aad55f3db2d1ec250850643d6b0f8f932835055de73200fe5a	{1,5,10,10,5,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
81	1338	2	0cf6d971bb8bd1f0aeb97b17f5e484f190f5ab91703f9b188d4449c339fae672	{1,3,3,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
82	1339	2	3cf1e466f080127beb5ca1071077eb6eb4ead85cf5de891e21dab7fa6dae0ebe	{1,3,3,1,0,0,0,1,6,15,20,15,6,1,2,18,72,168,252,252,168,5,60,330,1100,2475,3960,4620,14,210,1470,6370,19110,42042,70070,42,756,6426,34272,128520,359856,779688,132,2772,27720,175560,790020,2686068,7162848}
83	1341	2	05c0b65a1a4fde9de372a6cf6405c82533b575bb7dcbe3856e7462632b7c0498	{1,4,6,4,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
85	1344	2	6849d8c01a66ad8e418d32a693894fe70d09d0bad9d0d6e1ead87e8557ca2f47	{1,4,6,4,1,0,0,1,8,28,56,70,56,28,2,24,132,440,990,1584,1848,5,80,600,2800,9100,21840,40040,14,280,2660,15960,67830,217056,542640,42,1008,11592,85008,446292,1785168,5653032,132,3696,49896,432432,2702700,12972960,49729680}
89	1349	2	0fc543f49b59bf75e2c4583849d90196ad85ada234a191fb3e2cb40bf269c7b6	{1,0,0,0,0,0,0,1,4,6,4,1,0,0,1,8,28,56,70,56,28,1,12,66,220,495,792,924,1,16,120,560,1820,4368,8008,1,20,190,1140,4845,15504,38760,1,24,276,2024,10626,42504,134596}
90	1350	2	5a97310d83aba572b9c35b61edbabb96cdfc90fc6cb8ba47a77c6290fe2c58c9	{1,0,0,0,0,0,0,1,4,6,4,1,0,0,2,16,56,112,140,112,56,5,60,330,1100,2475,3960,4620,14,224,1680,7840,25480,61152,112112,42,840,7980,47880,203490,651168,1627920,132,3168,36432,267168,1402632,5610528,17766672}
91	1351	2	8f24ff4367534e51b343db9772c324eda1f735afc40e46ee90e38da34d9f27ae	{1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,4,16,64,256,1024,4096,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
94	1359	2	4f538cbd8febe7108c54b49470f026c99db2c0c8e6895b101e3303e0dcdb8f96	{None,3,9,28,90,297,1001,None,0,0,0,0,0,0,None,0,0,0,0,0,0,None,0,0,0,0,0,0,None,0,0,0,0,0,0,None,0,0,0,0,0,0,None,0,0,0,0,0,0}
97	1018	6	2776f91457545607969ccab9395325f936145dbf4a00e568a068f05fc329072f	{1,2,1,0,0,0,0,3,6,3,0,0,0,0,3,6,3,0,0,0,0,1,2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
98	1019	6	a5ef8cdf29d03aa0df85b7fd95b58d81bfa06e350cb9bb030bc67bec53335fbf	{1,3,3,1,0,0,0,3,9,9,3,0,0,0,3,9,9,3,0,0,0,1,3,3,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
99	1020	6	fa9ec41b39ec0f30e104b26ab5b0aa09ed6e5a97be268ee8636cae2fc513f361	{1,1,1,1,1,1,1,3,3,3,3,3,3,3,3,3,3,3,3,3,3,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
101	1022	6	72f7c0850ca050368aadb3901814e988f37903ae02c4941845922b1b5de8342c	{1,3,6,10,15,21,28,3,9,18,30,45,63,84,3,9,18,30,45,63,84,1,3,6,10,15,21,28,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
102	1023	6	5279dfd5f7a26465541ab6a294e4b4d41d8081b104315071c60040bc9cce0fdf	{1,1,2,5,14,42,132,3,3,6,15,42,126,396,3,3,6,15,42,126,396,1,1,2,5,14,42,132,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
103	1024	6	76f8baf3f27bee3cd9c203b1ecd74aab69528b7955bb07ba0d32dc47e250c0d9	{1,2,5,14,42,132,429,3,6,15,42,126,396,1287,3,6,15,42,126,396,1287,1,2,5,14,42,132,429,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
104	1025	6	508a77f9dc1ff6d7088e69fc41a195a43ddd692fb1d0c9e2c50482d264758d7b	{1,3,9,28,90,297,1001,3,9,27,84,270,891,3003,3,9,27,84,270,891,3003,1,3,9,28,90,297,1001,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
106	1028	6	7eed0f62721152105ed2cddfd67ef4e3be54b1a117ebcf32a672987e4471220d	{1,6,27,110,429,1638,6188,3,18,81,330,1287,4914,18564,3,18,81,330,1287,4914,18564,1,6,27,110,429,1638,6188,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
107	1029	6	b531e7cd1b0dc4b24407fabbc196f8f4df245823e672b07b4318ff7d75e91d94	{1,3,3,1,0,0,0,1,3,3,1,0,0,0,1,3,3,1,0,0,0,1,3,3,1,0,0,0,1,3,3,1,0,0,0,1,3,3,1,0,0,0,1,3,3,1,0,0,0}
110	1032	6	cd1cfb3bbd455da2bd8d6f7307ac2dbeb74a9d849815326ac5dd4a5667cc885f	{1,4,14,48,165,572,2002,1,4,14,48,165,572,2002,1,4,14,48,165,572,2002,1,4,14,48,165,572,2002,1,4,14,48,165,572,2002,1,4,14,48,165,572,2002,1,4,14,48,165,572,2002}
111	1033	6	a32a5e9665f80bb054c26b379c843e98803638724e525e6ba4d9da918454297f	{1,6,27,110,429,1638,6188,1,6,27,110,429,1638,6188,1,6,27,110,429,1638,6188,1,6,27,110,429,1638,6188,1,6,27,110,429,1638,6188,1,6,27,110,429,1638,6188,1,6,27,110,429,1638,6188}
112	1034	6	8751581c7a8f7ffd9968ecd6c9a713ab394f77f8dc3a11018522c5638e383ea0	{1,3,3,1,0,0,0,2,6,6,2,0,0,0,3,9,9,3,0,0,0,4,12,12,4,0,0,0,5,15,15,5,0,0,0,6,18,18,6,0,0,0,7,21,21,7,0,0,0}
113	1035	6	b417267d6b4c4ecbfcbe03ce641df168bb9687a8c41aea2a234a7cd039f5809e	{1,2,5,14,42,132,429,2,4,10,28,84,264,858,3,6,15,42,126,396,1287,4,8,20,56,168,528,1716,5,10,25,70,210,660,2145,6,12,30,84,252,792,2574,7,14,35,98,294,924,3003}
116	1039	6	abfb14a83eeed9ce9ba06d357fd6c3961ff605769c3eb195e8dc59ce6c78e337	{1,6,27,110,429,1638,6188,2,12,54,220,858,3276,12376,3,18,81,330,1287,4914,18564,4,24,108,440,1716,6552,24752,5,30,135,550,2145,8190,30940,6,36,162,660,2574,9828,37128,7,42,189,770,3003,11466,43316}
117	1040	6	007137cca242d167b1b0636f242c1cafbcca591e89f045c31abbd44c0b390aeb	{1,1,0,0,0,0,0,3,3,0,0,0,0,0,6,6,0,0,0,0,0,10,10,0,0,0,0,0,15,15,0,0,0,0,0,21,21,0,0,0,0,0,28,28,0,0,0,0,0}
119	1042	6	b4102922e64e84037d6f013cc078dfa09c8582df78136fe45e2809d2cc541aed	{1,3,3,1,0,0,0,3,9,9,3,0,0,0,6,18,18,6,0,0,0,10,30,30,10,0,0,0,15,45,45,15,0,0,0,21,63,63,21,0,0,0,28,84,84,28,0,0,0}
120	1043	6	d53a2ba67bbd3779d0760e8b3046adb402a237c8055689c51f53804b5daddf7c	{1,1,1,1,1,1,1,3,3,3,3,3,3,3,6,6,6,6,6,6,6,10,10,10,10,10,10,10,15,15,15,15,15,15,15,21,21,21,21,21,21,21,28,28,28,28,28,28,28}
121	1044	6	901de8954cee7fd13875002b99f63ca166ebf65aaa5746383fe841f352bee7c4	{1,2,3,4,5,6,7,3,6,9,12,15,18,21,6,12,18,24,30,36,42,10,20,30,40,50,60,70,15,30,45,60,75,90,105,21,42,63,84,105,126,147,28,56,84,112,140,168,196}
122	1045	6	7407d665146253520c28c4b69fe174c465fabc8cdc671f1d55fb027c5117c5a8	{1,3,6,10,15,21,28,3,9,18,30,45,63,84,6,18,36,60,90,126,168,10,30,60,100,150,210,280,15,45,90,150,225,315,420,21,63,126,210,315,441,588,28,84,168,280,420,588,784}
124	1047	6	b020a97c090405b1e6d360c8172647e49db76f07f719e92c9b30703d8638c884	{1,2,5,14,42,132,429,3,6,15,42,126,396,1287,6,12,30,84,252,792,2574,10,20,50,140,420,1320,4290,15,30,75,210,630,1980,6435,21,42,105,294,882,2772,9009,28,56,140,392,1176,3696,12012}
125	1048	6	60543b7b4b00360a64acc0cf90856f1c6477c763511d4a5261a28a80d63bb911	{1,3,9,28,90,297,1001,3,9,27,84,270,891,3003,6,18,54,168,540,1782,6006,10,30,90,280,900,2970,10010,15,45,135,420,1350,4455,15015,21,63,189,588,1890,6237,21021,28,84,252,784,2520,8316,28028}
137	12	1	d23bbf0f780521111f176842f912f0f047df856a5866ab97b7731f25acafb97f	{1,1,0,0,0,0,0,1,2,1,0,0,0,0,1,3,3,1,0,0,0,1,4,6,4,1,0,0,1,5,10,10,5,1,0,1,6,15,20,15,6,1,1,7,21,35,35,21,7}
127	1051	6	7a50033181867b54b3bc4553048a5091ab629b6baf6a99adf88188daa53c2ec4	{1,6,27,110,429,1638,6188,3,18,81,330,1287,4914,18564,6,36,162,660,2574,9828,37128,10,60,270,1100,4290,16380,61880,15,90,405,1650,6435,24570,92820,21,126,567,2310,9009,34398,129948,28,168,756,3080,12012,45864,173264}
129	1053	6	854c8818873ccf053759905fb11f4df7f43f243447da686428bbebe63514cab2	{1,2,5,14,42,132,429,1,2,5,14,42,132,429,2,4,10,28,84,264,858,5,10,25,70,210,660,2145,14,28,70,196,588,1848,6006,42,84,210,588,1764,5544,18018,132,264,660,1848,5544,17424,56628}
130	1054	6	6096a063b95afff320a7d0a742a7c64aa1407c75bb79f7a2afb9c356483482bd	{1,3,9,28,90,297,1001,1,3,9,28,90,297,1001,2,6,18,56,180,594,2002,5,15,45,140,450,1485,5005,14,42,126,392,1260,4158,14014,42,126,378,1176,3780,12474,42042,132,396,1188,3696,11880,39204,132132}
92	1352	2	85d46478a770f9b965267bf13fd35cff9456151c8a7392faf1fa8580e551235b	{1,6,30,140,630,2772,12012,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
148	23	1	e90bda9f937865317c1cd7fc5c02c7d84987ddec7e96ddec84bb9d9a288721c0	{1,0,0,0,0,0,0,1,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
149	24	1	a3c8f75eb181360a6e5e99025bff62b843345e5f8a15b16b26ffdc323799fe32	{1,0,0,0,0,0,0,1,1,0,0,0,0,0,0,2,1,0,0,0,0,0,1,3,1,0,0,0,0,0,3,4,1,0,0,0,0,1,6,5,1,0,0,0,0,4,10,6,1}
150	25	1	6590b95d961a3a9a3eeb7970565f017fc157169297470bd3cdfd95fb036aa2c4	{1,0,0,0,0,0,0,1,1,0,0,0,0,0,1,3,1,0,0,0,0,1,6,6,1,0,0,0,1,10,20,10,1,0,0,1,15,50,50,15,1,0,1,21,105,175,105,21,1}
154	29	1	96e323d13fe093a3f81f69e9c72fc01cebeccd55037f529dce79cedfa6c4c59a	{1,0,0,0,0,0,0,1,1,0,0,0,0,0,0,2,2,0,0,0,0,0,1,6,5,0,0,0,0,0,6,20,14,0,0,0,0,2,30,70,42,0,0,0,0,20,140,252,132}
178	53	1	719e15d0819c7783ba27bfe7a4d8b31bb98a69a8fbb8c16d212a74120f14153d	{1,1,-1,2,-5,14,-42,1,1,-1,2,-5,14,-42,1,1,-1,2,-5,14,-42,1,1,-1,2,-5,14,-42,1,1,-1,2,-5,14,-42,1,1,-1,2,-5,14,-42,1,1,-1,2,-5,14,-42}
132	7	1	c9d78bfa7db0e1f6dd8d1ef57338b10d2dd5cc6d98861399aab9dad53846d530	{0,1,0,0,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
134	9	1	cc0652ecd34f32042934f81c7e7aeb8df3330ddae6dff64ebb5735c9081a3c44	{0,1,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
135	10	1	aa3de9e4181be0c2084190a073221f1ec4797b2284eb8fb6a697c8703f6427a9	{1,1,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
136	11	1	164319b2934a0a702dac834c559a75bdaddd14236a93f016e401cf80003f31b9	{1,1,1,1,1,1,1,1,2,3,4,5,6,7,0,1,3,6,10,15,21,0,0,1,4,10,20,35,0,0,0,1,5,15,35,0,0,0,0,1,6,21,0,0,0,0,0,1,7}
140	15	1	88d35b08dcdb708c40503db0dc6afe1b3db9811bfa3b2e7c2e805d9768faa6a4	{-1,-2,-3,-4,-5,-6,-7,-2,-3,-4,-5,-6,-7,-8,-3,-4,-5,-6,-7,-8,-9,-4,-5,-6,-7,-8,-9,-10,-5,-6,-7,-8,-9,-10,-11,-6,-7,-8,-9,-10,-11,-12,-7,-8,-9,-10,-11,-12,-13}
141	16	1	579aa99d0a27d3f57a0bc9772ca1957ef4cb8bb3289a666611454f9ce7267c60	{1,1,0,0,0,0,0,1,3,3,1,0,0,0,2,10,20,20,10,2,0,5,35,105,175,175,105,35,14,126,504,1176,1764,1764,1176,42,462,2310,6930,13860,19404,19404,132,1716,10296,37752,94380,169884,226512}
142	17	1	e6d79fbdf8239702555e6b68c097925a9d14032b016b1da8b80a8c56d5cc15d9	{1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
143	18	1	679077fa58f7c7a017ae82c1a58ad2a57413776240be4ebfb3a31afb09ee60c9	{1,1,2,5,14,42,132,1,2,6,20,70,252,924,0,1,6,30,140,630,2772,0,0,2,20,140,840,4620,0,0,0,5,70,630,4620,0,0,0,0,14,252,2772,0,0,0,0,0,42,924}
145	20	1	43e2be2c9ce5af1fdc68364837b8ec538b806ebff543343f86ab581b61c414fa	{1,1,2,5,14,42,132,1,4,15,56,210,792,3003,2,15,84,420,1980,9009,40040,5,56,420,2640,15015,80080,408408,14,210,1980,15015,100100,612612,3527160,42,792,9009,80080,612612,4232592,27159132,132,3003,40040,408408,3527160,27159132,192203088}
146	21	1	61d102a8204c27e36b75219351ed8ce7580c792256e3c208755dc451720e2137	{1,1,2,5,14,42,132,1,3,10,35,126,462,1716,1,6,30,140,630,2772,12012,1,10,70,420,2310,12012,60060,1,15,140,1050,6930,42042,240240,1,21,252,2310,18018,126126,816816,1,28,420,4620,42042,336336,2450448}
147	22	1	813ff17c6e241fe5ccf2da3435fde16eb5b3833f8c383a341c60b5f491393ca9	{1,1,1,1,1,1,1,1,3,6,10,15,21,28,2,10,30,70,140,252,420,5,35,140,420,1050,2310,4620,14,126,630,2310,6930,18018,42042,42,462,2772,12012,42042,126126,336336,132,1716,12012,60060,240240,816816,2450448}
152	27	1	0065ba672ea9bc16a8a7bd50baf7e4cc976652eff55bd29a43462e8da659a9bd	{1,2,5,14,42,132,429,2,10,42,168,660,2574,10010,5,42,252,1320,6435,30030,136136,14,168,1320,8580,50050,272272,1410864,42,660,6435,50050,340340,2116296,12345060,132,2574,30030,272272,2116296,14814072,96101544,429,10010,136136,1410864,12345060,96101544,686439600}
153	28	1	1555cee3064208ea405584135b225eefd5582654dc787e70f4eadfeea69acf0e	{1,0,0,0,0,0,0,1,1,0,0,0,0,0,0,1,1,0,0,0,0,0,0,1,1,0,0,0,0,0,0,1,1,0,0,0,0,0,0,1,1,0,0,0,0,0,0,1,1}
155	30	1	071d36d27cee69c62da2c627ae06074d186aed42e5ecf4459d067659300d4591	{1,0,0,0,0,0,0,1,1,0,0,0,0,0,1,3,2,0,0,0,0,1,6,10,5,0,0,0,1,10,30,35,14,0,0,1,15,70,140,126,42,0,1,21,140,420,630,462,132}
156	31	1	0be1b3b5fe00a334776d25d37c33de07b50821d00da64d97129804493c1162e4	{1,1,0,0,0,0,0,1,3,0,0,0,0,0,1,6,0,0,0,0,0,1,10,0,0,0,0,0,1,15,0,0,0,0,0,1,21,0,0,0,0,0,1,28,0,0,0,0,0}
158	33	1	137fd71444dd13b645514af4848c898c63a307d3e1eaeed7487340f0a21b7f66	{1,1,2,5,14,42,132,1,5,18,65,238,882,3300,1,15,90,455,2142,9702,42900,1,35,330,2275,13566,74382,386100,1,70,990,9100,67830,446292,2702700,1,126,2574,30940,284886,2231460,15675660,1,210,6006,92820,1044582,9669660,78378300}
160	35	1	6008fde5b1a2adf5b0fc59fa915427d4aa279aea7db67a90120d6f43b2f48b1f	{1,1,0,0,0,0,0,1,1,0,0,0,0,0,1,1,0,0,0,0,0,1,1,0,0,0,0,0,1,1,0,0,0,0,0,1,1,0,0,0,0,0,1,1,0,0,0,0,0}
163	38	1	fc889fd35408f7d226ffad4fc90e0740af15a115bcdb254da861d8c707292f1c	{1,0,0,0,0,0,0,1,1,0,0,0,0,0,1,2,1,0,0,0,0,1,3,3,1,0,0,0,1,4,6,4,1,0,0,1,5,10,10,5,1,0,1,6,15,20,15,6,1}
165	40	1	d1c2899326db1e409d2469de34da85d6d7eb41f87b611a2ff59992684780bd51	{1,1,0,0,0,0,0,1,-1,1,-1,1,-1,1,-1,3,-6,10,-15,21,-28,2,-10,30,-70,140,-252,420,-5,35,-140,420,-1050,2310,-4620,14,-126,630,-2310,6930,-18018,42042,-42,462,-2772,12012,-42042,126126,-336336}
166	41	1	c416d7f182e5da9063e74b1c9d0d0bdbe709edc01ab63c1c1ebb66d26a894ab3	{1,1,-1,2,-5,14,-42,1,-1,3,-10,35,-126,462,0,1,-6,30,-140,630,-2772,0,-1,10,-70,420,-2310,12012,0,1,-15,140,-1050,6930,-42042,0,-1,21,-252,2310,-18018,126126,0,1,-28,420,-4620,42042,-336336}
167	42	1	0e405936a2b60aabec4542b333dcb696c057154f10073c61e7f1515e8b3d0000	{1,2,1,0,0,0,0,1,3,3,1,0,0,0,1,4,6,4,1,0,0,1,5,10,10,5,1,0,1,6,15,20,15,6,1,1,7,21,35,35,21,7,1,8,28,56,70,56,28}
169	44	1	a19f0dd228a176428be0d040588767aa3b16442d07eeeb964326e65715ada85b	{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}
170	45	1	f9091b365c483e87291a3cfe4bf5dcefaacef6eb50e5c1416d14c06ec27cc96d	{1,1,0,0,0,0,0,1,1,0,0,0,0,0,2,3,1,0,0,0,0,5,10,6,1,0,0,0,14,35,30,10,1,0,0,42,126,140,70,15,1,0,132,462,630,420,140,21,1}
171	46	1	07f4b9bbd5c46e5838a49f079af8cc286bde586521d532a58033675bd92a9b7b	{1,1,2,5,14,42,132,1,2,6,20,70,252,924,1,3,12,50,210,882,3696,1,4,20,100,490,2352,11088,1,5,30,175,980,5292,27720,1,6,42,280,1764,10584,60984,1,7,56,420,2940,19404,121968}
173	48	1	69a402eca27f7ed21780238dc05cdc4d9602766046db1009a3404d6c9daa40f4	{1,1,1,1,1,1,1,1,3,5,7,9,11,13,1,6,15,28,45,66,91,1,10,35,84,165,286,455,1,15,70,210,495,1001,1820,1,21,126,462,1287,3003,6188,1,28,210,924,3003,8008,18564}
174	49	1	921387038b9e6f3e9665330c0012d757ea5e0308fc5c5e1c874a42cd54399285	{1,1,2,5,14,42,132,1,4,14,50,182,672,2508,1,10,56,275,1274,5712,25080,1,20,168,1100,6370,34272,175560,1,35,420,3575,25480,162792,965580,1,56,924,10010,86632,651168,4441668,1,84,1848,25025,259896,2279088,17766672}
175	50	1	e9e9a24b73934b93e794f09eddf196bfaf05a438868f519d01cf4a719869f395	{1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
176	51	1	8741e94270030dab43000b3b285a99defc341741db6376bc08473a22febe053d	{1,1,2,5,14,42,132,1,1,3,10,35,126,462,0,0,1,6,30,140,630,0,0,0,1,10,70,420,0,0,0,0,1,15,140,0,0,0,0,0,1,21,0,0,0,0,0,0,1}
179	54	1	41de3ef11edb53ee7dd73e4404f2a49d760686f6faf286af4d1ef29f51e58de4	{1,1,-1,2,-5,14,-42,1,2,-1,2,-5,14,-42,1,6,0,2,-6,18,-56,1,20,10,0,-5,20,-70,1,70,70,0,0,14,-70,1,252,378,84,0,0,-42,1,924,1848,924,0,0,0}
180	55	1	ad79575d6077993646d7afef19ba025e5a95f047b3696dbf280efe34796cc204	{1,1,0,0,0,0,0,2,0,0,0,0,0,0,3,0,0,0,0,0,0,4,0,0,0,0,0,0,5,0,0,0,0,0,0,6,0,0,0,0,0,0,7,0,0,0,0,0,0}
182	57	1	2af020f5aea9f848b518012175a902e7542b9a4423aac18b759ca95bfcd64c1e	{1,1,2,5,14,42,132,2,4,12,40,140,504,1848,3,10,42,180,770,3276,13860,4,20,112,600,3080,15288,73920,5,35,252,1650,10010,57330,314160,6,56,504,3960,28028,183456,1130976,7,84,924,8580,70070,519792,3581424}
184	59	1	3f77cfe49fd0dd8671cd0b394832405ca0fb30625bb6965905c7bbee5aadd1d7	{1,1,1,1,1,1,1,2,2,2,2,2,2,2,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
185	60	1	3406648a38ed631375c3b59b9f6fb17df8a823f31d2e62bfe65e03e36a3d7e46	{1,1,0,0,0,0,0,2,2,0,0,0,0,0,5,6,1,0,0,0,0,14,20,6,0,0,0,0,42,70,30,2,0,0,0,132,252,140,20,0,0,0,429,924,630,140,5,0,0}
186	61	1	7114687f3923860406888c6d73e4a6d0fd40b59a74a35974578f41c71e7bc13f	{1,1,2,5,14,42,132,2,4,12,40,140,504,1848,1,6,30,140,630,2772,12012,0,4,40,280,1680,9240,48048,0,1,30,350,2940,20790,132132,0,0,12,280,3528,33264,264264,0,0,2,140,2940,38808,396396}
188	63	1	9d746391ac2ce8b4e06c4ca4b6264f99ba7b63d287bf313cde249ca278747957	{1,1,1,1,1,1,1,1,2,3,4,5,6,7,2,5,9,14,20,27,35,5,14,28,48,75,110,154,14,42,90,165,275,429,637,42,132,297,572,1001,1638,2548,132,429,1001,2002,3640,6188,9996}
189	64	1	b5b0149faf18a1bd2130aa7a092456fe69e4faf718c4717369686c2c825a754e	{1,1,2,5,14,42,132,1,3,10,35,126,462,1716,2,9,40,175,756,3234,13728,5,28,150,770,3822,18480,87516,14,90,550,3185,17640,94248,489060,42,297,2002,12740,77112,447678,2510508,132,1001,7280,49980,325584,2027718,12156144}
190	65	1	7b04456a9d6503743e8a620c0d189dd7b803f726466d62092e2004113f493166	{1,1,2,5,14,42,132,1,1,2,5,14,42,132,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
192	67	1	e99b0d21387c50b8f9802108a2e17e7f0738233fa4a4b0e1187b7e7c5b11dc54	{1,1,2,5,14,42,132,1,3,9,28,90,297,1001,2,10,40,150,550,2002,7280,5,35,175,770,3185,12740,49980,14,126,756,3822,17640,77112,325584,42,462,3234,18480,94248,447678,2027718,132,1716,13728,87516,489060,2510508,12156144}
193	68	1	f7f3b0dfa0bdde569f5a7fb9cf1d5915429ba10401edc14b9b62920a95ef7111	{1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,5,5,5,5,5,5,5,14,14,14,14,14,14,14,42,42,42,42,42,42,42,132,132,132,132,132,132,132}
194	69	1	2b3cdb773051970866eb03e6c7cf9ae20b799df21c418a773bbbcdac6711a2b6	{1,1,2,5,14,42,132,1,2,6,20,70,252,924,2,5,18,70,280,1134,4620,5,14,56,240,1050,4620,20328,14,42,180,825,3850,18018,84084,42,132,594,2860,14014,68796,336336,132,429,2002,10010,50960,259896,1319472}
195	70	1	082d169ba81dd5c2ad9b62796c7c8d42e775824dd632017c95ab5b208adb76d4	{1,2,3,4,5,6,7,1,4,10,20,35,56,84,1,6,21,56,126,252,462,1,8,36,120,330,792,1716,1,10,55,220,715,2002,5005,1,12,78,364,1365,4368,12376,1,14,105,560,2380,8568,27132}
243	118	1	db72e3d1aa903b94fc790ace5a4d22c5cfee0cbee82ca0412302fd8a8c2a822c	{1,2,-2,4,-10,28,-84,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
245	120	1	0fafa99d3497cf95a7c3e42fc200e8ff301328dbfc24080d9b803c1ac69ce1c1	{1,1,0,0,0,0,0,2,2,0,0,0,0,0,2,0,-2,0,0,0,0,0,-4,0,4,0,0,0,-2,0,12,0,-10,0,0,0,12,0,-40,0,28,0,4,0,-60,0,140,0,-84}
226	101	1	5f56d7776ebcc160386ebf1ee679f9df490bb2108335688891dd49f999d86564	{1,1,1,1,1,1,1,2,6,12,20,30,42,56,6,30,90,210,420,756,1260,20,140,560,1680,4200,9240,18480,70,630,3150,11550,34650,90090,210210,252,2772,16632,72072,252252,756756,2018016,924,12012,84084,420420,1681680,5717712,17153136}
229	104	1	6fd3a9c2e2898e34470c7f71cf7e8c11ebb9a7e7250f4106e916c8d01dacd6e2	{1,1,1,1,1,1,1,2,4,6,8,10,12,14,2,6,12,20,30,42,56,0,0,0,0,0,0,0,-2,-10,-30,-70,-140,-252,-420,0,0,0,0,0,0,0,4,28,112,336,840,1848,3696}
230	105	1	bc875037c684a622d3f6f04011a36ba304e59a0ef59598724d588774ee857361	{1,2,3,4,5,6,7,2,8,20,40,70,112,168,3,20,75,210,490,1008,1890,4,40,210,784,2352,6048,13860,5,70,490,2352,8820,27720,76230,6,112,1008,6048,27720,104544,339768,7,168,1890,13860,76230,339768,1288287}
231	106	1	1ca1b2557fae5a1b70b2134a9749d5618af43f670516f8a8938361c49e6e47d8	{1,2,3,4,5,6,7,0,2,8,20,40,70,112,0,2,15,60,175,420,882,0,2,24,140,560,1764,4704,0,2,35,280,1470,5880,19404,0,2,48,504,3360,16632,66528,0,2,63,840,6930,41580,198198}
233	108	1	13f812d286a57dc8d404dfa523bf3ca62da36535eeb2585f1c66f0e9abcf264b	{1,1,2,5,14,42,132,0,1,4,15,56,210,792,0,1,6,30,140,630,2772,0,1,8,50,280,1470,7392,0,1,10,75,490,2940,16632,0,1,12,105,784,5292,33264,0,1,14,140,1176,8820,60984}
234	109	1	e5f8283a8c4a074ef2bac69bc5eb10031ccb02d797d8dd4e1d4968675a038f3d	{1,1,1,1,1,1,1,0,1,3,6,10,15,21,0,1,6,20,50,105,196,0,1,10,50,175,490,1176,0,1,15,105,490,1764,5292,0,1,21,196,1176,5292,19404,0,1,28,336,2520,13860,60984}
235	110	1	0cfe4f6bf7e037d41e892dfec638dfa3e36c786fa6e6dc80c4f790caa0817a2d	{1,0,0,0,0,0,0,1,1,1,1,1,1,1,1,3,6,10,15,21,28,1,6,20,50,105,196,336,1,10,50,175,490,1176,2520,1,15,105,490,1764,5292,13860,1,21,196,1176,5292,19404,60984}
236	111	1	1fa3b39ec3a5474679f7106a57a3ac80a42a47c47b74379e7a0b0713e861a9e3	{1,1,2,5,14,42,132,0,1,5,21,84,330,1287,0,1,9,56,300,1485,7007,0,1,14,120,825,5005,28028,0,1,20,225,1925,14014,91728,0,1,27,385,4004,34398,259896,0,1,35,616,7644,76440,659736}
238	113	1	f3bd45e9a8669e03662520ac1fc04e96fda44f731e04b914308c3d5f2cf59268	{None,0,0,0,0,0,0,1,1,1,1,1,1,1,1,2,3,4,5,6,7,1,3,6,10,15,21,28,1,4,10,20,35,56,84,1,5,15,35,70,126,210,1,6,21,56,126,252,462}
239	114	1	7e83b2c55d68c3c566de753211bb939d637370e8dedcf5c71477e35cef7b5fe2	{None,0,0,0,0,0,0,1,1,1,1,1,1,1,2,4,6,8,10,12,14,5,15,30,50,75,105,140,14,56,140,280,490,784,1176,42,210,630,1470,2940,5292,8820,132,792,2772,7392,16632,33264,60984}
240	115	1	6d8fe457c3421a7b7ec9fdcb9fe500f2dc83ffe804a543e99b7eb44bb31fefa9	{1,0,0,0,0,0,0,2,2,2,2,2,2,2,5,12,21,32,45,60,77,14,56,144,300,550,924,1456,42,240,825,2200,5005,10192,19110,132,990,4290,14014,38220,91728,199920,429,4004,21021,81536,259896,719712,1790712}
241	116	1	e41e38101eb98600a8e39ed2e17bf83fd587ccb92f880b56df1c534c8adf7006	{1,0,0,0,0,0,0,2,2,2,2,2,2,2,3,8,15,24,35,48,63,4,20,60,140,280,504,840,5,40,175,560,1470,3360,6930,6,70,420,1764,5880,16632,41580,7,112,882,4704,19404,66528,198198}
242	117	1	4d3908f27071f27b72a92faeb1aaad2fc8056bffd06836e6175c037b75677069	{1,1,0,0,0,0,0,2,0,0,0,0,0,0,-2,0,0,0,0,0,0,4,0,0,0,0,0,0,-10,0,0,0,0,0,0,28,0,0,0,0,0,0,-84,0,0,0,0,0,0}
248	125	1	5d96a690a9b93e800ab460e8a52b780a893c7f9aefd3965815238f4ca1baa684	{1,1,0,0,0,0,0,0,2,0,0,0,0,0,0,0,-2,0,0,0,0,0,0,0,4,0,0,0,0,0,0,0,-10,0,0,0,0,0,0,0,28,0,0,0,0,0,0,0,-84}
249	126	1	d660e2bd4f6ccd0be253b30b380f46afb58b60375a71bf736a4a77a8e253784d	{1,1,1,1,1,1,1,0,2,4,6,8,10,12,0,0,2,6,12,20,30,0,0,0,0,0,0,0,0,0,0,0,-2,-10,-30,0,0,0,0,0,0,0,0,0,0,0,0,0,4}
250	131	1	2d3ee95a9f9da914b0c31fe7c73f41a3a711da9ae64885d7a21b0e9d3af36b78	{0,0,0,0,0,0,0,0,0,0,0,0,0,0,5,6,5,0,None,None,None,14,18,18,14,0,None,None,42,56,60,56,42,0,None,132,180,200,200,180,132,0,429,594,675,700,675,594,429}
253	134	1	90e91ce567b3fd1a8ec397014f171282d9d74b1fbc9a27d136b390f611ab6bd6	{0,0,0,1,0,0,0,0,0,3,0,0,0,0,0,3,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
254	135	1	56a7b878b5082964732838db97dfb711eae72b820e01c53da0e973706c82b5ac	{0,0,0,0,1,0,0,0,0,0,4,0,0,0,0,0,6,0,0,0,0,0,4,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
255	136	1	52765046664507eee02c7b32e7ac3c6c137bfcc356f1bcf2be1cbd4fdab9ba24	{1,-1,1,-1,1,-1,1,-2,4,-6,8,-10,12,-14,5,-15,30,-50,75,-105,140,-14,56,-140,280,-490,784,-1176,42,-210,630,-1470,2940,-5292,8820,-132,792,-2772,7392,-16632,33264,-60984,429,-3003,12012,-36036,90090,-198198,396396}
257	138	1	cea6881a3c446acbcea9b928f36bdb899cb9e87e0bf17b5a35927b9c0dd99963	{1,1,1,1,1,1,1,2,6,20,70,252,924,3432,5,28,135,616,2730,11880,51051,14,120,770,4368,23100,116688,570570,42,495,4004,27300,168300,969969,5325320,132,2002,19656,157080,1108536,7189182,43835792,429,8008,92820,852720,6789783,48992944,328768440}
259	140	1	c168232882bf638dd0626d746112c6a62b2ca551de6cd36858c7dc03e0e9cc44	{1,-1,1,-1,1,-1,1,-1,2,-3,4,-5,6,-7,2,-6,12,-20,30,-42,56,-5,20,-50,100,-175,280,-420,14,-70,210,-490,980,-1764,2940,-42,252,-882,2352,-5292,10584,-19404,132,-924,3696,-11088,27720,-60984,121968}
260	141	1	e349afde201bf2a4f3093c8ddfd6b8c44dfc69b9ef2022f029879a4377189aaf	{1,-1,2,-5,14,-42,132,-1,2,-6,20,-70,252,-924,1,-3,12,-50,210,-882,3696,-1,4,-20,100,-490,2352,-11088,1,-5,30,-175,980,-5292,27720,-1,6,-42,280,-1764,10584,-60984,1,-7,56,-420,2940,-19404,121968}
196	71	1	801571da80b2ffd4d2135697f57f1db3a9300d2744af686442c542119f5be50c	{1,2,3,4,5,6,7,1,6,21,56,126,252,462,2,20,110,440,1430,4004,10010,5,70,525,2800,11900,42840,135660,14,252,2394,15960,83790,368676,1413258,42,924,10626,85008,531300,2762760,12432420,132,3432,46332,432432,3135132,18810792,97189092}
197	72	1	8c2d65d5f25d33dbbe50887bf0a2214364d3f2730944eff8fb0cb5ef3937bb55	{1,2,3,4,5,6,7,1,2,3,4,5,6,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
199	74	1	9981e8135d0355f1d12f4e1b5f4c7d0c2c17d14812aa4a1aa23956b8d06ad77f	{1,1,0,0,0,0,0,2,2,0,0,0,0,0,3,3,0,0,0,0,0,4,4,0,0,0,0,0,5,5,0,0,0,0,0,6,6,0,0,0,0,0,7,7,0,0,0,0,0}
200	75	1	9fa18741e22624af9eb98459b91e2f10c79f987e006e994b5b98926fe383cc6b	{1,1,-1,2,-5,14,-42,2,0,2,-8,30,-112,420,3,0,-1,12,-75,392,-1890,4,0,0,-8,100,-784,5040,5,0,0,2,-75,980,-8820,6,0,0,0,30,-784,10584,7,0,0,0,-5,392,-8820}
202	77	1	1f3aa29de8298f1be034b75a3f8c63dfa1393588848d5e5a2e28a1b4b130fbf3	{1,1,2,5,14,42,132,2,6,20,70,252,924,3432,3,21,110,525,2394,10626,46332,4,56,440,2800,15960,85008,432432,5,126,1430,11900,83790,531300,3135132,6,252,4004,42840,368676,2762760,18810792,7,462,10010,135660,1413258,12432420,97189092}
205	80	1	9932942013d09425b765f21ad4d0b53a6060501b19bfaf134489e2ac864948d7	{1,1,1,1,1,1,1,2,4,6,8,10,12,14,1,6,15,28,45,66,91,0,4,20,56,120,220,364,0,1,15,70,210,495,1001,0,0,6,56,252,792,2002,0,0,1,28,210,924,3003}
204	79	1	f6d8957d19a04bf75cf2ecb4556d4035888ab4abad576142c2143ec4aaf482f1	{None,1,-1,2,-5,14,-42,2,0,2,-8,30,-112,420,1,0,-3,20,-105,504,-2310,0,0,4,-40,280,-1680,9240,0,0,-5,70,-630,4620,-30030,0,0,6,-112,1260,-11088,84084,0,0,-7,168,-2310,24024,-210210}
206	81	1	dbf447fd4943732b43d8c7d760dc654cad1d9a615260ff2c5f4a3fcd6226a5e5	{1,1,0,0,0,0,0,2,4,2,0,0,0,0,5,15,15,5,0,0,0,14,56,84,56,14,0,0,42,210,420,420,210,42,0,132,792,1980,2640,1980,792,132,429,3003,9009,15015,15015,9009,3003}
209	84	1	5f8843c8c416b3c90b288bc1ba664569f2b435820e13acb833cdfbf458076eaf	{1,1,1,1,1,1,1,1,2,3,4,5,6,7,-1,-1,0,2,5,9,14,2,2,1,0,0,2,7,-5,-5,-3,-1,0,0,0,14,14,9,4,1,0,0,-42,-42,-28,-14,-5,-1,0}
208	83	1	6cfe2412c741be2dad949b0bcf24850f8b796a1a3c5d8f8d2e51c0f2fe4206f2	{1,1,0,0,0,0,0,1,1,0,0,0,0,0,-1,-1,0,0,0,0,0,2,2,0,0,0,0,0,-5,-5,0,0,0,0,0,14,14,0,0,0,0,0,-42,-42,0,0,0,0,0}
210	85	1	e5f3fec32fa252280b7ca1da814fa873fc1c4492a3abb7fd1c127ee25f3da818	{1,None,None,None,None,None,None,1,3,10,35,126,462,1716,-1,0,10,70,378,1848,8580,2,1,0,35,420,3234,20592,-5,-3,0,0,126,2310,24024,14,9,2,0,0,462,12012,-42,-28,-10,0,0,0,1716}
211	86	1	1066646942a3a4c23a5c4d0f1a584b7b8e4de1ff169f6f4b00c5d19400ce3e40	{1,1,0,0,0,0,0,2,2,0,0,0,0,0,6,6,0,0,0,0,0,20,20,0,0,0,0,0,70,70,0,0,0,0,0,252,252,0,0,0,0,0,924,924,0,0,0,0,0}
216	91	1	1b57bf78f561d9095e1c7f36f3f89ae0188066d194346853c63c28838bb05068	{0,1,2,3,4,5,6,1,4,9,16,25,36,49,2,9,24,50,90,147,224,3,16,50,120,245,448,756,4,25,90,245,560,1134,2100,5,36,147,448,1134,2520,5082,6,49,224,756,2100,5082,11088}
214	89	1	6901f66091f8d4e24ad18055ca8f37d9c3297e9199452b32c022cd9239ab5839	{1,1,1,2,5,14,42,1,2,6,20,70,252,924,1,6,30,140,630,2772,12012,2,20,140,840,4620,24024,120120,5,70,630,4620,30030,180180,1021020,14,252,2772,24024,180180,1225224,7759752,42,924,12012,120120,1021020,7759752,54318264}
213	88	1	bf4c68856e7f51a17882a234a05c0fbaf5393c004926ccd72bd13c2926aa5b55	{1,1,2,5,14,42,132,2,6,20,70,252,924,3432,6,30,140,630,2772,12012,51480,20,140,840,4620,24024,120120,583440,70,630,4620,30030,180180,1021020,5542680,252,2772,24024,180180,1225224,7759752,46558512,924,12012,120120,1021020,7759752,54318264,356948592}
217	92	1	de05cdb93e9d6cb4855a4d5a8d8a8d76269290f297f8a116842a348487d91e90	{0,1,1,0,0,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
218	93	1	81c34b85de53053a4eb292275943a6ab21a2267996f6330ae77605b4eff4d812	{0,1,2,5,14,42,132,1,4,15,56,210,792,3003,2,15,84,420,1980,9009,40040,5,56,420,2640,15015,80080,408408,14,210,1980,15015,100100,612612,3527160,42,792,9009,80080,612612,4232592,27159132,132,3003,40040,408408,3527160,27159132,192203088}
219	94	1	83abec2dcd0ff0ae4f54e68d918642d173e6bf27b8cc0008996f541155f1289d	{0,1,2,6,20,70,252,1,4,18,80,350,1512,6468,2,18,120,700,3780,19404,96096,6,80,700,5040,32340,192192,1081080,20,350,3780,32340,240240,1621620,10210200,70,1512,19404,192192,1621620,12252240,85357272,252,6468,96096,1081080,10210200,85357272,651819168}
221	96	1	9365e4df9e9da868c677224baf61475f4ef301c7d70fb9acd9ed8cbbad24a05c	{0,1,3,18,126,944,7370,1,6,54,504,4724,44225,412775,3,54,756,9449,110564,1238327,13444703,18,504,9449,147419,2063879,26889407,332756424,126,4724,110564,2063879,33611759,499134636,6932425500,944,44225,1238327,26889407,499134636,8318910600,128111223240,7370,412775,13444703,332756424,6932425500,128111223240,2166244320240}
251	132	1	c58485d882287dc463ff1867210966afd793b7910063404fca6fab1f96ad72da	{None,0,0,0,0,0,0,3,None,0,0,0,0,0,9,12,None,0,0,0,0,28,42,42,None,0,0,0,90,144,162,144,None,0,0,297,495,594,594,495,None,0,1001,1716,2145,2288,2145,1716,None}
224	99	1	0c9a6fd5e0f5303622f0f76fcd5c779ae15c4a895b26c09396b4b78440c94677	{1,1,1,1,1,1,1,0,0,0,0,0,0,0,2,6,12,20,30,42,56,0,0,0,0,0,0,0,6,30,90,210,420,756,1260,0,0,0,0,0,0,0,20,140,560,1680,4200,9240,18480}
317	201	1	63b9722b0736e9c86bcdb6214ac367bb7cd0b454918338df96278ca407a6e4b5	{1,1,1,1,1,1,1,-1,0,1,2,3,4,5,0,0,1,3,6,10,15,0,0,1,4,10,20,35,0,0,1,5,15,35,70,0,0,1,6,21,56,126,0,0,1,7,28,84,210}
318	202	1	e1d673ad5fe4eddc5cb367ce2fd9892c9564ab8c787ffc869627c30a49841d8d	{-1,-2,2,3,4,5,6,0,-1,3,4,5,6,7,-3,-2,4,5,6,7,8,2,-5,5,6,7,8,9,-5,5,6,7,8,9,10,4,6,7,8,9,10,11,-7,7,8,9,10,11,12}
319	203	1	c9085e59d7a591fd5edc992faee519335c1a956ce4267a7823700f9809312c4c	{1,1,0,0,0,0,0,-1,0,1,0,0,0,0,1,0,1,2,0,0,0,-1,0,0,4,5,0,0,1,0,0,2,15,14,0,-1,0,0,0,15,56,42,1,0,0,0,5,84,210}
321	205	1	b14376f98902a1f5b986bd5b9c6f04420f9dba8a66c83300c49543e884820aad	{1,1,2,5,14,42,132,2,2,4,10,28,84,264,3,3,6,15,42,126,396,4,4,8,20,56,168,528,5,5,10,25,70,210,660,6,6,12,30,84,252,792,7,7,14,35,98,294,924}
322	206	1	ea7284d23fda3a9aa3a024a6d2145399d726b7acae534e47d0b18284f086e21c	{1,1,1,1,1,1,1,2,0,-2,-4,-6,-8,-10,3,0,1,6,15,28,45,4,0,0,-4,-20,-56,-120,5,0,0,1,15,70,210,6,0,0,0,-6,-56,-252,7,0,0,0,1,28,210}
323	207	1	3c9cff586027569970b7f3a462599f0b513089ea4b3aff0818fbb0e5e0c81be2	{1,1,0,0,0,0,0,2,-2,0,0,0,0,0,3,1,0,0,0,0,0,4,0,0,0,0,0,0,5,0,0,0,0,0,0,6,0,0,0,0,0,0,7,0,0,0,0,0,0}
324	208	1	df04739c38cdadc1f572286643ad7a99691898f9def3bbb996303461422861f2	{1,1,0,0,0,0,0,2,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
261	142	1	f2cf0b9f74d51ffcb68bdf86b3ada132e70045cda7cc5e8520da2beec741e1f1	{1,-1,1,-1,1,-1,1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
262	143	1	6ade209f872824f7a02fef9537247572d3a93f164117ee516b288d081ae88f28	{1,1,1,1,1,1,1,1,1,1,1,1,1,1,-1,-1,-1,-1,-1,-1,-1,2,2,2,2,2,2,2,-5,-5,-5,-5,-5,-5,-5,14,14,14,14,14,14,14,-42,-42,-42,-42,-42,-42,-42}
265	146	1	24ce02bfa06f8f952eff3e6d64eca747508cd3e859c019383403cee2db46fe44	{1,1,0,0,0,0,0,1,3,3,1,0,0,0,1,5,10,10,5,1,0,1,7,21,35,35,21,7,1,9,36,84,126,126,84,1,11,55,165,330,462,462,1,13,78,286,715,1287,1716}
266	147	1	55233b7f4760295223f1be476df2dd6467f1e8a00929ea4f77edabbae3a027f9	{1,0,0,0,0,0,0,1,2,1,0,0,0,0,1,4,6,4,1,0,0,1,6,15,20,15,6,1,1,8,28,56,70,56,28,1,10,45,120,210,252,210,1,12,66,220,495,792,924}
267	148	1	d44c9bbdec9f00c5fac919789c62294177976bc4d4ce8ce77133f87957bb4714	{1,0,0,0,0,0,0,1,2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
268	149	1	03fe478546a7faaf1d3b6c8cce1944b3c5844c404fba216fe53b6c00ecbf8786	{1,0,0,0,0,0,0,1,2,1,0,0,0,0,0,2,6,6,2,0,0,0,0,5,20,30,20,5,0,0,0,14,70,140,140,0,0,0,0,42,252,630,0,0,0,0,0,132,924}
271	152	1	0d6dc60766d4b20c1bd5c650d5b4ebae3ae46f9891d041b226c67e99640dd04d	{1,None,0,0,0,0,0,1,2,None,0,0,0,0,1,2,0,None,-1,0,0,1,2,0,0,None,6,2,1,2,0,0,0,None,-28,1,2,0,0,0,0,None,1,2,0,0,0,0,0}
270	151	1	181c5dc04a7c05ecc671d6b1a4d83a34ae591ff0ac2a79032da93c9f1eea4160	{1,0,0,0,0,0,0,1,2,1,0,0,0,0,2,8,12,8,2,0,0,5,30,75,100,75,30,5,14,112,392,784,980,784,392,42,420,1890,5040,8820,10584,8820,132,1584,8712,29040,65340,104544,121968}
272	153	1	d1ca4c1b41b980eb4b44d940d28be0bb271ebcc84cfe9197d50a0b53be218ae7	{1,0,0,0,0,0,0,1,3,3,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
274	155	1	ebc8942c1f5b372d57d167299b899d90b9f2aa11fdc959863b0d6a2d08549349	{1,0,0,0,0,0,0,1,3,3,1,0,0,0,2,12,30,40,30,12,2,5,45,180,420,630,630,420,14,168,924,3080,6930,11088,12936,42,630,4410,19110,57330,126126,210210,132,2376,20196,107712,403920,1130976,2450448}
276	157	1	679d7ffeaacde62e106661d512b11887996929d9a7b8f5c8c721ffe8effefadd	{1,0,0,0,0,0,0,1,2,1,0,0,0,0,-1,-4,-6,-4,-1,0,0,2,12,30,40,30,12,2,-5,-40,-140,-280,-350,-280,-140,14,140,630,1680,2940,3528,2940,-42,-504,-2772,-9240,-20790,-33264,-38808}
275	156	1	76d318fc33e26ec048bbc1ad9b88be0b81c8a169e4e82c6b6d1ccb3c5d6f5d86	{1,0,0,0,0,0,0,1,3,3,1,0,0,0,-1,-6,-15,-20,-15,-6,-1,2,18,72,168,252,252,168,-5,-60,-330,-1100,-2475,-3960,-4620,14,210,1470,6370,19110,42042,70070,-42,-756,-6426,-34272,-128520,-359856,-779688}
277	158	1	4e893eec602ae418cf7a2bb306e934fb3774029e39f2a5acc2c2f8572e6494b6	{1,1,0,0,0,0,0,0,2,0,0,0,0,0,0,3,0,0,0,0,0,0,4,0,0,0,0,0,0,5,0,0,0,0,0,0,6,0,0,0,0,0,0,7,0,0,0,0,0}
280	161	1	6029e9221334e748851dd503b57b9c52197d34324baf93fa81b6aa07e604ecad	{1,1,-1,2,-5,14,-42,0,2,-4,12,-40,140,-504,0,3,-10,42,-180,770,-3276,0,4,-20,112,-600,3080,-15288,0,5,-35,252,-1650,10010,-57330,0,6,-56,504,-3960,28028,-183456,0,7,-84,924,-8580,70070,-519792}
281	162	1	699c39700bcaf9fe0cdd3b0e0eee977373386f9da7547520b73f197debdf832c	{1,1,0,0,0,0,0,0,3,0,0,0,0,0,0,6,0,0,0,0,0,0,10,0,0,0,0,0,0,15,0,0,0,0,0,0,21,0,0,0,0,0,0,28,0,0,0,0,0}
283	164	1	a3d006b5c434bd6ddf5a8ce9acd1d1a5722c6c39370e518d14190d438484b484	{1,1,2,5,14,42,132,1,3,12,45,168,630,2376,0,6,42,225,1092,5040,22572,0,10,112,825,5096,28560,150480,0,15,252,2475,19110,128520,790020,0,21,504,6435,61152,488376,3476088,0,28,924,15015,173264,1627920,13325004}
284	165	1	8045edacf1f420283fc6402a3a23c22057e58cd9e5fe31bef65db0e02845e5cd	{1,1,-1,2,-5,14,-42,0,3,-6,18,-60,210,-756,0,6,-21,90,-390,1680,-7182,0,10,-56,330,-1820,9520,-47880,0,15,-126,990,-6825,42840,-251370,0,21,-252,2574,-21840,162792,-1106028,0,28,-462,6006,-61880,542640,-4239774}
285	166	1	9c4c9a29d826d2f60065a1d84097a12f7e0aecf81ff32e68e0fea367d3ac8c2d	{1,1,0,0,0,0,0,1,2,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
287	168	1	300ce6340e91fcb8f1993e1ff28e88b3427dc8253d649993b4f4976f36f0a5d5	{1,1,2,5,14,42,132,1,4,14,50,182,672,2508,0,6,42,225,1092,5040,22572,0,4,70,600,4004,23520,127908,0,1,70,1050,10010,76440,511632,0,0,42,1260,18018,183456,1534896,0,0,14,1050,24024,336336,3581424}
289	170	1	2f1efe087b01b29352a2b522f100c361eceb368dbd0fbde412141c2e7fa7f144	{1,1,0,0,0,0,0,1,3,2,0,0,0,0,1,6,10,5,0,0,0,1,10,30,35,14,0,0,1,15,70,140,126,42,0,1,21,140,420,630,462,132,1,28,252,1050,2310,2772,1716}
290	171	1	8a315b18eedefcf709d0b07504438bd026933bd98304cf3b9936b4ccf151044e	{1,1,1,1,1,1,1,2,3,4,5,6,7,8,3,6,10,15,21,28,36,4,10,20,35,56,84,120,5,15,35,70,126,210,330,6,21,56,126,252,462,792,7,28,84,210,462,924,1716}
291	172	1	43f57b35a5f25c3b2cf400e250c9b9024b6a4f805c2ba7d5683283dc8defdab7	{1,1,2,5,14,42,132,2,5,16,55,196,714,2640,3,15,72,330,1470,6426,27720,4,35,240,1430,7840,40698,203280,5,70,660,5005,33320,203490,1168860,6,126,1584,15015,119952,854658,5610528,7,210,3432,40040,379848,3133746,23377200}
306	188	1	a8685b61b51dc75cc6eee90d9eac50da69a43942cba490a6b391cc46e33150e1	{1,-1,2,-5,14,-42,132,-1,4,-15,56,-210,792,-3003,2,-15,84,-420,1980,-9009,40040,-5,56,-420,2640,-15015,80080,-408408,14,-210,1980,-15015,100100,-612612,3527160,-42,792,-9009,80080,-612612,4232592,-27159132,132,-3003,40040,-408408,3527160,-27159132,192203088}
294	175	1	f43a3e26ba0329bcfa0ad908482f516f53ea2d53992d34762a018a67b8e055a5	{1,1,1,1,1,1,1,1,4,7,10,13,16,19,0,6,21,45,78,120,171,0,4,35,120,286,560,969,0,1,35,210,715,1820,3876,0,0,21,252,1287,4368,11628,0,0,7,210,1716,8008,27132}
295	176	1	9ac014060245592fc661ffa6c3c4c9c443e9c04fd4e73252d4c33050076ab2c5	{1,1,2,5,14,42,132,1,5,18,65,238,882,3300,0,10,72,390,1904,8820,39600,0,10,168,1430,9520,55860,303600,0,5,252,3575,33320,251370,1669800,0,1,252,6435,86632,854658,7013160,0,0,168,8580,173264,2279088,23377200}
297	178	1	9ac60587b6e44bb0bb2de3cf7efd64a68c19bc583c706355b9db6c4ae42a0408	{1,1,0,0,0,0,0,2,-1,1,-1,1,-1,1,-1,3,-6,10,-15,21,-28,2,-10,30,-70,140,-252,420,-5,35,-140,420,-1050,2310,-4620,14,-126,630,-2310,6930,-18018,42042,-42,462,-2772,12012,-42042,126126,-336336}
298	179	1	820ab5064b28620b7a28ef1fd9ec5fdfbfcf23b4367dd4f7430004a31afa31a0	{1,1,1,1,1,1,1,2,1,1,1,1,1,1,-1,0,0,0,0,0,0,2,-1,0,0,0,0,0,-5,5,-1,0,0,0,0,14,-21,9,-1,0,0,0,-42,84,-56,14,-1,0,0}
300	182	1	8cd1e18f55ff1d0a0afa4553a01ff29ca26529ffc20255f1c01f8333c1b55535	{1,-1,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
302	184	1	2737449d5fb31acb97970c70d4f23f01cdd8ccc41f82a6253114d4c687558f59	{1,-1,0,0,0,0,0,-1,1,0,0,0,0,0,1,-1,0,0,0,0,0,-1,1,0,0,0,0,0,1,-1,0,0,0,0,0,-1,1,0,0,0,0,0,1,-1,0,0,0,0,0}
304	186	1	848e29a5137d622ef8eee315fc70dcdba836f2220450ef1c468dd6d4ae8c9366	{1,-1,2,-5,14,-42,132,-1,3,-10,35,-126,462,-1716,1,-6,30,-140,630,-2772,12012,-1,10,-70,420,-2310,12012,-60060,1,-15,140,-1050,6930,-42042,240240,-1,21,-252,2310,-18018,126126,-816816,1,-28,420,-4620,42042,-336336,2450448}
303	185	1	45affa3af313e510270ba42e3826a5fe3e1d9c2aced7bedca41fb49c8bfe2cba	{1,-1,1,-1,1,-1,1,-1,2,-3,4,-5,6,-7,1,-3,6,-10,15,-21,28,-1,4,-10,20,-35,56,-84,1,-5,15,-35,70,-126,210,-1,6,-21,56,-126,252,-462,1,-7,28,-84,210,-462,924}
305	187	1	e8c971ce5344fe9d8f4cb2ccef30a381b31af0c93cf252530881113ca991df55	{1,-1,1,-1,1,-1,1,-1,3,-6,10,-15,21,-28,2,-10,30,-70,140,-252,420,-5,35,-140,420,-1050,2310,-4620,14,-126,630,-2310,6930,-18018,42042,-42,462,-2772,12012,-42042,126126,-336336,132,-1716,12012,-60060,240240,-816816,2450448}
307	189	1	2d1cb04b16da8325c2bbfc016a9d7d832f5915845f92104265df89325eb74d26	{1,1,1,1,1,1,1,1,0,-1,-2,-3,-4,-5,1,0,0,1,3,6,10,1,0,0,0,-1,-4,-10,1,0,0,0,0,1,5,1,0,0,0,0,0,-1,1,0,0,0,0,0,0}
308	190	1	e8513e146b8a2d452a00e9a9b51a788aa4c49eff11470d6293cccd2f8172176e	{1,1,2,5,14,42,132,1,1,2,5,14,42,132,1,1,2,5,14,42,132,1,1,2,5,14,42,132,1,1,2,5,14,42,132,1,1,2,5,14,42,132,1,1,2,5,14,42,132}
309	191	1	32da57d5a299e6aea35c5caf273b86c6135cb63a12aac521ab07cfc735fcfffb	{1,1,2,5,14,42,132,1,2,5,14,42,132,429,2,6,18,56,180,594,2002,5,20,70,240,825,2860,10010,14,70,280,1050,3850,14014,50960,42,252,1134,4620,18018,68796,259896,132,924,4620,20328,84084,336336,1319472}
313	197	1	701eda68d3146288be4eac955b49b8f4637bc9774ff1944fd47717f398930d50	{1,1,2,5,14,42,132,1,0,-2,-10,-42,-168,-660,1,0,0,5,42,252,1320,1,0,0,0,-14,-168,-1320,1,0,0,0,0,42,660,1,0,0,0,0,0,-132,1,0,0,0,0,0,0}
314	198	1	c741b5fef2789572dbe1a7c846dcaa4466f1b448ffb9d0d9f0945ef71404b8c1	{1,1,0,0,0,0,0,1,-2,0,0,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0}
315	199	1	5c780d95ef9e77429071c9fca1d53cb123d54f6d982b528d16af726f38807be1	{1,-1,0,0,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0}
356	245	1	57ec069fb47f6e5df55f58551486241156cfedd2cb983c16840b7935eaa1f1f9	{0,0,1,1,1,1,1,0,0,0,0,0,0,0,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
358	247	1	5bf7c72f7b8ab90faa21fa40a2f51c3d19e5b8c883d415987bd64ae9d8e151dc	{0,0,1,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
359	248	1	60ac6db4af95f56b8ee9ace3efdbb77cece3f65d50550388bc372834a4f98aa0	{0,1,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
377	268	1	333417de9366f753449490504552032ccf2d3a50465c756804564359df502320	{1,1,0,0,0,0,0,1,-1,1,-1,1,-1,1,0,1,-3,6,-10,15,-21,0,-1,6,-20,50,-105,196,0,1,-10,50,-175,490,-1176,0,-1,15,-105,490,-1764,5292,0,1,-21,196,-1176,5292,-19404}
380	273	1	22133c328a98141a9b1136f682b29385147d4f03c0b8d079b80cc6e52c2881b2	{0,1,1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
383	276	1	410b33d34b2d09ffdb322d8be9dd54c6ec070fe35809e530faaceedd18f74a14	{0,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
385	278	1	44ff9a0ffcbc438c305d4698f3d175724df1097700f2aa88fded8ba215f1abc9	{1,1,1,1,1,1,1,0,0,0,0,0,0,0,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
390	283	1	eb37e45ec39490404593fa9aee41c912cd26eb2e31d4eb23ac1ba096745a0616	{1,0,1,0,0,0,0,1,0,0,0,0,0,0,0,None,0,None,None,None,None,0,None,0,None,None,None,None,0,None,0,None,None,None,None,0,None,0,None,None,None,None,0,None,0,None,None,None,None}
327	211	1	5c213491133accf3ef179accbb07c5e065d8479edc79daa3ce5aedaaa51186e4	{1,2,6,20,70,252,924,2,12,60,280,1260,5544,24024,3,42,330,2100,11970,63756,324324,4,112,1320,11200,79800,510048,3027024,5,252,4290,47600,418950,3187800,21945924,6,504,12012,171360,1843380,16576560,131675544,7,924,30030,542640,7066290,74594520,680323644}
333	217	1	1bbe985fecd6abdee43c9cf8e90eb3c5814518a56fcd33e9334835e429d45294	{1,2,6,20,70,252,924,2,4,12,40,140,504,1848,3,6,18,60,210,756,2772,4,8,24,80,280,1008,3696,5,10,30,100,350,1260,4620,6,12,36,120,420,1512,5544,7,14,42,140,490,1764,6468}
329	213	1	d7f10ddc6a58fda100076c0812056a09bbf2157854881bd9414f84d6b535e0bc	{1,2,6,20,70,252,924,0,2,12,60,280,1260,5544,0,0,6,60,420,2520,13860,0,0,0,20,280,2520,18480,0,0,0,0,70,1260,13860,0,0,0,0,0,252,5544,0,0,0,0,0,0,924}
330	214	1	cb815547c719dfc31393ae947a6b3b624ad9b0623a43229eb2b38bb6d1281ea3	{1,2,6,20,70,252,924,0,4,24,120,560,2520,11088,0,2,36,300,1960,11340,60984,0,0,24,400,3920,30240,203280,0,0,6,300,4900,52920,457380,0,0,0,120,3920,63504,731808,0,0,0,20,1960,52920,853776}
331	215	1	fb00288deab9157ceb16fe6fe73c0e0463d961e69d258efeb92bbdf637ed455d	{1,2,6,20,70,252,924,1,2,6,20,70,252,924,1,2,6,20,70,252,924,1,2,6,20,70,252,924,1,2,6,20,70,252,924,1,2,6,20,70,252,924,1,2,6,20,70,252,924}
332	216	1	8549de251d61ccb1e3b885351ef00d279586fccf27da5cfe8daa84c19641f02c	{1,2,6,20,70,252,924,1,4,16,64,256,1024,4096,2,12,60,280,1260,5544,24024,4,40,239,1279,6400,30719,143360,14,140,980,5880,32340,168168,840840,42,503,4031,26880,161279,903168,4816895,132,1848,16632,121968,792792,4756752,26954928}
335	219	1	c78957921cb8d3d3ee3a5c019445eb3b143083c86fb01f10128b98a9d3663cbe	{1,1,0,0,0,0,0,2,2,0,0,0,0,0,5,5,0,0,0,0,0,14,14,0,0,0,0,0,42,42,0,0,0,0,0,132,132,0,0,0,0,0,429,429,0,0,0,0,0}
336	220	1	b19fcb224b764284c3c20013c9edbff41507829d509daf0002d16ffbd6cafec2	{1,1,1,1,1,1,1,2,4,6,8,10,12,14,5,14,27,44,65,90,119,14,48,110,208,350,544,798,42,165,429,910,1700,2907,4655,132,572,1638,3808,7752,14364,24794,429,2002,6188,15504,33915,67298,123970}
340	226	1	7de2cab673ed99cd18995f939b2eee0d22de8f9591eb4d0df08491e80f979648	{0,1,0,0,0,0,0,1,2,0,0,0,0,0,0,5,0,0,0,0,0,0,14,0,0,0,0,0,0,42,0,0,0,0,0,0,132,0,0,0,0,0,0,429,0,0,0,0,0}
341	227	1	e86f34ee5582419ed805c7ac83507869f1f3d547f45db725b36d4e6052d049b2	{0,1,0,0,0,0,0,1,2,0,0,0,0,0,0,3,0,0,0,0,0,0,4,0,0,0,0,0,0,5,0,0,0,0,0,0,6,0,0,0,0,0,0,7,0,0,0,0,0}
342	228	1	22b399494096aafc6345d0b47082cd4a9ae796918ebb273119899105e85dfa7c	{0,1,0,0,0,0,0,1,3,0,0,0,0,0,0,6,0,0,0,0,0,0,10,0,0,0,0,0,0,15,0,0,0,0,0,0,21,0,0,0,0,0,0,28,0,0,0,0,0}
344	230	1	9d421c326a70a00979a8c22fac694d49709a373803751f1c58292427764ea36c	{0,1,0,0,0,0,0,1,2,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
345	231	1	706b29d286daf0d0809e90af284040f85b17a29690c7cb381324ae4c45fc2141	{0,1,0,0,0,0,0,1,3,0,0,0,0,0,1,3,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
346	232	1	14a948a5ea1c30d64dbc98f2b89fb8cb83bdd58918507bda6098adad7175e595	{0,1,0,0,0,0,0,1,3,0,0,0,0,0,2,3,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
348	234	1	71d5e6906b85b7d2a20d521830ae49ae34a16d12fa6e72109073f46d0055c294	{0,1,0,0,0,0,0,1,3,0,0,0,0,0,0,3,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
349	235	1	f9e97985e1f9944962877e0d3a5d6a1199fb7ebae6a97c9f2b3cb6d6b8107d57	{0,1,0,0,0,0,0,1,1,0,0,0,0,0,1,1,0,0,0,0,0,1,1,0,0,0,0,0,1,1,0,0,0,0,0,1,1,0,0,0,0,0,1,1,0,0,0,0,0}
350	236	1	8b92a81cf52799b71adf801f421b45981df75cb2a583e2045d703de1e82efdde	{0,1,0,0,0,0,0,1,2,0,0,0,0,0,2,3,0,0,0,0,0,3,4,0,0,0,0,0,4,5,0,0,0,0,0,5,6,0,0,0,0,0,6,7,0,0,0,0,0}
351	238	1	52d8841c000ddfcc997557a242441ab9eaacf50328ace048772af7bbaac396ff	{0,1,0,0,0,0,0,1,2,0,0,0,0,0,1,3,0,0,0,0,0,1,4,0,0,0,0,0,1,5,0,0,0,0,0,1,6,0,0,0,0,0,1,7,0,0,0,0,0}
353	240	1	9cfa54cdb958ab1f85834579769bcab1bd986dfe940f3948755cd0629a4d74dc	{0,1,0,0,0,0,0,1,1,0,0,0,0,0,3,1,0,0,0,0,0,6,1,0,0,0,0,0,10,1,0,0,0,0,0,15,1,0,0,0,0,0,21,1,0,0,0,0,0}
355	244	1	ff1f85d615ca94b7eb4d67a99206bc4bbfbd0d62c325826bbd89d2d1497145dc	{1,0,1,0,1,0,1,0,0,0,0,0,0,0,1,0,2,0,3,0,4,0,0,0,0,0,0,0,1,0,3,0,6,0,10,0,0,0,0,0,0,0,1,0,4,0,10,0,20}
357	246	1	943a05c86f9c62cff8726b5579957011b066f6f304bddb01e27d8f01808c768b	{None,None,1,None,1,None,None,None,0,None,0,None,None,None,1,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,0,1,0,0,0,0,0,0,0,0,0,0,0,2,0,-4,0,2,0,0}
366	255	1	0c9a6fd5e0f5303622f0f76fcd5c779ae15c4a895b26c09396b4b78440c94677	{1,2,6,20,70,252,924,0,0,0,0,0,0,0,2,12,60,280,1260,5544,24024,0,0,0,0,0,0,0,6,60,420,2520,13860,72072,360360,0,0,0,0,0,0,0,20,280,2520,18480,120120,720720,4084080}
365	254	1	2a1c84dc80220a52c39fd52aaa5c6ec5cc401bb78f8f57e58121a1d0bdf22edf	{1,0,2,0,6,0,20,2,0,12,0,60,0,280,6,0,60,0,420,0,2520,20,0,280,0,2520,0,18480,70,0,1260,0,13860,0,120120,252,0,5544,0,72072,0,720720,924,0,24024,0,360360,0,4084080}
364	253	1	0c9a6fd5e0f5303622f0f76fcd5c779ae15c4a895b26c09396b4b78440c94677	{1,0,2,0,6,0,20,0,0,0,0,0,0,0,2,0,12,0,60,0,280,0,0,0,0,0,0,0,6,0,60,0,420,0,2520,0,0,0,0,0,0,0,20,0,280,0,2520,0,18480}
368	259	1	1e946af6d3373751c415bdb6aa95238454ad915eea54bbda2d10b2528d7de04c	{1,2,5,14,42,132,429,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
369	260	1	862a959128a464f235ccab1e7c6356a4d63df94a613d47239aa6ad83cd760687	{1,2,5,14,42,132,429,1,2,5,14,42,132,429,1,2,5,14,42,132,429,1,2,5,14,42,132,429,1,2,5,14,42,132,429,1,2,5,14,42,132,429,1,2,5,14,42,132,429}
371	262	1	ae9c6425d7adcdd3af7346779f4ab4fe00cfbce729b7ed850d727b10a033229c	{1,None,None,None,None,None,None,2,0,0,None,None,None,None,6,0,0,0,0,None,None,20,0,0,0,0,0,0,70,0,0,0,0,0,0,252,0,0,0,0,0,0,924,0,0,0,0,0,0}
372	263	1	3428d375490fef067a59909b3bb4c95f0d17bc391a850561e093ba4f847c9bd3	{1,1,1,1,1,1,1,2,2,2,2,2,2,2,6,6,6,6,6,6,6,20,20,20,20,20,20,20,70,70,70,70,70,70,70,252,252,252,252,252,252,252,924,924,924,924,924,924,924}
374	265	1	a948e54336005d6218c029e34f3a41b434c9cfa0f8d88335e3b9a15380d4dfd5	{1,-1,0,0,0,0,0,-1,0,0,0,0,0,0,1,0,0,0,0,0,0,-1,0,0,0,0,0,0,1,0,0,0,0,0,0,-1,0,0,0,0,0,0,1,0,0,0,0,0,0}
373	264	1	8945aeb82ab007da77545a5da6c4f7d65c8dcd4d2368d34669ec115bed12747f	{1,1,2,4,14,41,132,2,4,12,40,140,503,1848,6,16,60,239,980,4031,16632,20,64,280,1279,5880,26880,121968,70,256,1260,6400,32340,161279,792792,252,1024,5544,30719,168168,903167,4756752,924,4096,24024,143360,840840,4816895,26954928}
376	267	1	542e3feb6b901f6a827e51ead8fbaadf67afa177527692176208f4536f88455e	{1,1,2,5,14,42,132,0,0,0,0,0,0,0,1,4,15,56,210,792,3003,0,0,0,0,0,0,0,2,15,84,420,1980,9009,40040,0,0,0,0,0,0,0,5,56,420,2640,15015,80080,408408}
378	271	1	ef7bac0934c042dcd91514c66d4edb39aad872dca1c0abda7ee89e13ee044f21	{1,2,1,0,0,0,0,2,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
381	274	1	79c1191680b4e88b09483d7fdd39cec87f41caca62eb2c8f56a78f3afb22ed79	{0,0,0,1,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
379	272	1	c78c1baf18b6db2885ccd50d0adc45a4cc67d7583555ed593ed11be302be5669	{0,0,1,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
387	280	1	9fa9ca08a34de4f3c262a0064ce6c07425718642e8bd0aa171f2e177af8a6b5c	{1,1,1,1,1,1,1,0,0,0,0,0,0,0,1,3,6,10,15,21,28,0,0,0,0,0,0,0,2,10,30,70,140,252,420,0,0,0,0,0,0,0,5,35,140,420,1050,2310,4620}
388	281	1	552bc4f50cde1c70b1a90afba4fbb7117ba3a2fb223c1554cddae63c517da33d	{1,1,2,5,14,42,132,0,0,0,0,0,0,0,1,2,6,20,70,252,924,0,0,0,0,0,0,0,0,1,6,30,140,630,2772,0,0,0,0,0,0,0,0,0,2,20,140,840,4620}
389	282	1	7d9c22b838e3ab083a3aab0b806f223166809e242987470cdf1e3a97d71fbe6c	{1,1,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
401	315	1	4230f735e6d3b0c7deb0d4416f757609393c850d33d7a47ef77326035e3249c1	{0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,-2,1,0,0,0,0,-2,8,-12,8,-2,0,0,5,-30,75,-100,75,-30,5,-14,112,-392,784,-980,784,-392,42,-420,1890,-5040,8820,-10584,8820}
405	319	1	340d63d3ce46c2952ec1b2adc003b5a6b38ce4bc9d4baf69f472cc1444d70164	{1,2,3,4,5,6,7,1,-4,6,-4,1,0,0,-1,10,-45,120,-210,252,-210,2,-32,240,-1120,3640,-8736,16016,-5,110,-1155,7700,-36575,131670,-373065,14,-392,5292,-45864,286650,-1375920,5274360,-42,1428,-23562,251328,-1947792,11686752,-56485968}
406	320	1	6b7ce83228fb5ff2241f5c7dbacf19c58ba0c759e47ca07c71215285e924d789	{0,0,0,0,0,0,0,-1,4,-6,4,-1,0,0,1,-10,45,-120,210,-252,210,-2,32,-240,1120,-3640,8736,-16016,5,-110,1155,-7700,36575,-131670,373065,-14,392,-5292,45864,-286650,1375920,-5274360,42,-1428,23562,-251328,1947792,-11686752,56485968}
407	324	1	edcd3bf23e5c4893cae77c0f2948248e81162183658cd06d37e245ea5b913210	{0,0,0,0,0,0,0,-1,-3,-3,-1,0,0,0,1,6,15,20,15,6,1,-2,-18,-72,-168,-252,-252,-168,5,60,330,1100,2475,3960,4620,-14,-210,-1470,-6370,-19110,-42042,-70070,42,756,6426,34272,128520,359856,779688}
409	326	1	7879c5d9c969a9efe40e8dd679ed198932f72bb446e1f71a2d9a0191fe001584	{1,None,None,None,None,None,None,-1,-1,0,0,0,0,0,0,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-3,-1,0,0,0,0,-1,-6,-6,-1,0,0,0,-1,-10,-20,-10,-1,0}
410	327	1	4fa985d8d6f280b4b3934f3c7e364716f08a0944c6a2e119ba540e2ac3e37695	{1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,1,2,2,0,0,0,0,-1,-3,-6,-5,0,0,0,1,4,12,20,14,0,0,-1,-5,-20,-50,-70,-42,0,1,6,30,100,210,252,132}
413	330	1	5a3d726cf7fdd3199b90f17a09b825ed9243120d14146ca8d4bb6b8a1c9ba246	{1,1,0,0,0,0,0,-1,1,-1,1,-1,1,-1,0,1,-3,6,-10,15,-21,0,1,-6,20,-50,105,-196,0,1,-10,50,-175,490,-1176,0,1,-15,105,-490,1764,-5292,0,1,-21,196,-1176,5292,-19404}
445	362	1	744dbe751bbb2762c90d582c80c022e21b221c007e5b928f897af831c16686c6	{1,2,1,0,0,0,0,1,-2,3,-4,5,-6,7,-1,6,-21,56,-126,252,-462,2,-20,110,-440,1430,-4004,10010,-5,70,-525,2800,-11900,42840,-135660,14,-252,2394,-15960,83790,-368676,1413258,-42,924,-10626,85008,-531300,2762760,-12432420}
449	366	1	d4ea6888e229f2faefcbf2fd2ca6cdad2f24c53951bc87ca331aa8f509686380	{1,1,1,1,1,1,1,1,-1,0,0,0,0,0,-1,3,-3,1,0,0,0,2,-10,20,-20,10,-2,0,-5,35,-105,175,-175,105,-35,14,-126,504,-1176,1764,-1764,1176,-42,462,-2310,6930,-13860,19404,-19404}
391	298	1	9c0eb120459a4d4fb46ca71a4b13af87fca35969a3c3255568c60715da3ec900	{1,0,1,0,0,0,0,1,0,2,0,1,0,0,2,0,6,0,6,0,2,5,0,20,0,30,0,20,14,0,70,0,140,0,140,42,0,252,0,630,0,840,132,0,924,0,2772,0,4620}
395	308	1	43700f411e6d779e760a34907384dd55731a1f99b95a532c75c9ff09210a0b2c	{1,1,2,5,14,42,132,1,0,0,0,0,0,0,1,-1,-1,-2,-5,-14,-42,1,-2,-1,-2,-5,-14,-42,1,-3,0,-1,-3,-9,-28,1,-4,2,0,-1,-4,-14,1,-5,5,0,0,-1,-5}
396	309	1	bf72bee91da302b7b17a4c53dcb24d6c1039ae3ba7d9316209ed37bb5d9519ce	{1,1,2,5,14,42,132,1,-1,-1,-2,-5,-14,-42,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
397	311	1	b347c3c436be2d285e2099aad68a713a8eef00881e0b13dcb903f8fae4c88714	{1,1,1,1,1,1,1,1,0,0,0,0,0,0,1,-1,0,0,0,0,0,1,-2,1,0,0,0,0,1,-3,3,-1,0,0,0,1,-4,6,-4,1,0,0,1,-5,10,-10,5,-1,0}
399	313	1	93bcd940255ac3e185a0324155015641b46763ded2e766a0f94768d46a8f612a	{1,2,3,4,5,6,7,2,4,6,8,10,12,14,3,6,9,12,15,18,21,4,8,12,16,20,24,28,5,10,15,20,25,30,35,6,12,18,24,30,36,42,7,14,21,28,35,42,49}
400	314	1	b0167a848113c6a01b8ab9cc0b2d9f81dd9f78de377d1acc4dae35308012b6e5	{1,2,3,4,5,6,7,2,0,0,0,0,0,0,-1,2,-1,0,0,0,0,2,-8,12,-8,2,0,0,-5,30,-75,100,-75,30,-5,14,-112,392,-784,980,-784,392,-42,420,-1890,5040,-8820,10584,-8820}
402	316	1	204ed6cc97c3e227a493f5eb81175168213082ba38342790e8fae1333648ffb0	{1,2,3,4,5,6,7,1,2,3,4,5,6,7,2,4,6,8,10,12,14,5,10,15,20,25,30,35,14,28,42,56,70,84,98,42,84,126,168,210,252,294,132,264,396,528,660,792,924}
403	317	1	d1ac79cd722567c2c12c8d571b4e08a6f650474b9eb4ca9713f4c73b9ab63571	{1,2,3,4,5,6,7,1,0,0,0,0,0,0,1,-2,1,0,0,0,0,1,-4,6,-4,1,0,0,1,-6,15,-20,15,-6,1,1,-8,28,-56,70,-56,28,1,-10,45,-120,210,-252,210}
411	328	1	529c9ade1fea4879674f207c810bcdfb6a2923b746f1642fb17f1db3b01a37c4	{1,1,-1,2,-5,14,-42,-1,1,-3,10,-35,126,-462,1,0,-3,20,-105,504,-2310,-1,0,-1,20,-175,1176,-6930,1,0,0,10,-175,1764,-13860,-1,0,0,2,-105,1764,-19404,1,0,0,0,-35,1176,-19404}
412	329	1	ccf2a0cd544613d077d7b7d71b1ae20650ec0431b05fe2e5863d4b7c20458e95	{0,-1,1,-2,5,-14,42,0,-1,3,-10,35,-126,462,0,0,3,-20,105,-504,2310,0,0,1,-20,175,-1176,6930,0,0,0,-10,175,-1764,13860,0,0,0,-2,105,-1764,19404,0,0,0,0,35,-1176,19404}
415	332	1	5add34675e8cf717add601343ad554ff2fc73d5999593c8c82603afac95acdc9	{1,1,-1,2,-5,14,-42,1,1,-1,2,-5,14,-42,2,2,-2,4,-10,28,-84,5,5,-5,10,-25,70,-210,14,14,-14,28,-70,196,-588,42,42,-42,84,-210,588,-1764,132,132,-132,264,-660,1848,-5544}
417	334	1	f2e54999345c221b68e13ac9a49b4bd39696990775525c360f7b9c08408d06a5	{1,1,-1,2,-5,14,-42,1,-1,2,-5,14,-42,132,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
418	335	1	705a175dfcbbe303dc2bca19cd1fa1c186ce64c883261627a0720d5e4ef77973	{1,1,-1,2,-5,14,-42,1,-2,5,-14,42,-132,429,-1,5,-20,75,-275,1001,-3640,2,-16,88,-416,1820,-7616,31008,-5,55,-385,2200,-11220,53295,-241395,14,-196,1666,-11172,65170,-347116,1735580,-42,714,-7140,54978,-361284,2134860,-11695320}
419	336	1	997b475c016c65ba9f74077efe57ed72f012ee890daaa0ae83ee924e04c6bcd2	{0,0,0,0,0,0,0,-1,2,-5,14,-42,132,-429,1,-5,20,-75,275,-1001,3640,-2,16,-88,416,-1820,7616,-31008,5,-55,385,-2200,11220,-53295,241395,-14,196,-1666,11172,-65170,347116,-1735580,42,-714,7140,-54978,361284,-2134860,11695320}
422	339	1	e477b058638f9eb8f349f565976c498b94fcb2f32bbd20fd405b649bccbea003	{1,1,0,0,0,0,0,2,0,0,0,0,0,0,1,-1,1,-1,1,-1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
423	340	1	6faac5a7f49ed49e428f0f58e8c68b25be991a81a0cdee53190638277c1fc116	{1,1,1,1,1,1,1,2,2,2,2,2,2,2,1,0,0,0,0,0,0,0,-2,0,0,0,0,0,0,-1,5,0,0,0,0,0,0,6,-14,0,0,0,0,0,2,-28,42,0,0}
424	341	1	18a42d2cb322b0fb56c95458efeef28d1766a31e80812f84f3859c9242658b7f	{1,1,2,5,14,42,132,2,2,4,10,28,84,264,5,5,10,25,70,210,660,14,14,28,70,196,588,1848,42,42,84,210,588,1764,5544,132,132,264,660,1848,5544,17424,429,429,858,2145,6006,18018,56628}
426	343	1	608be03b935fdab18f1fb972d0932e4144ca065f5aacba8aa3a34fb0ddf28b2e	{1,1,0,0,0,0,0,2,-2,2,-2,2,-2,2,-3,9,-18,30,-45,63,-84,10,-50,150,-350,700,-1260,2100,-42,294,-1176,3528,-8820,19404,-38808,198,-1782,8910,-32670,98010,-254826,594594,-1001,11011,-66066,286286,-1002001,3006003,-8016008}
427	344	1	259e07cb7eb18587af0115a7d78a470907055e515c6db5fae219f86d084a4fba	{1,1,1,1,1,1,1,2,-2,0,0,0,0,0,-3,9,-9,3,0,0,0,10,-50,100,-100,50,-10,0,-42,294,-882,1470,-1470,882,-294,198,-1782,7128,-16632,24948,-24948,16632,-1001,11011,-55055,165165,-330330,462462,-462462}
429	346	1	7ef3a103b01bed2cf098af0c8e80cc44ed51516ae458eaf715e380ca20535705	{1,2,5,14,42,132,429,2,4,10,28,84,264,858,5,10,25,70,210,660,2145,14,28,70,196,588,1848,6006,42,84,210,588,1764,5544,18018,132,264,660,1848,5544,17424,56628,429,858,2145,6006,18018,56628,184041}
430	347	1	90dcb0456ed9f5fc374d9bdf4df11b9b100109701a8331d8988a5fd2f8bd9b67	{None,2,5,14,42,132,429,None,0,0,0,0,0,0,None,-2,-1,-2,-5,-14,-42,None,0,0,0,0,0,0,None,0,0,0,0,0,0,None,0,0,0,0,0,0,None,0,0,0,0,0,0}
432	349	1	ca2ae681c8a481779c6aa54810d8169be952c496f16eef7963eff4e8f0af63f6	{1,2,3,4,5,6,7,2,4,6,8,10,12,14,5,10,15,20,25,30,35,14,28,42,56,70,84,98,42,84,126,168,210,252,294,132,264,396,528,660,792,924,429,858,1287,1716,2145,2574,3003}
433	350	1	5a1acff6d793ac27a864348299c33340998a79339c252718076bbce7cca28795	{1,2,3,4,5,6,7,2,0,0,0,0,0,0,1,-2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
435	352	1	687ec33601bd1d8b062305534066c6671ae4319a0a04b6b59bd0959917da89af	{1,3,6,10,15,21,28,2,6,12,20,30,42,56,5,15,30,50,75,105,140,14,42,84,140,210,294,392,42,126,252,420,630,882,1176,132,396,792,1320,1980,2772,3696,429,1287,2574,4290,6435,9009,12012}
434	351	1	fa05e92ac5de686d54eb1efaf754ab83b02c0a4023aa99738456fdc0ea202c8a	{1,None,None,None,None,None,None,2,-4,2,0,0,0,0,-3,18,-45,60,-45,18,-3,10,-100,450,-1200,2100,-2520,2100,-42,588,-3822,15288,-42042,84084,-126126,198,-3564,30294,-161568,605880,-1696464,3675672,-1001,22022,-231231,1541540,-7322315,26360334,-74687613}
437	354	1	e1262a8870ef3de2843671ee1cfa2848c690674830742dca4ec838bd2cebac2e	{1,3,6,10,15,21,28,1,3,6,10,15,21,28,2,6,12,20,30,42,56,5,15,30,50,75,105,140,14,42,84,140,210,294,392,42,126,252,420,630,882,1176,132,396,792,1320,1980,2772,3696}
438	355	1	f1de02477dab6c55f11a186d477b572baae0b86497d9d87442dffe370b6686bf	{1,3,6,10,15,21,28,1,0,0,0,0,0,0,1,-3,3,-1,0,0,0,1,-6,15,-20,15,-6,1,1,-9,36,-84,126,-126,84,1,-12,66,-220,495,-792,924,1,-15,105,-455,1365,-3003,5005}
441	358	1	e6f2a485b9db7fac63422e357453d1dde467731c98f7a52186cf3499d5750a40	{1,2,1,0,0,0,0,1,4,6,4,1,0,0,2,12,30,40,30,12,2,5,40,140,280,350,280,140,14,140,630,1680,2940,3528,2940,42,504,2772,9240,20790,33264,38808,132,1848,12012,48048,132132,264264,396396}
442	359	1	25038bf9e0430ca48e0de0ea8d26a29f9abc45eb9f889e43cda16bb6974a461f	{1,2,5,14,42,132,429,1,4,15,56,210,792,3003,1,6,30,140,630,2772,12012,1,8,50,280,1470,7392,36036,1,10,75,490,2940,16632,90090,1,12,105,784,5292,33264,198198,1,14,140,1176,8820,60984,396396}
443	360	1	ea893edc408fd63f864a2c64b4f4b625b0eff39300fd7d140d91aed60d5da693	{1,2,1,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
444	361	1	5e7849b415c0c0810e75fc6a4ac0811ccd158244c9bfd4faf2a5efaa37532400	{1,2,5,14,42,132,429,1,2,6,20,70,252,924,0,0,1,6,30,140,630,0,0,0,0,2,20,140,0,0,0,0,0,0,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
447	364	1	4907165633ab76749ae062b040007c311d682a21b2be40431c51ad14ce9b3078	{1,2,1,0,0,0,0,1,-4,10,-20,35,-56,84,-2,20,-110,440,-1430,4004,-10010,7,-112,952,-5712,27132,-108528,379848,-30,660,-7590,60720,-379500,1973400,-8880300,143,-4004,58058,-580580,4499495,-28796768,158382224,-728,24752,-433160,5197920,-48080760,365413776,-2375189544}
448	365	1	b79fc975b64c4f273f665c3a8fbd7fdb73019c4a846d5009f1d6803d6c453c80	{1,1,0,0,0,0,0,1,-2,3,-4,5,-6,7,-2,10,-30,70,-140,252,-420,7,-56,252,-840,2310,-5544,12012,-30,330,-1980,8580,-30030,90090,-240240,143,-2002,15015,-80080,340340,-1225224,3879876,-728,12376,-111384,705432,-3527160,14814072,-54318264}
450	367	1	154c17bed7a28628deced6caff9165f3b2c4d6c610d826af3b1f27f6f71c7ea1	{0,0,0,0,0,0,0,-1,1,0,0,0,0,0,1,-3,3,-1,0,0,0,-2,10,-20,20,-10,2,0,5,-35,105,-175,175,-105,35,-14,126,-504,1176,-1764,1764,-1176,42,-462,2310,-6930,13860,-19404,19404}
451	368	1	ad4736ba91c1550b4df51a5cc08e0a874b436b03506f0a2e749ca4ebc5d3f5ca	{1,1,1,1,1,1,1,1,-2,1,0,0,0,0,-2,10,-20,20,-10,2,0,7,-56,196,-392,490,-392,196,-30,330,-1650,4950,-9900,13860,-13860,143,-2002,13013,-52052,143143,-286286,429429,-728,12376,-99008,495040,-1732640,4504864,-9009728}
453	370	1	41fd98088c682d991ae83e790fc8a9224bc42b98e4d858ecd4bdc1eea4852cf2	{1,2,3,4,5,6,7,1,-2,1,0,0,0,0,-1,6,-15,20,-15,6,-1,2,-20,90,-240,420,-504,420,-5,70,-455,1820,-5005,10010,-15015,14,-252,2142,-11424,42840,-119952,259896,-42,924,-9702,64680,-307230,1106028,-3133746}
454	372	1	a3c62c7652a5d6440abd706e33f9e816c5474af91523de82c29eee35369f011e	{1,1,-1,2,-5,14,-42,2,-2,6,-20,70,-252,924,3,1,-15,90,-455,2142,-9702,4,0,20,-240,1820,-11424,64680,5,0,-15,420,-5005,42840,-307230,6,0,6,-504,10010,-119952,1106028,7,0,-1,420,-15015,259896,-3133746}
455	373	1	ea7ee5165d3142140a5a0c4e8a483fbd9801fc29a7c91b5ec781755a5c61cc2a	{1,2,1,0,0,0,0,1,2,1,0,0,0,0,2,4,2,0,0,0,0,5,10,5,0,0,0,0,14,28,14,0,0,0,0,42,84,42,0,0,0,0,132,264,132,0,0,0,0}
466	386	1	74186fed06147c469dfa2ba23de586efb3a3ed27629d277c03c2252247986495	{1,2,1,0,0,0,0,1,2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
476	400	1	ed76730a5243f10830dbd28504990ea355d3dc13254eb6cc599aab2564f1e53a	{0,0,0,0,0,0,0,-1,0,0,0,0,0,0,1,-1,-1,-2,-5,-14,-42,-2,4,2,4,10,28,84,5,-15,0,-5,-15,-45,-140,-14,56,-28,0,14,56,196,42,-210,210,0,0,-42,-210}
480	406	1	66b18ed83c293b30fd149b6d04d616a6e361ae7942e2723a0b88e99e802458ec	{0,0,0,0,0,0,0,-1,0,0,0,0,0,0,1,-2,-1,-2,-5,-14,-42,-2,8,-4,0,2,8,28,5,-30,45,-10,0,0,-5,-14,112,-280,224,-28,0,0,42,-420,1470,-2100,1050,-84,0}
482	410	1	c799ecc21d52ddad139728a0c8455d633ad096f96924b634aab7006b49e28dc0	{0,0,0,0,0,0,0,1,0,0,0,0,0,0,-1,-1,-1,-4,-13,-42,-131,2,4,12,30,81,267,856,-5,-15,-37,-130,-438,-1473,-5012,14,56,224,634,2352,8052,28074,-42,-210,-735,-3290,-11392,-42210,-152705}
496	425	1	3d00522e746e12367f9686bb1dca8941f5595bcdfedc4a371211996694478b5a	{1,1,3,12,55,273,1428,1,-1,-2,-7,-30,-143,-728,-1,3,3,10,42,198,1001,2,-10,0,-10,-50,-252,-1320,-5,35,-35,0,35,245,1470,14,-126,252,-42,0,-126,-1176,-42,462,-1386,924,0,0,462}
497	426	1	b807e9477f2fd395c37af909ed06f0c911047b773f0d33b2d8c3bf426c5c00b0	{0,0,0,0,0,0,0,-1,1,2,7,30,143,728,1,-3,-3,-10,-42,-198,-1001,-2,10,0,10,50,252,1320,5,-35,35,0,-35,-245,-1470,-14,126,-252,42,0,126,1176,42,-462,1386,-924,0,0,-462}
499	433	1	089c3602578c205099decf3c6d40536d45d11af28951a04b88c28835c05f5c4b	{0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,-1,2,-5,14,-42,132,-2,4,-10,28,-84,264,-858,5,-15,45,-140,450,-1485,5005,-14,56,-196,672,-2310,8008,-28028,42,-210,840,-3150,11550,-42042,152880}
500	434	1	2812d4cfdad74d144da8ff721bda51db68303cc3fee7fc7e2e723806e5c27f25	{1,None,None,None,None,None,None,1,2,2,2,2,2,2,1,-1,-1,-1,-1,-1,-1,1,2,2,2,2,2,2,1,-5,-5,-5,-5,-5,-5,1,14,14,14,14,14,14,1,-42,-42,-42,-42,-42,-42}
501	435	1	c75fd949ca8e046013be76e1082952b3fcfc4d4a63706a0d64e7e60c2e486bf8	{0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,-1,1,-1,1,-1,1,-2,4,-6,8,-10,12,-14,5,-15,30,-50,75,-105,140,-14,56,-140,280,-490,784,-1176,42,-210,630,-1470,2940,-5292,8820}
503	437	1	9c7f066b08004880a5eb76171912eca610fd837622bcaa31c01b61644427ad67	{1,2,5,14,42,132,429,2,8,30,112,420,1584,6006,3,20,105,504,2310,10296,45045,4,40,280,1680,9240,48048,240240,5,70,630,4620,30030,180180,1021020,6,112,1260,11088,84084,576576,3675672,7,168,2310,24024,210210,1633632,11639628}
504	438	1	b635810d8e4a120aec1cfa96e3561b25297f8e953686262d3931a296a9cd7f4d	{1,None,None,None,None,None,None,1,2,2,2,2,2,2,1,-1,-1,-1,-1,-1,-1,1,2,2,2,2,2,2,1,-5,-5,-5,-5,-5,-5,1,14,14,14,14,14,14,1,-42,-42,-42,-42,-42,-42}
505	439	1	bb157956822b77e21330f56be550f9bdb680a4cc1e9351d96123dcfc4e358c24	{0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,-2,3,-4,5,-6,7,-2,8,-20,40,-70,112,-168,5,-30,105,-280,630,-1260,2310,-14,112,-504,1680,-4620,11088,-24024,42,-420,2310,-9240,30030,-84084,210210}
506	440	1	7b9494581aac59fc9d261825e988f306ddfcc84a379509fe831ac4a1acede559	{1,None,None,None,None,None,None,1,2,2,2,2,2,2,1,-1,-1,-1,-1,-1,-1,1,2,2,2,2,2,2,1,-5,-5,-5,-5,-5,-5,1,14,14,14,14,14,14,1,-42,-42,-42,-42,-42,-42}
508	442	1	9a359648ec89ecd6426c128514d47bea31d06ef0528d9bac5f416b0cebf29051	{1,3,6,10,15,21,28,2,6,12,20,30,42,56,3,9,18,30,45,63,84,4,12,24,40,60,84,112,5,15,30,50,75,105,140,6,18,36,60,90,126,168,7,21,42,70,105,147,196}
509	443	1	dd3830980f82a9a3d0b70c7957aee6a5bd00f4e451b2be8a6123f71ef7dc4394	{1,None,None,None,None,None,None,1,2,2,2,2,2,2,1,-1,-1,-1,-1,-1,-1,1,2,2,2,2,2,2,1,-5,-5,-5,-5,-5,-5,1,14,14,14,14,14,14,1,-42,-42,-42,-42,-42,-42}
512	446	1	b8a0eb0ecad1374ee1a90e5191866f27a2e79bb5ea6646dd80c941649acd0595	{0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,-1,-1,-2,-5,-14,-42,-2,4,2,4,10,28,84,5,-15,0,-5,-15,-45,-140,-14,56,-28,0,14,56,196,42,-210,210,0,0,-42,-210}
513	447	1	8d04fde9c31140350f8ce3bbf3e46bbf0157e87c9089b015df4fd2ce2e9341aa	{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,1,-2,0,0,0,0,0,1,-5,5,0,0,0,0,1,-9,21,-14,0,0,0,1,-14,56,-84,42,0,0}
514	448	1	a84a224bd0c002a6620b9d73c8057bd09deda6ff17da2f6f770d4be4d9db9693	{1,1,0,0,0,0,0,1,-1,1,-1,1,-1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
515	449	1	1e674317c65a19c835aa09efc216450d3746eba47b4aca3942e03095c050c342	{1,1,0,0,0,0,0,1,-2,3,-4,5,-6,7,-1,5,-15,35,-70,126,-210,2,-16,72,-240,660,-1584,3432,-5,55,-330,1430,-5005,15015,-40040,14,-196,1470,-7840,33320,-119952,379848,-42,714,-6426,40698,-203490,854658,-3133746}
517	451	1	c689f9e8908c1bdc76e2e61db85aeb215dd32515495bd5fd469e6d459009f098	{1,1,1,1,1,1,1,1,1,0,0,0,0,0,1,1,0,0,0,0,0,1,1,0,0,0,0,0,1,1,0,0,0,0,0,1,1,0,0,0,0,0,1,1,0,0,0,0,0}
518	452	1	a5c7dbcf690cf70fbd5dbe289bde5618911d2bd944566335f67898d1e0f3fe85	{1,1,1,1,1,1,1,0,1,2,3,4,5,6,0,-2,-3,-3,-2,0,3,0,7,10,10,8,5,2,0,-30,-42,-42,-35,-25,-15,0,143,198,198,168,126,84,0,-728,-1001,-1001,-858,-660,-462}
519	453	1	313fc49ad5265d1045f67224235010b20d5e019695b3d8e9e5bc9332ac1d354a	{1,2,1,0,0,0,0,1,0,0,0,0,0,0,1,-2,3,-4,5,-6,7,1,-4,10,-20,35,-56,84,1,-6,21,-56,126,-252,462,1,-8,36,-120,330,-792,1716,1,-10,55,-220,715,-2002,5005}
520	454	1	162c4db0556ccbfcc611f4f88262692a1d18df8f1c6e2ae2de90e10940fd3f48	{1,2,1,0,0,0,0,1,-2,3,-4,5,-6,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
458	376	1	afee2fbdf3aa37a5171a7a25a23fa034a54f183f427965e6efd0c4d5351dc3dc	{1,-2,None,None,None,None,None,None,-2,-2,-4,-10,-28,-84,None,0,0,0,0,0,0,None,0,0,0,0,0,0,None,0,0,0,0,0,0,None,0,0,0,0,0,0,None,0,0,0,0,0,0}
459	378	1	55d4627bc786ad7d4a53c1ad878d95eb271677952735b56831320fa7a09223ee	{0,0,0,0,0,0,0,-1,4,0,0,0,0,0,1,-10,30,-20,-10,-12,-20,-2,32,-192,512,-512,0,0,5,-110,990,-4620,11550,-13860,4620,-14,392,-4704,31360,-125440,301056,-401408,42,-1428,21420,-185640,1021020,-3675672,8576568}
461	381	1	209307b3eb9ac8d125611f51ee9ec36861a284e6b30b109357628c5e7b469a48	{-1,0,0,0,0,0,0,1,-1,1,-1,1,-1,1,-2,4,-6,8,-10,12,-14,5,-15,30,-50,75,-105,140,-14,56,-140,280,-490,784,-1176,42,-210,630,-1470,2940,-5292,8820,-132,792,-2772,7392,-16632,33264,-60984}
460	379	1	dbc9324e97b0dc3c95e967f44529d8113afe8f62c8cf41c45f52be3eb377d205	{None,2,6,20,70,252,924,1,-6,6,4,6,12,28,-2,28,-140,280,-140,-56,-56,7,-154,1386,-6468,16170,-19404,6468,-30,900,-11700,85800,-386100,1081080,-1801800,143,-5434,92378,-923780,6004570,-26420108,79260324,-728,33488,-703248,8907808,-75716368,454298208,-1968625568}
463	383	1	4680176e24078f79ea903e6cc092c297fa40c41a5fd8ef6bacbcbd582feb3442	{1,1,1,1,1,1,1,1,0,0,0,0,0,0,-1,1,0,0,0,0,0,2,-4,2,0,0,0,0,-5,15,-15,5,0,0,0,14,-56,84,-56,14,0,0,-42,210,-420,420,-210,42,0}
465	385	1	3a6e4eb6f986e86e6062ee96be5a45072b9fdae48d785e2a1883b9c51b77f295	{1,1,1,1,1,1,1,1,-1,0,0,0,0,0,-2,6,-6,2,0,0,0,7,-35,70,-70,35,-7,0,-30,210,-630,1050,-1050,630,-210,143,-1287,5148,-12012,18018,-18018,12012,-728,8008,-40040,120120,-240240,336336,-336336}
468	389	1	208309f4a73fae22791fa83a3b885d7701b8f48ba8272d93195ac3af42a697b2	{1,2,1,0,0,0,0,1,6,15,20,15,6,1,2,20,90,240,420,504,420,5,70,455,1820,5005,10010,15015,14,252,2142,11424,42840,119952,259896,42,924,9702,64680,307230,1106028,3133746,132,3432,42900,343200,1973400,8682960,30390360}
469	390	1	db8e438f9bbf652d97574185e69a93222a970e71fa7043bb25db6322c2293b5f	{1,2,1,0,0,0,0,1,0,0,0,0,0,0,-1,2,-3,4,-5,6,-7,2,-8,20,-40,70,-112,168,-5,30,-105,280,-630,1260,-2310,14,-112,504,-1680,4620,-11088,24024,-42,420,-2310,9240,-30030,84084,-210210}
470	391	1	6e64ff10aff185640a33bc12d750059248f9c2110f2d66604e9f89ebcd8d80ea	{0,0,0,0,0,0,0,-1,0,0,0,0,0,0,1,-2,3,-4,5,-6,7,-2,8,-20,40,-70,112,-168,5,-30,105,-280,630,-1260,2310,-14,112,-504,1680,-4620,11088,-24024,42,-420,2310,-9240,30030,-84084,210210}
471	392	1	b58f1b61a05d57ab39588ca74c7cf3eec8d0b379270212b648a2dff37c339f98	{1,2,1,0,0,0,0,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None}
472	395	1	21b13edeadd372dc1a56fe39676848613508aae07ab77619a1b49f563f11af3c	{1,2,6,20,70,252,924,1,6,30,140,630,2772,12012,2,20,140,840,4620,24024,120120,5,70,630,4620,30030,180180,1021020,14,252,2772,24024,180180,1225224,7759752,42,924,12012,120120,1021020,7759752,54318264,132,3432,51480,583440,5542680,46558512,356948592}
474	398	1	b6b96a8eb36c4cf9e7970e590db4c0d6d0e5fb5f7fced17e24de004e98dbb476	{1,2,6,20,70,252,924,1,-2,-2,-4,-10,-28,-84,-2,12,-12,-8,-12,-24,-56,7,-70,210,-140,-70,-84,-140,-30,420,-2100,4200,-2100,-840,-840,143,-2574,18018,-60060,90090,-36036,-12012,-728,16016,-144144,672672,-1681680,2018016,-672672}
475	399	1	a799d643375a235e345a608b4204ec5fc9c550dbf1b09408afad2f3350d7aa64	{1,None,None,None,None,None,None,None,0,0,0,0,0,0,None,1,1,2,5,14,42,None,-4,-2,-4,-10,-28,-84,None,15,0,5,15,45,140,None,-56,28,0,-14,-56,-196,None,210,-210,0,0,42,210}
481	407	1	0c8dc8459a7a967cedf09d9f165c264768a625390821747d56d8754f215395a2	{None,2,5,14,42,132,429,None,-2,-1,-2,-5,-14,-42,None,12,-18,4,0,0,2,None,-70,245,-350,175,-14,0,None,420,-2310,6300,-8820,5880,-1470,None,-2574,19305,-78078,184041,-254826,198198,None,16016,-152152,816816,-2722720,5829824,-8016008}
484	412	1	4c60c1e1909e0940fdadf1979e3d441fe3dd8c2da1b03a3c227fcd3266b1eb83	{1,1,-1,2,-5,14,-42,1,-1,2,-5,14,-42,132,-2,6,-18,56,-180,594,-2002,7,-35,140,-525,1925,-7007,25480,-30,210,-1050,4620,-19110,76440,-299880,143,-1287,7722,-39039,180180,-787644,3325608,-728,8008,-56056,320320,-1633632,7759752,-35147112}
485	413	1	78e641b01e17033192fd36d4c460ed70cee03ad6786a77df482492d783abfa8c	{1,1,-1,2,-5,14,-42,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
489	417	1	a630548e276c04d236f0d083b07184ba840c7ee400a72bd4abc0d2245981c9ba	{1,2,3,4,5,6,7,1,2,3,4,5,6,7,1,2,3,4,5,6,7,1,2,3,4,5,6,7,1,2,3,4,5,6,7,1,2,3,4,5,6,7,1,2,3,4,5,6,7}
488	416	1	392f66724343c5c11efb8da914d2bcf4b68db09d5953a42f755c635e4c5927a4	{1,None,None,None,None,None,None,1,None,None,None,None,None,None,-2,None,None,None,None,None,None,7,None,None,None,None,None,None,-30,None,None,None,None,None,None,143,None,None,None,None,None,None,-728,None,None,None,None,None,None}
492	420	1	72743a79f596d5fd9acf389738de134ce78eed7259fab785b6d2c0fc1c60a521	{None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None}
483	411	1	7f9fcec3e4d2777ca74ce5aa0135b2c413ea833ce43c058ee8dda6219d904ae2	{None,0,0,0,0,0,0,-1,0,0,0,0,0,0,1,1,1,4,13,42,131,-2,-4,-12,-30,-81,-267,-856,5,15,37,130,438,1473,5012,-14,-56,-224,-634,-2352,-8052,-28074,42,210,735,3290,11392,42210,152705}
495	424	1	586a2accc8ab71e2ca0f9128910dd7fbcd35ad7863c49069c3769ac950e08a77	{1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
493	421	1	c58485d882287dc463ff1867210966afd793b7910063404fca6fab1f96ad72da	{1,2,6,20,70,252,924,1,-2,-2,-4,-10,-28,-84,-1,6,-6,-4,-6,-12,-28,2,-20,60,-40,-20,-24,-40,-5,70,-350,700,-350,-140,-140,14,-252,1764,-5880,8820,-3528,-1176,-42,924,-8316,38808,-97020,116424,-38808}
521	455	1	11bedfe013f0e3d980698beaacb9f83179036247c0ab312533accffeb8c38948	{1,1,1,1,1,1,1,1,2,1,0,0,0,0,1,2,1,0,0,0,0,1,2,1,0,0,0,0,1,2,1,0,0,0,0,1,2,1,0,0,0,0,1,2,1,0,0,0,0}
522	456	1	2d8c1513e7ca12efa4ca358cd2115b4b83c140e3a6c4eee283d8f4c9d385956b	{0,0,0,0,0,0,0,-1,4,-10,20,-35,56,-84,1,-10,55,-220,715,-2002,5005,-2,32,-272,1632,-7752,31008,-108528,5,-110,1265,-10120,63250,-328900,1480050,-14,392,-5684,56840,-440510,2819264,-15505952,42,-1428,24990,-299880,2773890,-21081564,137030166}
523	458	1	1d75478119621783254bdeb68dedab67f4c09c898dd0b3dc4088250b4d2f66e2	{1,1,1,1,1,1,1,1,-2,1,0,0,0,0,-1,5,-10,10,-5,1,0,2,-16,56,-112,140,-112,56,-5,55,-275,825,-1650,2310,-2310,14,-196,1274,-5096,14014,-28028,42042,-42,714,-5712,28560,-99960,259896,-519792}
524	459	1	37d7f8f595adf5965ff99e9deb73c671934c786351c3b65aee85d57041707d53	{0,0,0,0,0,0,0,-1,2,-1,0,0,0,0,1,-5,10,-10,5,-1,0,-2,16,-56,112,-140,112,-56,5,-55,275,-825,1650,-2310,2310,-14,196,-1274,5096,-14014,28028,-42042,42,-714,5712,-28560,99960,-259896,519792}
526	461	1	87de94cb2eed0d560b03d3823dd8daa920b17e81a2cf67c8ace7ec93f11d52ca	{0,0,0,0,0,0,0,1,-4,6,-4,1,0,0,-1,10,-45,120,-210,252,-210,2,-32,240,-1120,3640,-8736,16016,-5,110,-1155,7700,-36575,131670,-373065,14,-392,5292,-45864,286650,-1375920,5274360,-42,1428,-23562,251328,-1947792,11686752,-56485968}
527	462	1	050382b23a64b584781c29adf02b2a5dd6ff76a7f45c06207d8f675d6456541a	{1,1,1,1,1,1,1,None,2,1,0,0,0,0,None,2,-1,0,0,0,0,None,2,-3,2,0,0,0,None,2,-5,6,-5,2,0,None,2,-7,14,-17,14,-7,None,2,-9,24,-42,50,-42}
528	463	1	6244b037a134cbb47ad953039c0e7c7874b7b05a430f2f5e81b3ca1a92274ece	{1,1,2,5,14,42,132,0,1,4,15,56,209,792,0,-2,-6,-15,-28,0,396,0,7,20,50,112,210,264,0,-30,-84,-210,-490,-1049,-1980,0,143,396,990,2352,5292,11088,0,-728,-2002,-5005,-12012,-27720,-60984}
530	465	1	11d87134e57653304b066e0631f479ed7576bf07b67b07b9f5b97c5632bcd77b	{1,1,1,1,1,1,1,None,1,-1,2,-5,14,-42,None,1,-1,2,-5,14,-42,None,1,-1,2,-5,14,-42,None,1,-1,2,-5,14,-42,None,1,-1,2,-5,14,-42,None,1,-1,2,-5,14,-42}
532	467	1	8c9bb62f10ee187c2c9f3c4738ed5309ec724078c463e20cc3835b72249efb75	{1,1,-2,7,-30,143,-728,1,1,-2,7,-30,143,-728,2,2,-4,14,-60,286,-1456,5,5,-10,35,-150,715,-3640,14,14,-28,98,-420,2002,-10192,42,42,-84,294,-1260,6006,-30576,132,132,-264,924,-3960,18876,-96096}
533	471	1	f654bb20d23f1d175b7882a8317b05bc4f29f69700b330116f9724b2a4d883c6	{0,0,0,0,0,0,0,-1,2,-7,30,-143,728,-3876,1,-5,25,-130,700,-3876,21945,-2,16,-104,640,-3876,23408,-141680,5,-55,440,-3135,21175,-139150,900900,-14,196,-1862,15092,-112700,802620,-5550426,42,-714,7854,-71400,584766,-4493202,33112464}
537	484	1	124eb750967a187cf8767ab9862687df1833c9d7c9c1970379bc50582b78d9e1	{1,None,None,None,None,None,None,1,2,2,2,2,2,2,1,-1,-1,-1,-1,-1,-1,1,2,2,2,2,2,2,1,-5,-5,-5,-5,-5,-5,1,14,14,14,14,14,14,1,-42,-42,-42,-42,-42,-42}
538	491	1	4cf5fa5fd02bbe8f0a047f06ba70da7477e24228f1cd74f8cc9f2c68feb56494	{1,1,1,1,1,1,1,1,3,6,10,15,21,28,1,5,15,35,70,126,210,1,7,28,84,210,462,924,1,9,45,165,495,1287,3003,1,11,66,286,1001,3003,8008,1,13,91,455,1820,6188,18564}
539	492	1	72abd6113cd67995ac30ecb4e9dcde7b28c53ecddb887bfb328254057e48a224	{1,1,1,1,1,1,1,1,4,10,20,35,56,84,2,14,56,168,420,924,1848,5,50,275,1100,3575,10010,25025,14,182,1274,6370,25480,86632,259896,42,672,5712,34272,162792,651168,2279088,132,2508,25080,175560,965580,4441668,17766672}
541	494	1	d35cc7ce6a72d4c04941b13fc9c5da630c7c1664244ce06e6304c0f0167e7eff	{1,2,3,4,5,6,7,1,6,21,56,126,252,462,1,10,55,220,715,2002,5005,1,14,105,560,2380,8568,27132,1,18,171,1140,5985,26334,100947,1,22,253,2024,12650,65780,296010,1,26,351,3276,23751,142506,736281}
542	495	1	f5a5a0b1e45fe848548adb530ad5eab5c51614bc5b6238a9c7cef8919cacb308	{1,2,3,4,5,6,7,1,8,36,120,330,792,1716,2,28,210,1120,4760,17136,54264,5,100,1050,7700,44275,212520,885500,14,364,4914,45864,332514,1995084,10307934,42,1344,22176,251328,2199120,15833664,97640928,132,5016,97812,1304160,13367640,112288176,804731928}
543	496	1	9a9028c7952a67762342a13ba464d51ff5f36b6aa31efcbb5db7060c23498aa5	{1,1,2,5,14,42,132,1,2,5,14,42,132,429,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
544	497	1	a77f85bd7281ff5a1c2d95f9b7628eea64979b0fe60bc5379de64fa44a96beba	{1,1,2,5,14,42,132,1,3,9,28,90,297,1001,1,5,20,75,275,1001,3640,1,7,35,154,637,2548,9996,1,9,54,273,1260,5508,23256,1,11,77,440,2244,10659,48279,1,13,104,663,3705,19019,92092}
546	499	1	0301dace4b5ae94b9c0a432ba1448026ea09eb9d91a9fc1722375ca372c667f0	{1,2,1,0,0,0,0,1,2,1,0,0,0,0,-1,-2,-1,0,0,0,0,2,4,2,0,0,0,0,-5,-10,-5,0,0,0,0,14,28,14,0,0,0,0,-42,-84,-42,0,0,0,0}
562	515	1	3ae719f8c35d6d9a6f66e721081aa2c637740c8a5b6e7a2ec9e1c9d3094a6d5c	{0,0,0,0,0,0,0,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None}
567	521	1	7002f489264ab989cfeaf6064df15219457fc84bf8821e49786fd132ee8a1abe	{1,1,1,1,1,1,1,1,-2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
568	522	1	6966c79c4e6e12eba095293615679e3fe3b4bec8621ea33654479a9286eb84f1	{1,1,1,1,1,1,1,1,-3,3,-1,0,0,0,-1,7,-21,35,-35,21,-7,2,-22,110,-330,660,-924,924,-5,75,-525,2275,-6825,15015,-25025,14,-266,2394,-13566,54264,-162792,379848,-42,966,-10626,74382,-371910,1413258,-4239774}
571	525	1	c474d4fabe6e8c1e97e8233b3fe32eaeb94e2c6182a113ed6606ede9a71bb47e	{1,2,3,4,5,6,7,1,-2,1,0,0,0,0,1,-6,15,-20,15,-6,1,1,-10,45,-120,210,-252,210,1,-14,91,-364,1001,-2002,3003,1,-18,153,-816,3060,-8568,18564,1,-22,231,-1540,7315,-26334,74613}
572	526	1	a51df51bfd7d0f5848ae40f87f3e607935acf468e2bbc9b2a842c09686df5d26	{1,2,3,4,5,6,7,1,-4,6,-4,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
573	527	1	69f8bfccc3eeb161282fbb13ccbbe8325f39898a3d5fa62e00679dc8990345b1	{1,2,3,4,5,6,7,1,-6,15,-20,15,-6,1,-1,14,-91,364,-1001,2002,-3003,2,-44,462,-3080,14630,-52668,149226,-5,150,-2175,20300,-137025,712530,-2968875,14,-532,9842,-118104,1033410,-7027188,38649534,-42,1932,-43470,637560,-6853770,57571668,-393406398}
575	529	1	a50524dbc936420354bc4cb8b0772c3ed6a1ca3a12a56d7fc6ba944a99021bd6	{1,1,2,5,14,42,132,1,1,2,5,14,42,132,3,3,6,15,42,126,396,12,12,24,60,168,504,1584,55,55,110,275,770,2310,7260,273,273,546,1365,3822,11466,36036,1428,1428,2856,7140,19992,59976,188496}
576	530	1	7a28426ecb3f9693298009f457a80b851919a09c9cebc5a12d570fe27b9e82ab	{1,1,2,5,14,42,132,1,0,0,0,0,0,0,2,-2,-2,-4,-10,-28,-84,5,-10,-5,-10,-25,-70,-210,14,-42,0,-14,-42,-126,-392,42,-168,84,0,-42,-168,-588,132,-660,660,0,0,-132,-660}
577	531	1	2cbbd98c8ef5ef44bcefb98eb76b16ad3b57ed5238120d6d772820e3e518d6e0	{1,1,2,5,14,42,132,1,-1,-1,-2,-5,-14,-42,1,-3,0,-1,-3,-9,-28,1,-5,5,0,0,-1,-5,1,-7,14,-7,0,0,0,1,-9,27,-30,9,0,0,1,-11,44,-77,55,-11,0}
578	532	1	041007f261954452042b36b8b9f517b6257b6bced5b566d315cf8da60330425d	{1,1,2,5,14,42,132,1,-2,-1,-2,-5,-14,-42,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
580	535	1	413e57994b9fb2aae45c9b38725397535029859fe1f5d2dc9ef316e4c59e0e5a	{1,2,5,14,42,132,429,1,-2,-1,-2,-5,-14,-42,1,-6,9,-2,0,0,-1,1,-10,35,-50,25,-2,0,1,-14,77,-210,294,-196,49,1,-18,135,-546,1287,-1782,1386,1,-22,209,-1122,3740,-8008,11011}
581	536	1	5f49723c9f291068eceba9121e7078eef092cf3f48975220278805c93b116ad9	{1,2,5,14,42,132,429,1,-4,2,0,-1,-4,-14,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
582	537	1	a7c898ab902c5f637e4f9f688af11885c2ef879b04a518940925c518259025cf	{1,None,None,None,None,None,None,1,1,1,1,1,1,1,1,-1,-1,-1,-1,-1,-1,1,2,2,2,2,2,2,1,-5,-5,-5,-5,-5,-5,1,14,14,14,14,14,14,1,-42,-42,-42,-42,-42,-42}
583	539	1	3f621a28cf401d8cd8554f4723f89d53658e15081733420cb22b98c614ac87cc	{1,1,3,12,55,273,1428,1,1,3,12,55,273,1428,3,3,9,36,165,819,4284,12,12,36,144,660,3276,17136,55,55,165,660,3025,15015,78540,273,273,819,3276,15015,74529,389844,1428,1428,4284,17136,78540,389844,2039184}
585	541	1	77c99d3442fd2adf03458dcc9453c6bd5d800f81519671a02f499ff968d5bb51	{1,1,3,12,55,273,1428,1,-1,-2,-7,-30,-143,-728,1,-3,-3,-10,-42,-198,-1001,1,-5,0,-5,-25,-126,-660,1,-7,7,0,-7,-49,-294,1,-9,18,-3,0,-9,-84,1,-11,33,-22,0,0,-11}
536	483	1	9c2d74b1191d2bc63868e1020ce790921e7690981031b404f9585a22e6c9caf1	{1,2,1,0,0,0,0,2,0,0,0,0,0,0,1,-2,3,-4,5,-6,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
549	502	1	64d07e634c4c57f043f8df3d21483bdeb70d88c7ed67a2f8fa8c3218e77ec337	{1,1,2,5,14,42,132,1,3,9,28,90,297,1001,1,5,20,75,275,1001,3640,1,7,35,154,637,2548,9996,1,9,54,273,1260,5508,23256,1,11,77,440,2244,10659,48279,1,13,104,663,3705,19019,92092}
550	503	1	0808ecb3f3889c7bef008141ee48995f4224775d657dae4aa4204ff412ffe001	{1,1,2,5,14,42,132,1,4,14,48,165,572,2002,2,14,70,308,1274,5096,19992,5,50,325,1750,8500,38760,169575,14,182,1456,9282,51870,266266,1289288,42,672,6384,47040,297528,1700160,9041760,132,2508,27588,230736,1630200,10270260,59567508}
551	504	1	1f4b9fa0964ea667173f23e3927892aaa0ee115ac3082f0112f9ecca08793cee	{1,2,1,0,0,0,0,-1,-2,-1,0,0,0,0,0,-1,0,0,0,0,0,-2,-5,-2,0,0,0,0,-4,-8,-4,0,0,0,0,-13,-26,-13,0,0,0,0,-42,-85,-42,0,0,0,0}
553	506	1	ca85bfd4ca7243e733d460ee506d37c580bbe6ae155ce5936eef6dc923db86e9	{1,1,2,5,14,42,132,-1,-1,-2,-5,-14,-42,-132,0,0,-1,-2,-7,-21,-66,-2,-2,-5,-13,-37,-112,-352,-4,-4,-8,-21,-59,-178,-561,-13,-13,-26,-66,-184,-554,-1742,-42,-42,-85,-212,-595,-1785,-5610}
554	507	1	678e5bfd15b57eba24ddeb722481029f5c6062b459512bdd2cc3f720c2238cb8	{1,2,5,14,42,132,429,-1,-2,-5,-14,-42,-132,-429,0,-1,-2,-7,-21,-66,-214,-2,-5,-13,-37,-112,-352,-1144,-4,-8,-21,-59,-178,-561,-1823,-13,-26,-66,-184,-554,-1742,-5662,-42,-85,-212,-595,-1785,-5610,-18232}
555	508	1	ba42d7de797143bc3edd136196909a5a47e81006895b05fd0b77181fe3094f28	{1,2,5,14,42,132,429,1,4,14,48,165,572,2002,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
556	509	1	99ff8158f66da19d6f2d1fc0e6509b7cf1ec50b1dc0214d0164b72c2ee06ceb7	{1,2,5,14,42,132,429,1,6,27,110,429,1638,6188,1,10,65,350,1700,7752,33915,1,14,119,798,4655,24794,123970,1,18,189,1518,10350,63180,356265,1,22,275,2574,20097,138446,870232,1,26,377,4030,35464,272272,1888887}
557	510	1	27abbdb383139c79d23ba5cc9dc351e7eefddb34e7086447762a14ae168748d3	{1,2,5,14,42,132,429,1,8,44,208,910,3808,15504,2,28,238,1596,9310,49588,247940,5,100,1150,10000,73125,475020,2831850,14,364,5278,56420,496496,3811808,26444418,42,1344,23520,298368,3070704,27221376,215621952,132,5016,102828,1509816,17794260,178935768,1594155024}
559	512	1	caaab053b4717e8b4e7cc5474c30d55841163816086f41b3cfbc9177f8d969bd	{1,1,0,0,0,0,0,1,-1,1,-1,1,-1,1,1,-3,6,-10,15,-21,28,1,-5,15,-35,70,-126,210,1,-7,28,-84,210,-462,924,1,-9,45,-165,495,-1287,3003,1,-11,66,-286,1001,-3003,8008}
560	513	1	615061b92642e2aadc4d9dce5548270dc3328f7dce69814f0f5a77174e329185	{1,1,0,0,0,0,0,1,-2,3,-4,5,-6,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
561	514	1	f886e40ad089546948aefb601a8267d17a5e971a92db9180d9389478836b7729	{1,1,0,0,0,0,0,1,-3,6,-10,15,-21,28,-1,7,-28,84,-210,462,-924,2,-22,132,-572,2002,-6006,16016,-5,75,-600,3400,-15300,58140,-193800,14,-266,2660,-18620,102410,-471086,1884344,-42,966,-11592,96600,-627900,3390660,-15823080}
564	518	1	0ace507a78093b002095650c0e0e71ff976148acc615b9e737feffa98bbf293c	{1,2,1,0,0,0,0,1,-4,10,-20,35,-56,84,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
565	519	1	e234d86aaed0f08cb08d07a0d62404cc2425289e8bf652fb4a08eed62bd5c30d	{1,2,1,0,0,0,0,1,-4,10,-20,35,-56,84,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
586	542	1	98a3816c955d1744d3c67b455694ad8624b146b99f48416e89198cf9eb0d0577	{1,1,3,12,55,273,1428,1,-2,-3,-10,-42,-198,-1001,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
587	543	1	4d499810aaf35f5b29d1170eeff5ce8dd439c751aa18d0ab147ae46664c147b6	{1,None,None,None,None,None,None,1,1,1,1,1,1,1,1,-1,-1,-1,-1,-1,-1,1,2,2,2,2,2,2,1,-5,-5,-5,-5,-5,-5,1,14,14,14,14,14,14,1,-42,-42,-42,-42,-42,-42}
588	550	1	b1e30034854865f0272a21d452b9414931d79a69d619006497f214f722b93c23	{1,2,1,0,0,0,0,1,2,1,0,0,0,0,-2,-4,-2,0,0,0,0,7,14,7,0,0,0,0,-30,-60,-30,0,0,0,0,143,286,143,0,0,0,0,-728,-1456,-728,0,0,0,0}
589	551	1	f0c415e807c0ad053de223430c23edc828b2ea3716f50c221b2860c17bbcd426	{1,2,1,0,0,0,0,1,4,6,4,1,0,0,-1,-6,-15,-20,-15,-6,-1,2,16,56,112,140,112,56,-5,-50,-225,-600,-1050,-1260,-1050,14,168,924,3080,6930,11088,12936,-42,-588,-3822,-15288,-42042,-84084,-126126}
591	553	1	5eb843a79b59e907900882ed3538bbb64202986a15e6438c887840df6bfd337a	{1,2,1,0,0,0,0,1,8,28,56,70,56,28,1,14,91,364,1001,2002,3003,1,20,190,1140,4845,15504,38760,1,26,325,2600,14950,65780,230230,1,32,496,4960,35960,201376,906192,1,38,703,8436,73815,501942,2760681}
592	556	1	4d9cbe4fc1215ef89edd8d88f043073cb1b82fee2a2830f33c8cb584a45f99f5	{1,1,1,1,1,1,1,1,2,3,4,5,6,7,-1,-3,-6,-10,-15,-21,-28,2,8,20,40,70,112,168,-5,-25,-75,-175,-350,-630,-1050,14,84,294,784,1764,3528,6468,-42,-294,-1176,-3528,-8820,-19404,-38808}
593	557	1	fcf1e8bc478b90d28257ef2f09f8fa0894138ff3c4cb5dacdde9c08379af7aeb	{1,1,1,1,1,1,1,1,3,6,10,15,21,28,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
595	559	1	5b83f8febb29942fb9498747ae1a11a0ec53c52bcb39672945fd59fbb9d616cf	{1,1,1,1,1,1,1,1,5,15,35,70,126,210,2,18,90,330,990,2574,6006,5,65,455,2275,9100,30940,92820,14,238,2142,13566,67830,284886,1044582,42,882,9702,74382,446292,2231460,9669660,132,3300,42900,386100,2702700,15675660,78378300}
596	561	1	4680176e24078f79ea903e6cc092c297fa40c41a5fd8ef6bacbcbd582feb3442	{1,2,3,4,5,6,7,1,4,10,20,35,56,84,-1,-6,-21,-56,-126,-252,-462,2,16,72,240,660,1584,3432,-5,-50,-275,-1100,-3575,-10010,-25025,14,168,1092,5096,19110,61152,173264,-42,-588,-4410,-23520,-99960,-359856,-1139544}
597	562	1	3741b7d0652e1853505ae343c6c35128b9ceda511ad61bbb9a13dd7d3a7d200d	{1,2,3,4,5,6,7,1,6,21,56,126,252,462,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
598	563	1	009d5d05bf567d0147bf43f78257b8073103df3d864eeae071b6a5aa8e57fc1d	{1,2,3,4,5,6,7,1,8,36,120,330,792,1716,1,14,105,560,2380,8568,27132,1,20,210,1540,8855,42504,177100,1,26,351,3276,23751,142506,736281,1,32,528,5984,52360,376992,2324784,1,38,741,9880,101270,850668,6096454}
600	566	1	6ba16d7f81b35ecc414d2a32c34456b017f62d47730fc18471008d50d1896dfa	{1,1,2,5,14,42,132,1,2,5,14,42,132,429,-1,-3,-9,-27,-90,-297,-1000,2,8,28,96,330,1144,4004,-5,-25,-100,-375,-1375,-5005,-18200,14,84,378,1539,6006,22932,86631,-42,-294,-1470,-6468,-26754,-107016,-419832}
601	567	1	cd0e6a59393144e5cfd2685190424cf02858aade51913e7a5da834dd233de246	{1,1,2,5,14,42,132,1,3,9,28,90,297,1001,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
605	572	1	2e48881f4d55446ee4f8db9457eeaff71633436f596e46a9c67f18443a52761b	{1,2,5,14,42,132,429,1,6,27,110,429,1638,6188,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
606	573	1	bb91c59b52ffc4d6ee67d0e4ea9849973b877fde09eb938a1999fea2b16dfd88	{1,2,5,14,42,132,429,1,8,44,208,910,3808,15504,1,14,119,798,4655,24794,123970,1,20,230,2000,14625,95004,566370,1,26,377,4030,35464,272272,1888887,1,32,560,7104,73112,648128,5133856,1,38,779,11438,134805,1355574,12076932}
607	574	1	15092ac7a0dd1130407b36d0b730c5d3e88fe22d5397a7e20b05a6a47b458837	{1,2,5,14,42,132,429,1,10,65,350,1700,7752,33915,2,36,378,3036,20700,126360,712530,5,130,1885,20150,177320,1361360,9444435,14,476,8806,117572,1268540,11748632,96926214,42,1764,39690,635628,8124984,88164720,843687390,132,6600,174900,3267000,48279000,600766320,6544061700}
608	576	1	0dbf40677efd2e77d3e2c6cacc15df89d702ed65c80fa5519b9ea648d418d888	{1,2,6,20,70,252,924,1,4,16,64,256,1024,4096,-1,-6,-30,-140,-630,-2772,-12012,2,16,96,512,2560,12288,57344,-5,-50,-350,-2100,-11550,-60060,-300300,14,168,1344,8960,53760,301056,1605632,-42,-588,-5292,-38808,-252252,-1513512,-8576568}
610	578	1	ee65ae0c747da91a404e3fdd9fd868a18f0538cd2da52ff12159f17f7e70657b	{1,2,6,20,70,252,924,1,8,48,256,1280,6144,28672,1,14,126,924,6006,36036,204204,1,20,240,2240,17920,129024,860160,1,26,390,4420,41990,352716,2704156,1,32,576,7680,84480,811008,7028736,1,38,798,12236,152950,1651860,15967980}
611	579	1	c7c59deeb21cbfaa70476746aee65ba43f76d025aaa36e16b7790c79aa1be52c	{1,2,6,20,70,252,924,1,10,70,420,2310,12012,60060,2,36,396,3432,25740,175032,1108536,5,130,1950,22100,209950,1763580,13520780,14,476,9044,126616,1456084,14560840,131047560,42,1764,40572,676200,9128700,105892920,1094226840,132,6600,178200,3445200,53400600,704887920,8223692400}
612	582	1	8dd037809aa6730c4f1050457b6ed998a028b60cb34fb60eb98b0bb8564a4524	{1,1,3,12,55,273,1428,1,3,12,55,273,1428,7752,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
613	583	1	c057e6db507cadc6843fe236e9d8423b14b74254c93e6d97a94954684ab8b52d	{1,1,3,12,55,273,1428,1,4,18,88,455,2448,13566,1,7,42,245,1428,8379,49588,1,10,75,510,3325,21252,134550,1,13,117,910,6578,45630,308763,1,16,168,1472,11700,87696,632896,1,19,228,2223,19285,155496,1193808}
615	591	1	bbb023cd5ec4e202a42fc7e9aff5ecf7530db131a6235ce41b00cf728bfb9081	{1,0,1,0,0,0,0,1,0,2,0,1,0,0,-1,0,-3,0,-3,0,-1,2,0,8,0,12,0,8,-5,0,-25,0,-50,0,-50,14,0,84,0,210,0,280,-42,0,-294,0,-882,0,-1470}
616	592	1	e073e0c50971f7bc44c43c5d175b4f53cef9db57fc5b34278f3184da02db9ea5	{1,0,1,0,0,0,0,1,0,3,0,3,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
617	593	1	c45443d80fa52bb5dc9b9d1ed925f178227cd9a72f9b8250207b4cfc20f68d53	{1,0,1,0,0,0,0,1,0,4,0,6,0,4,1,0,7,0,21,0,35,1,0,10,0,45,0,120,1,0,13,0,78,0,286,1,0,16,0,120,0,560,1,0,19,0,171,0,969}
619	596	1	f799e7c7b36a4bdb61f7573ad0a9222ee542bc5483f649d5d22ff5ddc0316d0e	{1,1,-1,2,-5,14,-42,1,0,0,0,0,0,0,2,-2,4,-10,28,-84,264,5,-10,25,-70,210,-660,2145,14,-42,126,-392,1260,-4158,14014,42,-168,588,-2016,6930,-24024,84084,132,-660,2640,-9900,36300,-132132,480480}
621	598	1	789ab7ff478062df6b84af818ce6e545d1893f1f9073251ead03e1232c58b957	{1,1,-1,2,-5,14,-42,1,-2,5,-14,42,-132,429,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
622	599	1	4b1149b0059a9f9ff208c8030934acf1bc063fcf105d5daeb0f9c95bd16fc434	{1,None,None,None,None,None,None,1,1,1,1,1,1,1,1,-1,-1,-1,-1,-1,-1,1,2,2,2,2,2,2,1,-5,-5,-5,-5,-5,-5,1,14,14,14,14,14,14,1,-42,-42,-42,-42,-42,-42}
627	605	1	b5f363d89a2e19ace4773395bf6ef2795a114a9378eeccb23091defdcf9a3777	{1,2,6,20,70,252,924,1,-6,6,4,6,12,28,-1,14,-70,140,-70,-28,-28,2,-44,396,-1848,4620,-5544,1848,-5,150,-1950,14300,-64350,180180,-300300,14,-532,9044,-90440,587860,-2586584,7759752,-42,1932,-40572,513912,-4368252,26209512,-113574552}
628	608	1	f42d21ccf7ef98c39a626ea894cec8a9d379f443ddd6dde7f1bccb75458bd8fc	{1,None,None,None,None,None,None,1,1,1,1,1,1,1,1,-1,-1,-1,-1,-1,-1,1,2,2,2,2,2,2,1,-5,-5,-5,-5,-5,-5,1,14,14,14,14,14,14,1,-42,-42,-42,-42,-42,-42}
629	609	1	814b19cbe6c0b5fd53a07d8a32aa1cf4bab05b86c485aa04f915e6a1c0ac6abc	{0,0,0,0,0,0,0,-1,0,0,0,0,0,0,1,-1,3,-12,55,-273,1428,-2,4,-14,60,-286,1456,-7752,5,-15,60,-275,1365,-7140,38760,-14,56,-252,1232,-6370,34272,-189924,42,-210,1050,-5460,29400,-162792,921690}
634	626	1	0a6a44cf98e3740921621c2c9a40915f38aa1c5d9fe2fb04e3ffba45b3f6657c	{-1,-2,-3,-4,-5,-6,-7,2,0,0,0,0,0,0,-2,4,-2,0,0,0,0,0,0,0,0,0,0,0,2,-12,30,-40,30,-12,2,0,0,0,0,0,0,0,-4,40,-180,480,-840,1008,-840}
636	628	1	e92bab308d09b362824b07e5b0a47fec8a9b5c8e44e73eb48bf40fb2936cf06a	{1,None,None,None,None,None,None,1,2,2,2,2,2,2,1,2,2,2,2,2,2,1,0,0,0,0,0,0,1,-2,-2,-2,-2,-2,-2,1,0,0,0,0,0,0,1,4,4,4,4,4,4}
637	629	1	3e01eea169ae5b798226964a20e9050b9b6b34a0fc5ac19bcdc927ce76d36f6d	{-1,None,None,None,None,None,None,-1,2,2,2,2,2,2,-1,-2,-2,-2,-2,-2,-2,-1,0,0,0,0,0,0,-1,2,2,2,2,2,2,-1,0,0,0,0,0,0,-1,-4,-4,-4,-4,-4,-4}
639	631	1	ed74fdf55b0010c36aa57ca7ac35f9117c23c516ad947000d64858e4f20d2ec8	{1,None,None,None,None,None,None,1,2,2,2,2,2,2,1,2,2,2,2,2,2,1,0,0,0,0,0,0,1,-2,-2,-2,-2,-2,-2,1,0,0,0,0,0,0,1,4,4,4,4,4,4}
641	633	1	80721a1c5aacf95893f1ddd9b35152096456ee256f03b7903cd6ad10ce31d049	{1,1,3,12,55,273,1428,2,2,6,24,110,546,2856,6,6,18,72,330,1638,8568,20,20,60,240,1100,5460,28560,70,70,210,840,3850,19110,99960,252,252,756,3024,13860,68796,359856,924,924,2772,11088,50820,252252,1319472}
642	634	1	2dee6d704c494ce7836190f012321278e3a977efe1d1eb619c38543e3832b1a3	{1,None,None,None,None,None,None,1,2,2,2,2,2,2,1,2,2,2,2,2,2,1,0,0,0,0,0,0,1,-2,-2,-2,-2,-2,-2,1,0,0,0,0,0,0,1,4,4,4,4,4,4}
643	635	1	f32837277193d766a52f1d86e09c9435bb5520e89f758b491a69016cf38acd00	{-1,None,None,None,None,None,None,-1,2,2,2,2,2,2,-1,-2,-2,-2,-2,-2,-2,-1,0,0,0,0,0,0,-1,2,2,2,2,2,2,-1,0,0,0,0,0,0,-1,-4,-4,-4,-4,-4,-4}
644	636	1	3a9218021cb82f4c66305612080dc40e4084bbff540c5e39f43ad902e916d41f	{1,1,-1,2,-5,14,-42,2,2,-2,4,-10,28,-84,6,6,-6,12,-30,84,-252,20,20,-20,40,-100,280,-840,70,70,-70,140,-350,980,-2940,252,252,-252,504,-1260,3528,-10584,924,924,-924,1848,-4620,12936,-38808}
647	642	1	5292df72f85977280c2a243998b8eee754ac37a09595e97d7bb96a97c33156e6	{1,1,-1,2,-5,14,-42,2,4,-2,4,-10,28,-84,5,15,0,5,-15,45,-140,14,56,28,0,-14,56,-196,42,210,210,0,0,42,-210,132,792,1188,264,0,0,-132,429,3003,6006,3003,0,0,0}
648	643	1	b92ff304f5d96a305362617d9b2b64f54b7a46bb03ced2d547eb4442cb6f7221	{1,1,-1,2,-5,14,-42,1,1,-1,2,-5,14,-42,-1,-1,1,-2,5,-14,42,2,2,-2,4,-10,28,-84,-5,-5,5,-10,25,-70,210,14,14,-14,28,-70,196,-588,-42,-42,42,-84,210,-588,1764}
650	645	1	a8e7acb2d68e604d95a62bc069788fc159e8b4bf5c505da95829909a8562018e	{1,1,-1,2,-5,14,-42,1,3,0,1,-3,9,-28,1,5,5,0,0,1,-5,1,7,14,7,0,0,0,1,9,27,30,9,0,0,1,11,44,77,55,11,0,1,13,65,156,182,91,13}
624	602	1	5cc0f066b12b8dfbd5eb5a7a2ba670c5f6e4d12f89594d45622745237ef20964	{1,-1,0,-2,-4,-13,-42,1,1,1,4,13,42,131,1,3,7,26,87,294,1002,1,5,17,78,271,1005,3635,1,7,31,158,631,2553,9990,1,9,49,267,1253,5515,23248,1,11,71,432,2235,10650,48269}
625	603	1	769656e33b69b28a652095dce10aae075dec3ac3e4f66b91e207c60a06e84a18	{1,-1,0,-2,-4,-13,-42,1,2,6,15,40,133,428,0,5,17,78,271,1005,3635,0,8,48,213,908,3814,15508,0,11,71,432,2235,10650,48269,0,14,126,788,4658,24782,123977,0,17,161,1297,8589,50816,278445}
630	610	1	e09e6cb94574dda4e46d0316c13389df3544d6c3d707925e085ab907e68704b0	{4,None,None,None,None,None,None,4,None,None,None,None,None,None,-4,None,None,None,None,None,None,8,None,None,None,None,None,None,-20,None,None,None,None,None,None,56,None,None,None,None,None,None,-168,None,None,None,None,None,None}
632	624	1	42729cbf52fab414199467d6818c0a6aac8262d4338bb1acda82071f37000c1c	{-1,-1,-1,-1,-1,-1,-1,2,0,0,0,0,0,0,-2,2,0,0,0,0,0,0,0,0,0,0,0,0,2,-6,6,-2,0,0,0,0,0,0,0,0,0,0,-4,20,-40,40,-20,4,0}
635	627	1	5214241710bb9c03714acfb113648819390a0fa9eb987f563815f14d76f96fec	{-2,-1,-2,1,1,1,1,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None}
638	630	1	029d14992b2e21de5845f1b3441e10c08417c94ae4d41e6ee490b828671e2a63	{1,2,3,4,5,6,7,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None}
651	646	1	17d4ed57deb9a8add26e9dd0aeeb87746b80394b8793232fdcedd7320e3ca0c1	{1,1,-1,2,-5,14,-42,1,4,2,0,-1,4,-14,2,14,28,14,0,0,0,5,50,175,250,125,10,0,14,182,910,2184,2548,1274,182,42,672,4368,14784,27720,28224,14112,132,2508,20064,87780,228228,358644,331056}
652	647	1	45dfe134017cb60dce7d1e0055cd4fa2bf94c2feb5874d91119c4f31686aa71b	{1,1,3,12,55,273,1428,1,1,3,12,55,273,1428,-1,-1,-3,-12,-55,-273,-1428,2,2,6,24,110,546,2856,-5,-5,-15,-60,-275,-1365,-7140,14,14,42,168,770,3822,19992,-42,-42,-126,-504,-2310,-11466,-59976}
653	648	1	d90e2824c074c5ca9accd5d7fce714a0474f4f133eb096d7d7baf8116aac868b	{1,1,3,12,55,273,1428,1,2,7,30,143,728,3876,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
655	650	1	e9cf2dd2716555f931eb262c6104bf98e95541833b32a0ccd6848f80939f8f02	{1,1,3,12,55,273,1428,1,4,18,88,455,2448,13566,2,14,84,490,2856,16758,99176,5,50,375,2550,16625,106260,672750,14,182,1638,12740,92092,638820,4322682,42,672,7056,61824,491400,3683232,26581632,132,2508,30096,293436,2545620,20525472,157582656}
657	660	1	3a072d7b889f8518b2cff7409e47d9ff7db5e251e99db38830ff7ec4c6b32e33	{-1,-1,0,0,0,0,0,1,2,1,0,0,0,0,-2,-6,-6,-2,0,0,0,5,20,30,20,5,0,0,-14,-70,-140,-140,-70,-14,0,42,252,630,840,630,252,42,-132,-924,-2772,-4620,-4620,-2772,-924}
658	661	1	ab55c5b0299573b3e7591cfc452cb733e3045f09ad3a6411f688a19d7482d0b5	{1,2,1,0,0,0,0,-1,-4,-6,-4,-1,0,0,2,12,30,40,30,12,2,-5,-40,-140,-280,-350,-280,-140,14,140,630,1680,2940,3528,2940,-42,-504,-2772,-9240,-20790,-33264,-38808,132,1848,12012,48048,132132,264264,396396}
660	664	1	86400ebf192d65a3a09d51214b627afb54cec3c3e7d50e1df4b9fd589d4e3e05	{1,0,0,0,0,0,0,1,2,3,4,5,6,7,-1,-4,-10,-20,-35,-56,-84,2,12,42,112,252,504,924,-5,-40,-180,-600,-1650,-3960,-8580,14,140,770,3080,10010,28028,70070,-42,-504,-3276,-15288,-57330,-183456,-519792}
661	665	1	90d957e2f3e42c5b689a7a74f4ce69de028e2855391388e76361e175fc296d06	{1,2,6,20,70,252,924,2,4,12,40,140,504,1848,5,10,30,100,350,1260,4620,14,28,84,280,980,3528,12936,42,84,252,840,2940,10584,38808,132,264,792,2640,9240,33264,121968,429,858,2574,8580,30030,108108,396396}
662	666	1	b81818507a19d3c5f65fb5c198325af8abeb3519df53636645f0cc083aa519d6	{1,2,6,20,70,252,924,2,0,0,0,0,0,0,1,-2,-2,-4,-10,-28,-84,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
664	668	1	cc975490dcc417d3791760e7ab5876790096c8b3c1a37fb648da29f496a26e55	{1,0,0,0,0,0,0,1,2,3,4,5,6,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
665	669	1	48faf629f5d55f9085afdd7cd8ce8823a20072ec058171045a203f0845a709e5	{1,0,0,0,0,0,0,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None}
666	670	1	d6b7d0ddecc4dae8be667f8f256bb1a0b4d59d06c586044ac8339906194f34ef	{1,2,3,4,5,6,7,-1,-4,-10,-20,-35,-56,-84,2,12,42,112,252,504,924,-5,-40,-180,-600,-1650,-3960,-8580,14,140,770,3080,10010,28028,70070,-42,-504,-3276,-15288,-57330,-183456,-519792,132,1848,13860,73920,314160,1130976,3581424}
667	671	1	30086b77d4497df50d8eb717b448308cea714e1ac5be8fe08c2eed4abe9d0e32	{1,2,3,4,5,6,7,-1,-2,-3,-4,-5,-6,-7,1,2,3,4,5,6,7,-1,-2,-3,-4,-5,-6,-7,1,2,3,4,5,6,7,-1,-2,-3,-4,-5,-6,-7,1,2,3,4,5,6,7}
669	673	1	739897bda147052b55a2863c5e187dc64963c07e5b467a2da0c472a8a220c8eb	{1,0,0,0,0,0,0,1,1,2,5,14,42,132,-1,-2,-5,-14,-42,-132,-429,2,6,18,56,180,594,2002,-5,-20,-70,-240,-825,-2860,-10010,14,70,280,1050,3850,14014,50960,-42,-252,-1134,-4620,-18018,-68796,-259896}
670	674	1	4137b6f90bf606b26a3b19be5dc2fbe07edfc6db856f9716f596f16109fadfb4	{-1,-1,-2,-5,-14,-42,-132,1,2,5,14,42,132,429,-2,-6,-18,-56,-180,-594,-2002,5,20,70,240,825,2860,10010,-14,-70,-280,-1050,-3850,-14014,-50960,42,252,1134,4620,18018,68796,259896,-132,-924,-4620,-20328,-84084,-336336,-1319472}
671	675	1	f6774991f361f08e7907246ad622b84e935e50bbbd403ef0d0bdc62e4c9f5d37	{1,0,0,0,0,0,0,1,2,6,20,70,252,924,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
672	676	1	a07d61620fd5c67e7f280621331c51177ab4c9024b7f77b90df6c8bc5f112442	{1,0,0,0,0,0,0,1,2,6,20,70,252,924,-1,-4,-16,-64,-256,-1024,-4096,2,12,60,280,1260,5544,24024,-5,-40,-240,-1280,-6400,-30720,-143360,14,140,980,5880,32340,168168,840840,-42,-504,-4032,-26880,-161280,-903168,-4816896}
675	679	1	1dd21cd37dc76c65796dd9ac6961e197ef7babb0f691619519be344626c98d17	{1,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None}
676	680	1	5414c1b0d5d5839563634f20458d705169952d2c90ce6104fecc9482d726a11b	{-1,-2,-5,-14,-42,-132,-429,1,4,14,48,165,572,2002,-2,-12,-54,-220,-858,-3276,-12376,5,40,220,1040,4550,19040,77520,-14,-140,-910,-4900,-23800,-108528,-474810,42,504,3780,22848,122094,603288,2826516,-132,-1848,-15708,-105336,-614460,-3272808,-16364040}
677	681	1	a8334412b1db1cfd02e7589ad4cbd4672c92df34187f21d5a76a13d77c733c88	{1,0,0,0,0,0,0,1,1,-1,2,-5,14,-42,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
679	683	1	aa66eac3f91761ec5d994bc6c7ade89a325848852f1a4fd8dff8c30ac6c80dd3	{-1,-1,1,-2,5,-14,42,1,2,-1,2,-5,14,-42,-2,-6,0,-2,6,-18,56,5,20,10,0,-5,20,-70,-14,-70,-70,0,0,-14,70,42,252,378,84,0,0,-42,-132,-924,-1848,-924,0,0,0}
680	684	1	48faf629f5d55f9085afdd7cd8ce8823a20072ec058171045a203f0845a709e5	{1,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None}
681	685	1	c48cfea2393e0c8437c8b8875a728dcc7deaa3d24fa1b7a19187e2087cab9cd6	{1,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None}
682	686	1	bdf564c6b42178c1b57dc2a59d3799459d66c78798c14e539b992fe753fe6fa0	{-1,-1,-3,-12,-55,-273,-1428,1,2,7,30,143,728,3876,-2,-6,-24,-110,-546,-2856,-15504,5,20,90,440,2275,12240,67830,-14,-70,-350,-1820,-9800,-54264,-307230,42,252,1386,7644,42840,244188,1413258,-132,-924,-5544,-32340,-188496,-1106028,-6545616}
684	688	1	e84a55035901d1d9489017289fcbf2b3343da36ad4b81fd062b637272b645fb6	{1,None,None,None,None,None,None,1,1,1,1,1,1,1,1,-1,-1,-1,-1,-1,-1,1,2,2,2,2,2,2,1,-5,-5,-5,-5,-5,-5,1,14,14,14,14,14,14,1,-42,-42,-42,-42,-42,-42}
685	695	1	3d5d949232252935bc3e21d7694c6d85bb2c00e5dcbd24f7f4b0886ee8d7f980	{1,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None}
686	696	1	2786fb874542a9ca4626bbb2cb975f99c201f48deef356d38b736894a819b81a	{1,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None}
698	729	1	cacdf05e9ea51d029b2eb7eece0f18eaa2800d707ae27dfce96b2aa2cd6e3928	{1,1,0,0,0,0,0,2,4,2,0,0,0,0,1,3,3,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
700	731	1	9cf83cd0362c62b1eaf3086356d69e1fd18fcda459d17789ba7c1a9fe675393d	{1,1,0,0,0,0,0,2,6,6,2,0,0,0,5,25,50,50,25,5,0,14,98,294,490,490,294,98,42,378,1512,3528,5292,5292,3528,132,1452,7260,21780,43560,60984,60984,429,5577,33462,122694,306735,552123,736164}
702	734	1	ce1f36805c1b8fc064edb841e3d9efecefd89ae423bdeba8ad984ec48d3ef0f3	{1,1,1,1,1,1,1,2,6,12,20,30,42,56,5,25,75,175,350,630,1050,14,98,392,1176,2940,6468,12936,42,378,1890,6930,20790,54054,126126,132,1452,8712,37752,132132,396396,1057056,429,5577,39039,195195,780780,2654652,7963956}
691	721	1	9794689fae0e8ffe7083665ac256f1b7cb123457c1c9af280318f55f1f62ed1d	{1,2,-2,4,-10,28,-84,1,8,16,0,0,0,0,1,14,70,140,70,None,None,1,20,160,640,1280,1024,0,1,26,286,1716,6006,12012,12012,1,32,448,3584,17920,57344,114688,1,38,646,6460,41990,184756,554268}
692	722	1	a4a4f6803fafb310c2cf9297147db2dd462d76c2c30c79385b495bb4e84ac493	{1,2,-2,4,-10,28,-84,1,10,30,20,None,None,-20,2,36,252,840,1260,504,None,5,130,1430,8580,30030,60060,60060,14,476,7140,61880,340340,1225224,2858856,42,1764,33516,379847,2848860,14814072,54318263,132,6600,151800,2125200,20189400,137287920,686439600}
693	723	1	c303ad67020f6df2c8637a83725660ac4fb4ff452e9fad8adc3fbaa3c8ccea33	{1,0,1,0,2,0,5,1,0,2,0,6,0,20,0,0,1,0,6,0,30,0,None,0,0,2,0,20,0,None,0,0,0,0,5,0,None,0,None,0,0,0,0,None,0,None,None,0,0}
695	725	1	35317f034fb5837189a25f09f6ae5457e5d26c0f73bf86d12760682dbb8d7a82	{1,4,6,4,1,0,0,1,5,10,10,5,1,0,1,6,15,20,15,6,1,1,7,21,35,35,21,7,1,8,28,56,70,56,28,1,9,36,84,126,126,84,1,10,45,120,210,252,210}
696	726	1	887e2c60e867c121127471f06538a2866be8a78f43a043c4be27922e36e90b81	{1,3,3,1,0,0,0,1,4,6,4,1,0,0,1,5,10,10,5,1,0,1,6,15,20,15,6,1,1,7,21,35,35,21,7,1,8,28,56,70,56,28,1,9,36,84,126,126,84}
697	727	1	41ce1c4f5b50a3e01bd638db261fae33e4193ca5fdb7d52bc3243da1a37c0fcb	{1,2,1,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
699	730	1	41eddbd42972ae7e749cfd9dee6ce68da5d11217b688f5f5bf01efaae0dbc5b7	{1,1,0,0,0,0,0,3,6,3,0,0,0,0,3,9,9,3,0,0,0,1,4,6,4,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
704	737	1	373eb9eca3ea4af0627e7aab16dc2709a912347890f181dd2a4fc729bfe81cba	{1,2,1,0,0,0,0,2,12,30,40,30,12,2,5,50,225,600,1050,1260,1050,14,196,1274,5096,14014,28028,42042,42,756,6426,34272,128520,359856,779688,132,2904,30492,203280,965580,3476088,9848916,429,11154,139425,1115400,6413550,28219620,98768670}
703	736	1	ae3020ebb1c6e287a7c6ecdf97b7b68e86135194718e1eb5870f6bed1ddd0196	{1,2,1,0,0,0,0,2,8,12,8,2,0,0,1,6,15,20,15,6,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
705	739	1	a02711f7e9c9c277209a79aca7008ab0d2598af5fde2ef792b648be00c85ccd3	{1,2,3,4,5,6,7,2,8,20,40,70,112,168,1,6,21,56,126,252,462,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
706	740	1	d8bf4775dced26a4208dcd1b62796ec2559490f86c628b7e47d4f1fb9b9c4519	{1,2,3,4,5,6,7,2,12,42,112,252,504,924,5,50,275,1100,3575,10010,25025,14,196,1470,7840,33320,119952,379848,42,756,7182,47880,251370,1106028,4239774,132,2904,33396,267168,1669800,8682960,39073320,429,11154,150579,1405404,10189179,61135074,315864549}
709	746	1	c2b2d5ac62076354b63d2a981e9cc94d3db27c5f6688da8ab6fb3af3002bd379	{1,1,0,0,0,0,0,4,8,4,0,0,0,0,14,42,42,14,0,0,0,48,192,288,192,48,0,0,165,825,1650,1650,825,165,0,572,3432,8580,11440,8580,3432,572,2002,14014,42042,70070,70070,42042,14014}
711	752	1	bacb57e618b4de2a3fc90fb475a4fbe2f438d480f250b36cba07fd371db251f2	{1,2,5,14,42,132,429,2,12,54,220,858,3276,12376,5,50,325,1750,8500,38760,169575,14,196,1666,11172,65170,347116,1735580,42,756,7938,63756,434700,2653560,14963130,132,2904,36300,339768,2652804,18274872,114870624,429,11154,161733,1728870,15214056,116804688,810332523}
713	755	1	ee62538dba872695b0f6d4337bf6bfc2e30b73a416c488b6c87956594a7311a5	{1,2,6,20,70,252,924,2,12,60,280,1260,5544,24024,5,50,350,2100,11550,60060,300300,14,196,1764,12936,84084,504504,2858856,42,756,8316,72072,540540,3675672,23279256,132,2904,37752,377520,3208920,24387792,170714544,429,11154,167310,1896180,18013710,151315164,1160082924}
715	761	1	3ac43e2b3022e389b9c9b18ee0c42c1270661a7357b5e1f365282c349b29a955	{1,2,5,14,42,132,429,3,12,42,144,495,1716,6006,9,54,243,990,3861,14742,55692,28,224,1232,5824,25480,106624,434112,90,900,5850,31500,153000,697680,3052350,297,3564,26730,161568,863379,4266108,19987506,1001,14014,119119,798798,4659655,24818794,124093970}
714	756	1	17ebb7f722445e51b87c53147e0a6923a3ce0d87ba4c024014aa9dfd0d56ab03	{1,1,0,0,0,0,0,3,6,3,0,0,0,0,9,27,27,9,0,0,0,28,112,168,112,28,0,0,90,450,900,900,450,90,0,297,1782,4455,5940,4455,1782,297,1001,7007,21021,35035,35035,21021,7007}
739	820	1	baba61a73a51446c8d70a661099aff1e7921fb2da6588276bf0b5f17a6667123	{1,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None}
758	843	1	94e7fc4fc52e46fb72127b1fe34dea625ae088f9d17c80604390528f4c7d6ef0	{1,4,6,4,1,0,0,1,6,15,20,15,6,1,2,16,56,112,140,112,56,5,50,225,600,1050,1260,1050,14,168,924,3080,6930,11088,12936,42,588,3822,15288,42042,84084,126126,132,2112,15840,73920,240240,576576,1057056}
717	769	1	75a73996bd4a061b4c0642744bb0f6220b4107d60b36d76ee3800831fe03e0b7	{1,2,-2,4,-10,28,-84,2,12,12,None,12,-24,55,5,49,150,99,None,None,-99,14,196,980,1960,980,None,None,42,756,5292,17640,26460,10584,None,132,2904,26136,121968,304920,365904,121968,429,11153,122693,736164,2576574,5153148,5153148}
719	776	1	439890a87b7cd2dbe8e64af42f622f9e66384f6709a3bec389772a79bd4ec54c	{1,2,1,0,0,0,0,2,0,0,0,0,0,0,3,-6,9,-12,15,-18,21,4,-16,40,-80,140,-224,336,5,-30,105,-280,630,-1260,2310,6,-48,216,-720,1980,-4752,10296,7,-70,385,-1540,5005,-14014,35035}
720	778	1	275f2827412bda5c028532e382d9adb665289ebdc2d3ac893ca44531e3842b5a	{1,1,1,1,1,1,1,2,0,0,0,0,0,0,3,-3,0,0,0,0,0,4,-8,4,0,0,0,0,5,-15,15,-5,0,0,0,6,-24,36,-24,6,0,0,7,-35,70,-70,35,-7,0}
721	780	1	226f565b9ae67d00026f3b3fbe40eba72dd3c80609ff4b48179334a565a2591f	{1,2,3,4,5,6,7,2,0,0,0,0,0,0,3,-6,3,0,0,0,0,4,-16,24,-16,4,0,0,5,-30,75,-100,75,-30,5,6,-48,168,-336,420,-336,168,7,-70,315,-840,1470,-1764,1470}
723	784	1	f72ad27534043da1822c18910e3308ff339d87d5c78d4898e05351ac5f66b244	{None,2,5,14,42,132,429,None,0,0,0,0,0,0,None,-6,-3,-6,-15,-42,-126,None,-16,8,0,-4,-16,-56,None,-30,45,-10,0,0,-5,None,-48,120,-96,12,0,0,None,-70,245,-350,175,-14,0}
726	798	1	7bbed8591cd7918d033a111e5b76a120e538b58a026a2b3837db1cf62e642384	{1,0,0,0,0,0,0,2,2,0,0,0,0,0,3,6,3,0,0,0,0,4,12,12,4,0,0,0,5,20,30,20,5,0,0,6,30,60,60,30,6,0,7,42,105,140,105,42,7}
724	786	1	083e18236bf893975d155c8eeb1f3cca75e74ad9fb96c8a092021cb7a14ed577	{None,None,None,None,None,None,None,3,0,0,0,0,0,0,3,-3,3,-3,3,-3,3,1,-2,3,-4,5,-6,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
725	788	1	b17274d768b54b0103aa8974810192a2f1bbfa3307d39cc3e1599f230145f090	{None,None,None,None,None,None,None,3,0,0,0,0,0,0,3,-6,9,-12,15,-18,21,1,-4,10,-20,35,-56,84,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
731	803	1	73fe105e4b9cfff8e6d4ee3763cb1b6c7469e7b9c0816bbc45ce4d9b31257b53	{1,2,1,0,0,0,0,2,8,12,8,2,0,0,5,30,75,100,75,30,5,14,112,392,784,980,784,392,42,420,1890,5040,8820,10584,8820,132,1584,8712,29040,65340,104544,121968,429,6006,39039,156156,429429,858858,1288287}
728	800	1	84d72bec77f880a2927c027603f4eb7f6efb7f66a8eebcfdb212f96b2ada9b0c	{0,0,0,0,0,0,0,2,2,0,0,0,0,0,-1,-2,-1,0,0,0,0,2,6,6,2,0,0,0,-5,-20,-30,-20,-5,0,0,14,70,140,140,70,14,0,-42,-252,-630,-840,-630,-252,-42}
730	802	1	7dd37059ed4890f2e90b58df36b2e030ebe3c00c3890152d537ee5b4e2b63cc7	{0,0,0,0,0,0,0,2,2,2,2,2,2,2,-1,-2,-3,-4,-5,-6,-7,2,6,12,20,30,42,56,-5,-20,-50,-100,-175,-280,-420,14,70,210,490,980,1764,2940,-42,-252,-882,-2352,-5292,-10584,-19404}
733	805	1	9f8c6d5dcdda8b9cd0c7e2cac70d0ee0d2e38fa05479a447987d35150610e193	{1,0,0,0,0,0,0,2,4,6,8,10,12,14,5,20,50,100,175,280,420,14,84,294,784,1764,3528,6468,42,336,1512,5040,13860,33264,72072,132,1320,7260,29040,94380,264264,660660,429,5148,33462,156156,585585,1873872,5309304}
734	806	1	a7b97ac8263369af1860901e4b6cbbc3d8548b2857f839fd6720235b89802aab	{1,0,0,0,0,0,0,2,2,4,10,28,84,264,3,6,15,42,126,396,1287,4,12,36,112,360,1188,4004,5,20,70,240,825,2860,10010,6,30,120,450,1650,6006,21840,7,42,189,770,3003,11466,43316}
735	808	1	bc2fb41ad6bfa48ed89ddcae326aa5bb85bf60a2aba5de49bff69f2e055476a7	{0,1,2,1,0,0,0,1,2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
737	818	1	4fb5e13dbbbd2fdaac5e1351d5074732cfdf9a778136f1efd7a978871caf20c4	{1,2,6,20,70,252,924,2,4,12,40,140,504,1848,6,12,36,120,420,1512,5544,20,40,120,400,1400,5040,18480,70,140,420,1400,4900,17640,64680,252,504,1512,5040,17640,63504,232848,924,1848,5544,18480,64680,232848,853776}
740	822	1	e18497c888dfd3b7e3961e892663098255ce4110104c9541c79dfeacc9dfafdd	{1,4,6,4,1,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
741	826	1	61887221e506ac765ed8d5215fa25fa324ff9fe1c5dd13f855a9ec17db5c97e2	{1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1}
742	827	1	e7fb131656547e3e8cad341d1359b82bbaf2eb821b053aa651b25ba35bed974b	{1,0,0,0,0,0,0,1,0,0,0,0,0,0,1,1,0,0,0,0,0,1,2,1,0,0,0,0,1,3,3,1,0,0,0,1,4,6,4,1,0,0,1,5,10,10,5,1,0}
744	829	1	f4c74ad02a779616456ae53c2d211d59c99e23df3982f375add008aee26376d4	{1,4,6,4,1,0,0,1,9,36,84,126,126,84,2,28,182,728,2002,4004,6006,5,95,855,4845,19380,58140,135660,14,336,3864,28336,148764,595056,1884344,42,1218,17052,153468,997542,4987710,19950840,132,4488,74052,789888,6121632,36729792,177527328}
745	830	1	7677bb0083782740bd291fb8bbc55e041558ec2fedad500a0860598efb63d25a	{1,2,3,4,5,6,7,1,3,6,10,15,21,28,1,4,10,20,35,56,84,1,5,15,35,70,126,210,1,6,21,56,126,252,462,1,7,28,84,210,462,924,1,8,36,120,330,792,1716}
747	832	1	37bfc6a8f9aca6ae5c0713158a70e3af2adc2a66b96c10b54c95d199cf6bd2be	{1,3,6,10,15,21,28,1,7,28,84,210,462,924,2,22,132,572,2002,6006,16016,5,75,600,3400,15300,58140,193800,14,266,2660,18620,102410,471086,1884344,42,966,11592,96600,627900,3390660,15823080,132,3564,49896,482328,3617460,22428252,119617344}
750	835	1	afc36aa2e2553690c7a2bfe1a41a1f22c288e17715eaf6cdd971a2a5c16bac97	{1,4,10,20,35,56,84,1,9,45,165,495,1287,3003,2,28,210,1120,4760,17136,54264,5,95,950,6650,36575,168245,672980,14,336,4200,36400,245700,1375920,6650280,42,1218,18270,188790,1510320,9968112,56485968,132,4488,78540,942480,8717940,66256344,430666236}
751	836	1	21de22906165a05c552d706f86e7bae21e84183240e9b049135fa3eae872f7ee	{1,4,10,20,35,56,84,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
752	837	1	53bfc9f9297f8b4cf61ed590bf5d724cc27c28f0e61e5b9a172ce5864eacc764	{1,3,6,10,15,21,28,1,5,15,35,70,126,210,1,7,28,84,210,462,924,1,9,45,165,495,1287,3003,1,11,66,286,1001,3003,8008,1,13,91,455,1820,6188,18564,1,15,120,680,3060,11628,38760}
754	839	1	1e848272835eb1d6143b7f875b5701a84f6422fa51809f29b68c14bdd9561f0d	{1,3,6,10,15,21,28,1,2,3,4,5,6,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
755	840	1	975031e26ac0563c80a0a447968d01362b9c654d1fd7147902b301feaed56df7	{1,2,1,0,0,0,0,1,3,3,1,0,0,0,2,8,12,8,2,0,0,5,25,50,50,25,5,0,14,84,210,280,210,84,14,42,294,882,1470,1470,882,294,132,1056,3696,7392,9240,7392,3696}
756	841	1	1e72f9c5f9aee3aeeb9905e113dc3fbc5fb6bb53e5274e5316082636fc78d8da	{1,3,3,1,0,0,0,1,4,6,4,1,0,0,2,10,20,20,10,2,0,5,30,75,100,75,30,5,14,98,294,490,490,294,98,42,336,1176,2352,2940,2352,1176,132,1188,4752,11088,16632,16632,11088}
757	842	1	689b997a481bb63a25886ad3987e9d01c287fb4f570bbf7021ebc75e5eb04fbd	{1,3,3,1,0,0,0,1,5,10,10,5,1,0,2,14,42,70,70,42,14,5,45,180,420,630,630,420,14,154,770,2310,4620,6468,6468,42,546,3276,12012,30030,54054,72072,132,1980,13860,60060,180180,396396,660660}
759	844	1	5ded1dad6a42bdec8c524b5f95d124119aceb452fd36b20ed3e391c6dc54b8d5	{1,2,3,4,5,6,7,1,3,6,10,15,21,28,2,8,20,40,70,112,168,5,25,75,175,350,630,1050,14,84,294,784,1764,3528,6468,42,294,1176,3528,8820,19404,38808,132,1056,4752,15840,43560,104544,226512}
761	846	1	aabeaac4250757f7831c91b07be9dc9694f0aefb34df051abc8b1624c26ca8a9	{1,3,6,10,15,21,28,1,4,10,20,35,56,84,2,10,30,70,140,252,420,5,30,105,280,630,1260,2310,14,98,392,1176,2940,6468,12936,42,336,1512,5040,13860,33264,72072,132,1188,5940,21780,65340,169884,396396}
762	847	1	4d4c482d9b9ffbc7bb7386bdf8ac660d822eaed21f93f0577f6a31abf6a67174	{1,3,6,10,15,21,28,1,1,1,1,1,1,1,1,-1,0,0,0,0,0,1,-3,3,-1,0,0,0,1,-5,10,-10,5,-1,0,1,-7,21,-35,35,-21,7,1,-9,36,-84,126,-126,84}
764	849	1	b44889fda2b0dee4ee77bc6e2919cbe1cc3d8403b11ab70cecacaece2f9c4573	{1,4,10,20,35,56,84,1,1,1,1,1,1,1,1,-2,1,0,0,0,0,1,-5,10,-10,5,-1,0,1,-8,28,-56,70,-56,28,1,-11,55,-165,330,-462,462,1,-14,91,-364,1001,-2002,3003}
765	850	1	65bb8dad9b4714f4756b2b6fed64ef6d4b37b1b144196c47a04207f6b63440e7	{1,1,1,1,1,1,1,2,4,6,8,10,12,14,3,9,18,30,45,63,84,4,16,40,80,140,224,336,5,25,75,175,350,630,1050,6,36,126,336,756,1512,2772,7,49,196,588,1470,3234,6468}
766	851	1	312964730fb7af49c0e8610c129499f99594b6d36c7c966669f39f9f7fbb4bec	{1,1,1,1,1,1,1,2,2,2,2,2,2,2,-1,-1,-1,-1,-1,-1,-1,2,2,2,2,2,2,2,-5,-5,-5,-5,-5,-5,-5,14,14,14,14,14,14,14,-42,-42,-42,-42,-42,-42,-42}
769	854	1	0cbce0d0ee6eef54124ee10120455f9de9ed2c8146d64d93bf7cdc1315a3d136	{1,3,6,10,15,21,28,2,2,2,2,2,2,2,-1,1,0,0,0,0,0,2,-6,6,-2,0,0,0,-5,25,-50,50,-25,5,0,14,-98,294,-490,490,-294,98,-42,378,-1512,3528,-5292,5292,-3528}
770	856	1	ed73974c6ff38197a851c3930e028c40ab4b4f53808560f1813ba64702714e0b	{1,2,1,0,0,0,0,1,1,0,0,0,0,0,2,0,0,0,0,0,0,5,-5,5,-5,5,-5,5,14,-28,42,-56,70,-84,98,42,-126,252,-420,630,-882,1176,132,-528,1320,-2640,4620,-7392,11088}
771	857	1	7fcd44e24397ea7938abbd8e83f32702a80ee5be7f94393966e5337bd80a501f	{1,2,1,0,0,0,0,1,-1,1,-1,1,-1,1,1,-4,10,-20,35,-56,84,1,-7,28,-84,210,-462,924,1,-10,55,-220,715,-2002,5005,1,-13,91,-455,1820,-6188,18564,1,-16,136,-816,3876,-15504,54264}
773	861	1	8f2eb460e6091a63421a102103abca1452e6dda5bc58a776cd1fa33d4eb2a039	{1,3,3,1,0,0,0,1,1,0,0,0,0,0,2,-2,2,-2,2,-2,2,5,-15,30,-50,75,-105,140,14,-70,210,-490,980,-1764,2940,42,-294,1176,-3528,8820,-19404,38808,132,-1188,5940,-21780,65340,-169884,396396}
774	862	1	f786615c440e4b297edf71d8764f3fb412887a9c0519ce3b5312c47635fa5796	{1,3,3,1,0,0,0,1,-2,3,-4,5,-6,7,1,-7,28,-84,210,-462,924,1,-12,78,-364,1365,-4368,12376,1,-17,153,-969,4845,-20349,74613,1,-22,253,-2024,12650,-65780,296010,1,-27,378,-3654,27405,-169911,906192}
775	863	1	d48523214626804903a0023417996476d1450f3195f1015b4e2d06242136483f	{1,3,3,1,0,0,0,1,-5,15,-35,70,-126,210,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
776	865	1	1dd760eeef445de79448689a7525f9d272b2808cc6bee8069feb00083f49b7c8	{1,2,3,4,5,6,7,1,1,1,1,1,1,1,2,0,0,0,0,0,0,5,-5,0,0,0,0,0,14,-28,14,0,0,0,0,42,-126,126,-42,0,0,0,132,-528,792,-528,132,0,0}
779	876	1	9dcd015b40d3a5345896d41c7188d9b9c103303ea474f3dc861213673f924781	{1,2,6,20,70,252,924,1,2,6,20,70,252,924,2,4,12,40,140,504,1848,5,10,30,100,350,1260,4620,14,28,84,280,980,3528,12936,42,84,252,840,2940,10584,38808,132,264,792,2640,9240,33264,121968}
780	878	1	bf7066ffbdc2f44359704f992866f825091b05cf400a35476cd6f4ab0caac32a	{1,2,14,132,1430,16796,208012,1,6,54,572,6630,81396,1040060,3,30,330,3899,48449,624036,8259300,12,168,2184,28560,379848,5139120,70595280,55,990,14850,213180,3028410,43035299,614106900,273,6006,102102,1597596,24174149,360540180,5345400060,1428,37127,705432,11955215,192137400,3004026480,46262007791}
738	819	1	3683427014f469ae00706d1d92e580828bf04e1735c8bbe8af651c0c4a0c1a3e	{1,1,1,1,1,1,1,None,None,None,None,None,None,None,-2,-2,-2,-2,-2,-2,-2,4,4,4,4,4,4,4,-10,-10,-10,-10,-10,-10,-10,28,28,28,28,28,28,28,-84,-84,-84,-84,-84,-84,-84}
799	907	1	c273bcb94f25331e7dd204cba6594cea6cad5d8ee3df79aa09148df0ae700870	{1,2,4,8,16,32,64,1,4,12,32,80,192,448,0,2,12,48,160,480,1344,0,0,4,32,160,640,2240,0,0,0,8,80,480,2240,0,0,0,0,16,192,1344,0,0,0,0,0,32,448}
801	909	1	0e5c7ea298aa9b5c3b2c3bb76bb156d960d6142779ed8c08a6605049918d0ec1	{1,2,-4,16,-80,448,-2688,1,0,4,-32,240,-1792,13440,0,0,-4,48,-480,4480,-40320,0,0,4,-64,800,-8960,94080,0,0,-4,80,-1200,15680,-188160,0,0,4,-96,1680,-25088,338688,0,0,-4,112,-2240,37632,-564480}
802	910	1	abb5d7a61c8704a467b61f0631044aef72394ab5a56bfa784f24b89d33f4fdb7	{-2,4,-16,80,-448,2688,-16896,0,-4,32,-240,1792,-13440,101376,0,4,-48,480,-4480,40320,-354816,0,-4,64,-800,8960,-94080,946176,0,4,-80,1200,-15680,188160,-2128896,0,-4,96,-1680,25088,-338688,4257792,0,4,-112,2240,-37632,564480,-7805952}
805	913	1	9fc94fef752522d286967aa4ea2639a2123bb92a238300bd2f0ece9dc32d7454	{1,2,4,8,16,32,64,1,4,12,32,80,192,448,1,6,24,80,240,672,1792,1,8,40,160,560,1792,5376,1,10,60,280,1120,4032,13440,1,12,84,448,2016,8064,29568,1,14,112,672,3360,14784,59136}
806	914	1	f18600dff19373b60a699e4a8ae345d80a56a2f3721e1fe4c5db0634a1c35ccb	{1,2,8,40,224,1344,8448,1,4,24,160,1120,8064,59136,0,2,24,240,2240,20160,177408,0,0,8,160,2240,26880,295680,0,0,0,40,1120,20160,295680,0,0,0,0,224,8064,177408,0,0,0,0,0,1344,59136}
807	915	1	f5a58ef6cdfb4f247bde0af2643814c5434048e813add6a33c11ab59bed779bd	{0,-1,-2,-8,-40,-224,-1344,0,-1,-4,-24,-160,-1120,-8064,0,0,-2,-24,-240,-2240,-20160,0,0,0,-8,-160,-2240,-26880,0,0,0,0,-40,-1120,-20160,0,0,0,0,0,-224,-8064,0,0,0,0,0,0,-1344}
809	917	1	78fc93f994e536226f9225631d18b4aab0e5abdc3915d78a9330a46936b8ba43	{-1,1,0,0,0,0,0,1,0,0,0,0,0,0,1,1,1,1,1,1,1,2,4,6,8,10,12,14,5,15,30,50,75,105,140,14,56,140,280,490,784,1176,42,210,630,1470,2940,5292,8820}
810	918	1	eb06557ea3fc67ffe7a01e535277756dff0ae6ed040e347ceca9b296372d57de	{1,-2,3,-4,5,-6,7,-1,0,0,0,0,0,0,-1,-2,-1,0,0,0,0,-2,-8,-12,-8,-2,0,0,-5,-30,-75,-100,-75,-30,-5,-14,-112,-392,-784,-980,-784,-392,-42,-420,-1890,-5040,-8820,-10584,-8820}
811	937	1	09506112408d69ebfbe56d2892495782a8a6207ae03838e9cf723db3b1a27b6a	{0,0,1,0,0,0,0,0,2,1,0,0,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
812	938	1	4ddf7827f012347c9c882219cbe394cc71ced7acb022e06d3adb7af859652e4b	{0,0,0,1,0,0,0,0,0,3,1,0,0,0,0,3,3,0,0,0,0,1,3,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
814	940	1	41afbd0349f787394906b250ebaef7af6bb8ae0f5cce591a5cefaf25aefc52cb	{0,0,1,0,0,0,0,0,2,1,0,0,0,0,1,2,1,0,0,0,0,1,2,1,0,0,0,0,1,2,1,0,0,0,0,1,2,1,0,0,0,0,1,2,1,0,0,0,0}
815	941	1	bdbbf1386ec0484dde0ac0690e1a3747a2bbe572f3c0ddda00e4c049d0bd7255	{0,0,0,1,0,0,0,0,0,3,2,0,0,0,0,3,6,3,0,0,0,1,6,9,4,0,0,0,2,9,12,5,0,0,0,3,12,15,6,0,0,0,4,15,18,7,0,0,0}
816	942	1	7148440730c611b1bf450854160e4db431a36e0f606609a6cc82ce1cb69d1f61	{0,0,0,0,1,0,0,0,0,0,4,3,0,0,0,0,6,12,6,0,0,0,4,18,24,10,0,0,1,12,36,40,15,0,0,3,24,60,60,21,0,0,6,40,90,84,28,0,0}
818	944	1	14c84d9ddd182f722a4579a33f89c0603d9da6153c729f042c90cc2b949d5a1b	{1,0,0,0,0,0,0,1,2,0,0,0,0,0,1,4,5,0,0,0,0,1,6,15,14,0,0,0,1,8,30,56,42,0,0,1,10,50,140,210,132,0,1,12,75,280,630,792,429}
819	945	1	f053ed54a22100532ad2d72daf7d4260374b31be5aaad8f51ed4f5e69da00050	{0,0,1,0,0,0,0,0,2,2,0,0,0,0,1,4,1,0,0,0,0,2,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
820	946	1	adad73e51f6fdb3029b632d29e8e7bb6aeaf989f707266af64d119385dabaf03	{0,1,0,0,0,0,0,1,2,0,0,0,0,0,2,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
823	961	1	8ad6ae7c84b02f6a1c1a5c9671db608eb1228d2b6d745c351d402cbbfae723ef	{1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
824	962	1	ce358f7abc86861b5b070a2829e002e207ab60f231bd26d34665f228dbcd65e8	{1,0,0,0,0,0,0,1,0,0,0,0,0,0,1,1,0,0,0,0,0,1,3,0,0,0,0,0,1,6,2,0,0,0,0,1,10,10,0,0,0,0,1,15,30,5,0,0,0}
825	963	1	f1466535b4c68e8e99f11a2bf995d90d52380732b7415aa058496d06306c639d	{1,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-3,0,0,0,0,0,-1,-6,-2,0,0,0}
828	974	1	65120239036e834244d1c8b7c6763bb2c7a1f3df100574e7c231fc4b4a011190	{1,-1,1,-1,1,-1,1,1,0,0,0,0,0,0,-2,-2,0,0,0,0,0,7,14,7,0,0,0,0,-30,-90,-90,-30,0,0,0,143,572,858,572,143,0,0,-728,-3640,-7280,-7280,-3640,-728,0}
829	975	1	c7f6c734f9060ac32b4e1bd7c28ec23a583d4c2a778a15043199d6094842949e	{1,-2,3,-4,5,-6,7,1,-1,1,-1,1,-1,1,-2,0,0,0,0,0,0,7,7,0,0,0,0,0,-30,-60,-30,0,0,0,0,143,429,429,143,0,0,0,-728,-2912,-4368,-2912,-728,0,0}
830	982	1	71d84e59893a0d7ed3240156966af61aa28018ec1ca928fcd10e710c34cf1760	{1,-1,1,-1,1,-1,1,1,0,0,0,0,0,0,1,1,0,0,0,0,0,1,2,1,0,0,0,0,1,3,3,1,0,0,0,1,4,6,4,1,0,0,1,5,10,10,5,1,0}
832	984	1	2613565967029b35eb98ef1e83d9e8069735adff5c773513175020f42d7d4f86	{1,-1,1,-1,1,-1,1,1,0,0,0,0,0,0,2,2,0,0,0,0,0,5,10,5,0,0,0,0,14,42,42,14,0,0,0,42,168,252,168,42,0,0,132,660,1320,1320,660,132,0}
833	985	1	0f1f58e425d7bbd0f1688a82b448641963c53d5844ce8919bca9a62dcbe9dc95	{1,-2,3,-4,5,-6,7,1,-1,1,-1,1,-1,1,2,0,0,0,0,0,0,5,5,0,0,0,0,0,14,28,14,0,0,0,0,42,126,126,42,0,0,0,132,528,792,528,132,0,0}
834	986	1	04bc78e3bcef7affc1baccdd75648b3f30ee2b21d875a99c8bcf05b25bee42e0	{1,1,0,0,0,0,0,2,4,2,0,0,0,0,5,15,15,5,0,0,0,14,56,84,56,14,0,0,42,210,420,420,210,42,0,132,792,1980,2640,1980,792,132,429,3003,9009,15015,15015,9009,3003}
836	988	1	ec1b537c4917855c58d35c0a25c60fabbe37979820b56cad72b7469668a51f2e	{1,-1,1,-1,1,-1,1,2,0,0,0,0,0,0,5,5,0,0,0,0,0,14,28,14,0,0,0,0,42,126,126,42,0,0,0,132,528,792,528,132,0,0,429,2145,4290,4290,2145,429,0}
837	989	1	2d9024edfa504ac18e0559e0c9f5dd2f0602703fb4e4b2b637259eb9052904b2	{1,-2,3,-4,5,-6,7,2,-2,2,-2,2,-2,2,5,0,0,0,0,0,0,14,14,0,0,0,0,0,42,84,42,0,0,0,0,132,396,396,132,0,0,0,429,1716,2574,1716,429,0,0}
838	993	1	4ffad5a856763d25312650e11821367b7e1e0c22353edb22a21475736418b593	{1,-1,0,0,0,0,0,1,0,0,0,0,0,0,1,1,1,1,1,1,1,1,2,3,4,5,6,7,1,3,6,10,15,21,28,1,4,10,20,35,56,84,1,5,15,35,70,126,210}
839	994	1	b43cb92e02bbfefd6cfc232eefffa10835b56906033b4c9a66230ee3097016ae	{1,-2,1,0,0,0,0,1,-1,0,0,0,0,0,1,0,0,0,0,0,0,1,1,1,1,1,1,1,1,2,3,4,5,6,7,1,3,6,10,15,21,28,1,4,10,20,35,56,84}
842	1126	3	148d8a195fab1885a3cd20fffa32e54ac3bfaff881dae29a036f3dcbd7bea598	{None,0,0,0,0,0,0,3,9,27,84,270,891,3003,3,18,81,330,1287,4914,18564,1,9,54,273,1260,5508,23256,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
843	1131	3	0f423e20c8ad42953b7ce79e31fbe11060c0d153884570fbe8eb0f7d6896bba0	{None,0,0,0,0,0,0,1,3,9,28,90,297,1001,1,6,27,110,429,1638,6188,1,9,54,273,1260,5508,23256,1,12,90,544,2907,14364,67298,1,15,135,950,5775,31878,164450,1,18,189,1518,10350,63180,356265}
844	1132	3	df04a2ecd2fc46e463277c91b734d397189c90768c36c4f89aad99045559a888	{None,0,0,0,0,0,0,1,4,14,48,165,572,2002,1,8,44,208,910,3808,15504,1,12,90,544,2907,14364,67298,1,16,152,1120,7084,40480,215280,1,20,230,2000,14625,95004,566370,1,24,324,3248,26970,196416,1298528}
782	880	1	03f2077c1d342d78fa932c242531e0f076e56d62c21461749903c472d1428927	{1,2,1,0,0,0,0,2,-2,2,-2,2,-2,2,-1,4,-10,20,-35,56,-84,2,-14,56,-168,420,-924,1848,-5,50,-275,1100,-3575,10010,-25025,14,-182,1274,-6370,25480,-86632,259896,-42,672,-5712,34272,-162792,651168,-2279088}
783	882	1	48c732633bf250d037e0ac1c5674425dddbaf4203dc66dd74472e0ca9bcc3d8c	{1,3,3,1,0,0,0,2,2,0,0,0,0,0,3,-3,3,-3,3,-3,3,4,-12,24,-40,60,-84,112,5,-25,75,-175,350,-630,1050,6,-42,168,-504,1260,-2772,5544,7,-63,315,-1155,3465,-9009,21021}
784	883	1	f396e5d4e8293f54eaf94040c45d9f6a3a6f9ce85f150e77fcb3c620920f75ab	{1,3,3,1,0,0,0,2,-4,6,-8,10,-12,14,-1,7,-28,84,-210,462,-924,2,-24,156,-728,2730,-8736,24752,-5,85,-765,4845,-24225,101745,-373065,14,-308,3542,-28336,177100,-920920,4144140,-42,1134,-15876,153468,-1151010,7136262,-38060064}
786	886	1	d75c23f83193224aa4512f44b0797624f2d9b324bfc9eb7cdfdad5a862a36c63	{1,1,0,0,0,0,0,2,2,0,0,0,0,0,-1,-1,0,0,0,0,0,2,2,0,0,0,0,0,-5,-5,0,0,0,0,0,14,14,0,0,0,0,0,-42,-42,0,0,0,0,0}
787	889	1	bccbf54702570d28e1bf9cf38734a02e1a5b2746b8ae5e01691bb8cf1b90317d	{1,3,3,1,0,0,0,2,4,2,0,0,0,0,3,3,0,0,0,0,0,4,0,0,0,0,0,0,5,-5,5,-5,5,-5,5,6,-12,18,-24,30,-36,42,7,-21,42,-70,105,-147,196}
788	890	1	1af650b07b288b42a03449fec4c7deab8203780939e8f7fbfdcc2b3920f50e68	{1,3,3,1,0,0,0,2,-2,2,-2,2,-2,2,-1,5,-15,35,-70,126,-210,2,-18,90,-330,990,-2574,6006,-5,65,-455,2275,-9100,30940,-92820,14,-238,2142,-13566,67830,-284886,1044582,-42,882,-9702,74382,-446292,2231460,-9669660}
789	893	1	65480844be89c3154e4ea4383c8396101e41346ca13df5c234dee0fdbb053f33	{1,2,3,4,5,6,7,2,2,2,2,2,2,2,3,0,0,0,0,0,0,4,-4,0,0,0,0,0,5,-10,5,0,0,0,0,6,-18,18,-6,0,0,0,7,-28,42,-28,7,0,0}
790	894	1	7e668d533787a4bf9cae32890c6bf5758100a3d51ca1036afb01d91de12da141	{1,2,3,4,5,6,7,2,-2,0,0,0,0,0,-1,4,-6,4,-1,0,0,2,-14,42,-70,70,-42,14,-5,50,-225,600,-1050,1260,-1050,14,-182,1092,-4004,10010,-18018,24024,-42,672,-5040,23520,-76440,183456,-336336}
792	897	1	1786b3809812434382caaa4794c77a01a82a9f645ea758da26f14df1030c74f4	{1,3,6,10,15,21,28,2,-4,2,0,0,0,0,-1,7,-21,35,-35,21,-7,2,-24,132,-440,990,-1584,1848,-5,85,-680,3400,-11900,30940,-61880,14,-308,3234,-21560,102410,-368676,1044582,-42,1134,-14742,122850,-737100,3390660,-12432420}
793	901	1	e3fc6f27386336c320cd06b8451fb77378ebe0b1a78d5787adabd57860f4159d	{1,3,6,10,15,21,28,2,4,6,8,10,12,14,3,3,3,3,3,3,3,4,0,0,0,0,0,0,5,-5,0,0,0,0,0,6,-12,6,0,0,0,0,7,-21,21,-7,0,0,0}
797	905	1	9f250e15a302fc67880545e8e8df3e86a54089f2c678979d77fad653ccb35285	{2,1,0,0,0,0,0,4,4,1,0,0,0,0,8,12,6,1,0,0,0,16,32,24,8,1,0,0,32,80,80,40,10,1,0,64,192,240,160,60,12,1,128,448,672,560,280,84,14}
795	903	1	2a391b62b67d46260c21e1b07f5e4f675e25969fd1aeade79f65de8c8ac41c44	{1,None,None,None,None,None,None,None,3,3,1,0,0,0,None,10,20,20,10,2,0,None,35,105,175,175,105,35,None,126,504,1176,1764,1764,1176,None,462,2310,6930,13860,19404,19404,None,1716,10296,37752,94380,169884,226512}
798	906	1	f57028d81c8a2f962dd97908c74c2394fcd2f53aff930505349103b860479236	{2,1,0,0,0,0,0,8,12,6,1,0,0,0,64,160,160,80,20,2,0,640,2240,3360,2800,1400,420,70,7168,32256,64512,75264,56448,28224,9408,86016,473088,1182720,1774080,1774080,1241856,620928,1081344,7028736,21086208,38658048,48322560,43490304,28993536}
846	1134	3	7aafa5b21a477a8a0cb1587220c85ce8c24a8e2c501867b603fcff57eea6774e	{1,0,0,0,0,0,0,2,4,2,0,0,0,0,3,12,18,12,3,0,0,4,24,60,80,60,24,4,5,40,140,280,350,280,140,6,60,270,720,1260,1512,1260,7,84,462,1540,3465,5544,6468}
847	1135	3	70d73283e693eb3f024b042b36d50c0c1529fd74bbcb881e5d851150a0b982b9	{1,0,0,0,0,0,0,2,6,6,2,0,0,0,3,18,45,60,45,18,3,4,36,144,336,504,504,336,5,60,330,1100,2475,3960,4620,6,90,630,2730,8190,18018,30030,7,126,1071,5712,21420,59976,129948}
848	1136	3	7f48290da9d9b37b97a846dd83995e54df44e2d69b502f1cd7ece605af1afc78	{1,0,0,0,0,0,0,2,4,6,8,10,12,14,3,12,30,60,105,168,252,4,24,84,224,504,1008,1848,5,40,180,600,1650,3960,8580,6,60,330,1320,4290,12012,30030,7,84,546,2548,9555,30576,86632}
849	1137	3	8ae4229931f00ac99996d1ec9195e15d735330a9024a7b0d08f16471a34df445	{1,0,0,0,0,0,0,2,6,12,20,30,42,56,3,18,63,168,378,756,1386,4,36,180,660,1980,5148,12012,5,60,390,1820,6825,21840,61880,6,90,720,4080,18360,69768,232560,7,126,1197,7980,41895,184338,706629}
851	1139	3	e3711bf266c99e0bc863a19b69527f78f9813d67a58d33bf8cbb1d9dc455d01f	{None,0,0,0,0,0,0,2,6,18,56,180,594,2002,3,18,81,330,1287,4914,18564,4,36,216,1092,5040,22032,93024,5,60,450,2720,14535,71820,336490,6,90,810,5700,34650,191268,986700,7,126,1323,10626,72450,442260,2493855}
852	1141	3	80e2390f7e5181a8fa74ce0595fc2128e8a0e57037ed72edc11e4d1e8d0f8e40	{None,0,0,0,0,0,0,2,8,28,96,330,1144,4004,3,24,132,624,2730,11424,46512,4,48,360,2176,11628,57456,269192,5,80,760,5600,35420,202400,1076400,6,120,1380,12000,87750,570024,3398220,7,168,2268,22736,188790,1374912,9089696}
853	1142	3	01bfc48faf5ca2efd9c317c949e111e6899f65883bbbcdc60a315234c5da779e	{None,0,0,0,0,0,0,2,12,54,220,858,3276,12376,3,36,270,1632,8721,43092,201894,4,72,756,6072,41400,252720,1425060,5,120,1620,16240,134850,982080,6492640,6,180,2970,35700,349650,2961036,22481940,7,252,4914,68880,777483,7509348,64425438}
854	1143	3	2c535de8a316641a5bc7933f38dc904678f564169d8f867ecf8a43fc4dab2d01	{1,0,0,0,0,0,0,3,3,0,0,0,0,0,6,12,6,0,0,0,0,10,30,30,10,0,0,0,15,60,90,60,15,0,0,21,105,210,210,105,21,0,28,168,420,560,420,168,28}
856	1145	3	297649cb19d921a4dccdfc36ca051000350e03fdde0cc3462ba2dc783c6f1b2e	{1,0,0,0,0,0,0,3,9,9,3,0,0,0,6,36,90,120,90,36,6,10,90,360,840,1260,1260,840,15,180,990,3300,7425,11880,13860,21,315,2205,9555,28665,63063,105105,28,504,4284,22848,85680,239904,519792}
857	1146	3	aa1ae251bb461036db13ab7dfec6e30b28ae062acb5613e6c98f79398ef67027	{1,0,0,0,0,0,0,3,3,3,3,3,3,3,6,12,18,24,30,36,42,10,30,60,100,150,210,280,15,60,150,300,525,840,1260,21,105,315,735,1470,2646,4410,28,168,588,1568,3528,7056,12936}
859	1148	3	f7d94de2f4a8df582b4aa86db93df414390335a84973f37b36d977da882ae936	{1,0,0,0,0,0,0,3,9,18,30,45,63,84,6,36,126,336,756,1512,2772,10,90,450,1650,4950,12870,30030,15,180,1170,5460,20475,65520,185640,21,315,2520,14280,64260,244188,813960,28,504,4788,31920,167580,737352,2826516}
861	1150	3	89ffc1e2bc5155662878264b19042e19aee23bb393288c70fe3a0494ae8516c5	{None,0,0,0,0,0,0,3,6,15,42,126,396,1287,6,24,84,288,990,3432,12012,10,60,270,1100,4290,16380,61880,15,120,660,3120,13650,57120,232560,21,210,1365,7350,35700,162792,712215,28,336,2520,15232,81396,402192,1884344}
862	1151	3	62ebc224724dac33aa5208dcb191a842aff1f8c30f1d174d84efdcb4d961b1d3	{None,0,0,0,0,0,0,3,9,27,84,270,891,3003,6,36,162,660,2574,9828,37128,10,90,540,2730,12600,55080,232560,15,180,1350,8160,43605,215460,1009470,21,315,2835,19950,121275,669438,3453450,28,504,5292,42504,289800,1769040,9975420}
863	1153	3	e1fc51909a7d8ff889774de0bfcd56e1f8d3c7696aad61ce0386672b990b1d42	{None,0,0,0,0,0,0,3,12,42,144,495,1716,6006,6,48,264,1248,5460,22848,93024,10,120,900,5440,29070,143640,672980,15,240,2280,16800,106260,607200,3229200,21,420,4830,42000,307125,1995084,11893770,28,672,9072,90944,755160,5499648,36358784}
864	1154	3	11fa36afa753b0f9dea6f17db735b1ea499fabe8ace9b19ef1c2f20d3ad9dd54	{None,0,0,0,0,0,0,3,18,81,330,1287,4914,18564,6,72,540,3264,17442,86184,403788,10,180,1890,15180,103500,631800,3562650,15,360,4860,48720,404550,2946240,19477920,21,630,10395,124950,1223775,10363626,78686790,28,1008,19656,275520,3109932,30037392,257701752}
866	1156	3	a057ec8b723364f762ce6f073c44e47cee475733197f7b1035dde50c7c726729	{None,0,0,0,0,0,0,1,3,9,28,90,297,1001,2,12,54,220,858,3276,12376,5,45,270,1365,6300,27540,116280,14,168,1260,7616,40698,201096,942172,42,630,5670,39900,242550,1338876,6906900,132,2376,24948,200376,1366200,8339760,47026980}
867	1157	3	8e5054875a1f0dcd173f5f18d22c81d5784c1805c3f878631e09261b009ece95	{None,0,0,0,0,0,0,1,4,14,48,165,572,2002,2,16,88,416,1820,7616,31008,5,60,450,2720,14535,71820,336490,14,224,2128,15680,99176,566720,3013920,42,840,9660,84000,614250,3990168,23787540,132,3168,42768,428736,3560040,25926912,171405696}
868	1158	3	bb0662702cb67bc3802ab709e3f5bea3fec47b87bed7b7ed4a7d8f54ed15c7d5	{None,0,0,0,0,0,0,1,6,27,110,429,1638,6188,2,24,180,1088,5814,28728,134596,5,90,945,7590,51750,315900,1781325,14,336,4536,45472,377580,2749824,18179392,42,1260,20790,249900,2447550,20727252,157373580,132,4752,92664,1298880,14661108,141604848,1214879688}
870	1161	3	f954418a572ee9ffb527bbbc64dc47587a8ed00d11833450f6b55410207d9956	{1,0,0,0,0,0,0,2,6,6,2,0,0,0,5,30,75,100,75,30,5,14,126,504,1176,1764,1764,1176,42,504,2772,9240,20790,33264,38808,132,1980,13860,60060,180180,396396,660660,429,7722,65637,350064,1312740,3675672,7963956}
871	1162	3	4d43c5309da337dfa767936caeb871f8246fe271c02131b2ed1ea7077d0ca7d5	{1,0,0,0,0,0,0,2,6,12,20,30,42,56,5,30,105,280,630,1260,2310,14,126,630,2310,6930,18018,42042,42,504,3276,15288,57330,183456,519792,132,1980,15840,89760,403920,1534896,5116320,429,7722,73359,489060,2567565,11297286,43306263}
872	1163	3	145ebcae4778c9335e8d3c0721fa8385ea8a97847ed3a63a1bf0bec5eb8f25f9	{None,0,0,0,0,0,0,2,4,10,28,84,264,858,5,20,70,240,825,2860,10010,14,84,378,1540,6006,22932,86632,42,336,1848,8736,38220,159936,651168,132,1320,8580,46200,224400,1023264,4476780,429,5148,38610,233376,1247103,6162156,28870842}
873	1164	3	939990c13279f457a7446c42a742bc38d10000e7cc38c3bf34fa1069d71b398c	{None,0,0,0,0,0,0,2,6,18,56,180,594,2002,5,30,135,550,2145,8190,30940,14,126,756,3822,17640,77112,325584,42,504,3780,22848,122094,603288,2826516,132,1980,17820,125400,762300,4207896,21707400,429,7722,81081,651222,4440150,27104220,152837685}
876	1168	3	a5decde4a6ba187d219174eac20b72376f71c27f11ffba78c47b6670d15f39e4	{1,0,0,0,0,0,0,3,3,0,0,0,0,0,9,18,9,0,0,0,0,28,84,84,28,0,0,0,90,360,540,360,90,0,0,297,1485,2970,2970,1485,297,0,1001,6006,15015,20020,15015,6006,1001}
877	1169	3	83534787bb5c1c8c0c2a50475cdec3b79e61d4c2f62f5b360850d4e3597e35db	{1,0,0,0,0,0,0,3,6,3,0,0,0,0,9,36,54,36,9,0,0,28,168,420,560,420,168,28,90,720,2520,5040,6300,5040,2520,297,2970,13365,35640,62370,74844,62370,1001,12012,66066,220220,495495,792792,924924}
878	1170	3	88ce7bdf1a0e8b38a47aa811083eb4ad4d16d19d31ee6d23e5d22fe65bf3962a	{1,0,0,0,0,0,0,3,9,9,3,0,0,0,9,54,135,180,135,54,9,28,252,1008,2352,3528,3528,2352,90,1080,5940,19800,44550,71280,83160,297,4455,31185,135135,405405,891891,1486485,1001,18018,153153,816816,3063060,8576568,18582564}
880	1172	3	c494b34faf3705b99d2420c4cc5bcf22e1dd7a53200eabb5f8f1e42dcf1e1f81	{1,0,0,0,0,0,0,3,6,9,12,15,18,21,9,36,90,180,315,504,756,28,168,588,1568,3528,7056,12936,90,720,3240,10800,29700,71280,154440,297,2970,16335,65340,212355,594594,1486485,1001,12012,78078,364364,1366365,4372368,12388376}
881	1173	3	cb3e043d836a60b0b07066955e7b3ead56ff8de3704478119a2bb9229aa85b8f	{1,0,0,0,0,0,0,3,9,18,30,45,63,84,9,54,189,504,1134,2268,4158,28,252,1260,4620,13860,36036,84084,90,1080,7020,32760,122850,393120,1113840,297,4455,35640,201960,908820,3453516,11511720,1001,18018,171171,1141140,5990985,26360334,101047947}
882	1174	3	c07c35c4cd286f75c46d66a30db58624f88c9801b3a54cd82e60466b3e47063e	{None,0,0,0,0,0,0,3,3,6,15,42,126,396,9,18,45,126,378,1188,3861,28,84,252,784,2520,8316,28028,90,360,1260,4320,14850,51480,180180,297,1485,5940,22275,81675,297297,1081080,1001,6006,27027,110110,429429,1639638,6194188}
883	1175	3	eaff57074a8d5c01aca9d9be240b6fcc20c4ac9b7b65af22213e49ba3930121d	{None,0,0,0,0,0,0,3,6,15,42,126,396,1287,9,36,126,432,1485,5148,18018,28,168,756,3080,12012,45864,173264,90,720,3960,18720,81900,342720,1395360,297,2970,19305,103950,504900,2302344,10072755,1001,12012,90090,544544,2909907,14378364,67365298}
885	1178	3	23ea1b2e94c219012368eab45a752c05e9ed8c56708e3d3c908037d95d84f8ea	{None,0,0,0,0,0,0,3,12,42,144,495,1716,6006,9,72,396,1872,8190,34272,139536,28,336,2520,15232,81396,402192,1884344,90,1440,13680,100800,637560,3643200,19375200,297,5940,68310,594000,4343625,28216188,168211890,1001,24024,324324,3251248,26996970,196612416,1299826528}
886	1179	3	94ec520064864dedd3957a571ea10cfd783b71abd549860f965a9ebcd7dfb885	{None,0,0,0,0,0,0,3,18,81,330,1287,4914,18564,9,108,810,4896,26163,129276,605682,28,504,5292,42504,289800,1769040,9975420,90,2160,29160,292320,2427300,17677440,116867520,297,8910,147015,1767150,17307675,146571282,1112856030,1001,36036,702702,9849840,111180069,1073836764,9212837634}
887	1190	3	71af17df1dfc57db04fddd5b66df478fd51eaee1cdb56b9ed5950a9aed7a6e35	{1,0,0,0,0,0,0,4,8,4,0,0,0,0,14,56,84,56,14,0,0,48,288,720,960,720,288,48,165,1320,4620,9240,11550,9240,4620,572,5720,25740,68640,120120,144144,120120,2002,24024,132132,440440,990990,1585584,1849848}
888	1191	3	9f0246d2d4e19261c14f28b9a68218753d7513ef7433f81c617a69bc6f1e3762	{1,0,0,0,0,0,0,4,12,12,4,0,0,0,14,84,210,280,210,84,14,48,432,1728,4032,6048,6048,4032,165,1980,10890,36300,81675,130680,152460,572,8580,60060,260260,780780,1717716,2862860,2002,36036,306306,1633632,6126120,17153136,37165128}
890	1193	3	47d49133577acbf5ed29cdf445396257581180147df6d0a8212a9ee8e1c87a9d	{1,0,0,0,0,0,0,4,8,12,16,20,24,28,14,56,140,280,490,784,1176,48,288,1008,2688,6048,12096,22176,165,1320,5940,19800,54450,130680,283140,572,5720,31460,125840,408980,1145144,2862860,2002,24024,156156,728728,2732730,8744736,24776752}
892	1195	3	3707b2a11b7d9be97009efeedc3354eb1367d05a1ae30dcd0bb7b0ba9bde51c0	{None,0,0,0,0,0,0,4,4,8,20,56,168,528,14,28,70,196,588,1848,6006,48,144,432,1344,4320,14256,48048,165,660,2310,7920,27225,94380,330330,572,2860,11440,42900,157300,572572,2082080,2002,12012,54054,220220,858858,3279276,12388376}
893	1196	3	ec9a2c25bb64c75b01b11eb4cd7ba48c82e04802303e8a9c3ad006cb162b3c1a	{None,0,0,0,0,0,0,4,8,20,56,168,528,1716,14,56,196,672,2310,8008,28028,48,288,1296,5280,20592,78624,297024,165,1320,7260,34320,150150,628320,2558160,572,5720,37180,200200,972400,4434144,19399380,2002,24024,180180,1089088,5819814,28756728,134730596}
894	1197	3	7bb2d108bffda4dcf4556dae68dc69f4c4edb902d0029c8195502ac343aeb447	{None,0,0,0,0,0,0,4,12,36,112,360,1188,4004,14,84,378,1540,6006,22932,86632,48,432,2592,13104,60480,264384,1116288,165,1980,14850,89760,479655,2370060,11104170,572,8580,77220,543400,3303300,18234216,94065400,2002,36036,378378,3039036,20720700,126486360,713242530}
896	1201	3	905cc5ecbedf901926fbdf924e4815825fadfca1c5ee994cc70db5ce4dc647a5	{1,0,0,0,0,0,0,6,6,0,0,0,0,0,27,54,27,0,0,0,0,110,330,330,110,0,0,0,429,1716,2574,1716,429,0,0,1638,8190,16380,16380,8190,1638,0,6188,37128,92820,123760,92820,37128,6188}
897	1202	3	4f64d049e820f1ac4e0977265f1a7a0078561de437c0a36db3a11a51d32878f2	{1,0,0,0,0,0,0,6,12,6,0,0,0,0,27,108,162,108,27,0,0,110,660,1650,2200,1650,660,110,429,3432,12012,24024,30030,24024,12012,1638,16380,73710,196560,343980,412776,343980,6188,74256,408408,1361360,3063060,4900896,5717712}
898	1203	3	170e8679eeaec2c1fb149598ae180f9b7edb078d5ab36e1c48f79bb0282d5a07	{1,0,0,0,0,0,0,6,18,18,6,0,0,0,27,162,405,540,405,162,27,110,990,3960,9240,13860,13860,9240,429,5148,28314,94380,212355,339768,396396,1638,24570,171990,745290,2235870,4918914,8198190,6188,111384,946764,5049408,18935280,53018784,114874032}
899	1204	3	506d3f09b34bd6ca041429ce91b72b0b8e539fde0affb5a5dfc84516cd3bb8bb	{1,0,0,0,0,0,0,6,6,6,6,6,6,6,27,54,81,108,135,162,189,110,330,660,1100,1650,2310,3080,429,1716,4290,8580,15015,24024,36036,1638,8190,24570,57330,114660,206388,343980,6188,37128,129948,346528,779688,1559376,2858856}
901	1206	3	7181873f9330019e4cb81d7e6e4f5fcc0b4168d604b7307da7b2ff4cb3fdd698	{1,0,0,0,0,0,0,6,18,36,60,90,126,168,27,162,567,1512,3402,6804,12474,110,990,4950,18150,54450,141570,330330,429,5148,33462,156156,585585,1873872,5309304,1638,24570,196560,1113840,5012280,19046664,63488880,6188,111384,1058148,7054320,37035180,162954792,624660036}
902	1207	3	f21d1fe3d90c528e43dc041a2e4765903ed997235677f9c5e42a8ac5b682419f	{None,0,0,0,0,0,0,6,6,12,30,84,252,792,27,54,135,378,1134,3564,11583,110,330,990,3080,9900,32670,110110,429,1716,6006,20592,70785,245388,858858,1638,8190,32760,122850,450450,1639638,5962320,6188,37128,167076,680680,2654652,10135944,38291344}
903	1208	3	b993109bbac476efbe26f363154f357c084a44ad056ee7484feb9d90dbec1336	{None,0,0,0,0,0,0,6,12,30,84,252,792,2574,27,108,378,1296,4455,15444,54054,110,660,2970,12100,47190,180180,680680,429,3432,18876,89232,390390,1633632,6651216,1638,16380,106470,573300,2784600,12697776,55552770,6188,74256,556920,3366272,17988516,88884432,416440024}
904	1209	3	fb2c447749f6b30832f5d4d37ad75ce55dc88c9ee266e6d125dff82b1db57314	{None,0,0,0,0,0,0,6,18,54,168,540,1782,6006,27,162,729,2970,11583,44226,167076,110,990,5940,30030,138600,605880,2558160,429,5148,38610,233376,1247103,6162156,28870842,1638,24570,221130,1556100,9459450,52216164,269369100,6188,111384,1169532,9393384,64045800,390957840,2204567820}
908	1214	3	3da606faa5d8463f6120774e0c6969d95a2ffb4388d19629aac8ebd38ee12470	{1,3,9,28,90,297,1001,1,6,27,110,429,1638,6188,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
909	1215	3	cebd7fa14d8ae63a70b99558a7982402feff105319bae491876a65a8cbd57acb	{1,4,14,48,165,572,2002,1,8,44,208,910,3808,15504,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
911	1219	3	4347a02c50a0332116838cc59d61a9a1038d1ff568c51d0677d7f26199fed7a6	{1,3,3,1,0,0,0,2,12,30,40,30,12,2,1,9,36,84,126,126,84,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
912	1222	3	72ae2d5f37955a4959e91ce14cdbdb078c93a0b04cdd0d10890bacee3bbb05b7	{1,3,6,10,15,21,28,2,12,42,112,252,504,924,1,9,45,165,495,1287,3003,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
913	1225	3	c8eec8a7658be931b0420b67738b075914f6cbcbc5564e3e2f0de5bd3bc661f1	{1,3,9,28,90,297,1001,2,12,54,220,858,3276,12376,1,9,54,273,1260,5508,23256,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
916	1230	3	cc9382e54340a859c4f4b5534b87f6ec25df640454a2175b382a7a17c095c700	{1,2,1,0,0,0,0,3,12,18,12,3,0,0,3,18,45,60,45,18,3,1,8,28,56,70,56,28,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
917	1231	3	8f5218e0a9f9c4b70ac1cc4c748868ae132b95a4d408ebeca8afa8d4e4ef0583	{1,3,3,1,0,0,0,3,18,45,60,45,18,3,3,27,108,252,378,378,252,1,12,66,220,495,792,924,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
918	1232	3	e403c22e962f31f68734b27ee1c3b7b112a27e09eb69139c05f424c0f52b294f	{1,1,1,1,1,1,1,3,6,9,12,15,18,21,3,9,18,30,45,63,84,1,4,10,20,35,56,84,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
919	1233	3	537f0abc1c32017ad7f2369f57ad90c37f9177da5ce83538ab0caee55250b366	{1,2,3,4,5,6,7,3,12,30,60,105,168,252,3,18,63,168,378,756,1386,1,8,36,120,330,792,1716,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
921	1235	3	ca76c08ac573097236215f8e2f73d91fecc96944d54d94607334b0ce449a25f5	{1,1,2,5,14,42,132,3,6,15,42,126,396,1287,3,9,27,84,270,891,3003,1,4,14,48,165,572,2002,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
922	1236	3	ca796b9819e119b7cedc5880d0d46a005ebbe82fa5692a889e85965a4f84ec2a	{1,2,5,14,42,132,429,3,12,42,144,495,1716,6006,3,18,81,330,1287,4914,18564,1,8,44,208,910,3808,15504,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
923	1237	3	c870e6696867494fe1d69317aea6dbb1e8796d35dbc2eb76d5105b0c65aeda98	{1,3,9,28,90,297,1001,3,18,81,330,1287,4914,18564,3,27,162,819,3780,16524,69768,1,12,90,544,2907,14364,67298,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
942	1396	5	56fda9a9a25d1300739a55baf4e381696f58a6e07e2cc8ae3a8d8ed4807beef5	{1,1,0,0,0,0,0,3,6,0,0,0,0,0,6,21,0,0,0,0,0,10,56,0,0,0,0,0,15,126,0,0,0,0,0,21,252,0,0,0,0,0,28,462,0,0,0,0,0}
926	1241	3	a6eecf8db62446ac7521c5176747c96972db33c06dd7a8c46f5399e08b17731a	{1,3,6,10,15,21,28,1,6,21,56,126,252,462,1,9,45,165,495,1287,3003,1,12,78,364,1365,4368,12376,1,15,120,680,3060,11628,38760,1,18,171,1140,5985,26334,100947,1,21,231,1771,10626,53130,230230}
927	1242	3	89d85be206bf095957ba3875189eb3dbb6dd6356adcfcd91bbf5a7eddbd7f606	{1,3,9,28,90,297,1001,1,6,27,110,429,1638,6188,1,9,54,273,1260,5508,23256,1,12,90,544,2907,14364,67298,1,15,135,950,5775,31878,164450,1,18,189,1518,10350,63180,356265,1,21,252,2275,17199,115101,704816}
928	1243	3	0a2e85fa26c723bf265162cae4987b76dae8c0b8371b2f54a8ffd5f2aed914b3	{1,4,14,48,165,572,2002,1,8,44,208,910,3808,15504,1,12,90,544,2907,14364,67298,1,16,152,1120,7084,40480,215280,1,20,230,2000,14625,95004,566370,1,24,324,3248,26970,196416,1298528,1,28,434,4928,45815,369852,2686866}
929	1244	3	2626a5d5dce2751f76404eae489570891190fd4d3b398229bd98e3a5428bce31	{1,6,27,110,429,1638,6188,1,12,90,544,2907,14364,67298,1,18,189,1518,10350,63180,356265,1,24,324,3248,26970,196416,1298528,1,30,495,5950,58275,493506,3746990,1,36,702,9840,111069,1072764,9203634,1,42,945,15134,193452,2099160,20087795}
931	1246	3	0abb09660bca1784b2b7f5a3144051b7e40fc9f1c3141252e1878f152ce15ad1	{1,3,3,1,0,0,0,2,12,30,40,30,12,2,3,27,108,252,378,378,252,4,48,264,880,1980,3168,3696,5,75,525,2275,6825,15015,25025,6,108,918,4896,18360,51408,111384,7,147,1470,9310,41895,142443,379848}
932	1247	3	1817b468c4c6a6530654c09519e1df668882720f7111c105a45dd4756135ac62	{1,2,3,4,5,6,7,2,8,20,40,70,112,168,3,18,63,168,378,756,1386,4,32,144,480,1320,3168,6864,5,50,275,1100,3575,10010,25025,6,72,468,2184,8190,26208,74256,7,98,735,3920,16660,59976,189924}
933	1248	3	6cfaf507e32bffd4e71e4b172ec688998598a7dc9827d17cd0655e5166101e5a	{1,3,6,10,15,21,28,2,12,42,112,252,504,924,3,27,135,495,1485,3861,9009,4,48,312,1456,5460,17472,49504,5,75,600,3400,15300,58140,193800,6,108,1026,6840,35910,158004,605682,7,147,1617,12397,74382,371910,1611610}
935	1250	3	8327d05f513154f89b7f6373934e5cbbc0aeffe8f20c5463c5a3bfac5267f7d9	{1,3,9,28,90,297,1001,2,12,54,220,858,3276,12376,3,27,162,819,3780,16524,69768,4,48,360,2176,11628,57456,269192,5,75,675,4750,28875,159390,822250,6,108,1134,9108,62100,379080,2137590,7,147,1764,15925,120393,805707,4933712}
936	1390	5	c369f1d8c27a2fbe7543603601138f4cda0d34ece45932d60a85edac130da028	{1,1,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0}
937	1391	5	e4a40c3b99ac94c2dd0926d6bdb0e744e01e170c76cce581b85b88df0ae9dce7	{1,1,0,0,0,0,0,2,3,0,0,0,0,0,3,6,0,0,0,0,0,4,10,0,0,0,0,0,5,15,0,0,0,0,0,6,21,0,0,0,0,0,7,28,0,0,0,0,0}
939	1393	5	1fb18e63c880e3bc4933f79e16590521e8fcd8678ba27fcf82adc99223cfc43b	{1,1,0,0,0,0,0,3,5,0,0,0,0,0,6,15,0,0,0,0,0,10,35,0,0,0,0,0,15,70,0,0,0,0,0,21,126,0,0,0,0,0,28,210,0,0,0,0,0}
940	1394	5	3d2a55ead7f4e6ba25ee6169aa1f20fecc40d2edbdb42f93db0467f1e659b532	{1,1,0,0,0,0,0,1,4,0,0,0,0,0,1,10,0,0,0,0,0,1,20,0,0,0,0,0,1,35,0,0,0,0,0,1,56,0,0,0,0,0,1,84,0,0,0,0,0}
941	1395	5	123a6644017f5a5788d20e557acf204689c34b3b63954c6419c7bbb77f46b80a	{1,1,0,0,0,0,0,2,5,0,0,0,0,0,3,15,0,0,0,0,0,4,35,0,0,0,0,0,5,70,0,0,0,0,0,6,126,0,0,0,0,0,7,210,0,0,0,0,0}
945	1399	5	a07179deb48d7ee854050241537c3c4f9c109d9b7048313e217088e70f602fab	{1,1,0,0,0,0,0,3,4,0,0,0,0,0,3,6,0,0,0,0,0,1,4,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
946	1400	5	51edbdf769466cabd9979540cc76ab0ccf173334545c0e786dc783c953e8c7dc	{1,1,0,0,0,0,0,0,2,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
948	1402	5	58ecf52c1d250fe41aa364e680a2194904fe8b54954cc021b380ac31afecebea	{1,1,0,0,0,0,0,3,5,0,0,0,0,0,3,10,0,0,0,0,0,1,10,0,0,0,0,0,0,5,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0}
949	1403	5	75d9788c5d798a2f7427abaec3598b8440d64c0303815ba5170cf3ed0d38c632	{1,1,0,0,0,0,0,0,3,0,0,0,0,0,0,3,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
950	1404	5	56d60f15cbd600c8e039ffdd7f44a7780ac8ecd47fd49a43683b4fdb31dee731	{1,1,0,0,0,0,0,1,4,0,0,0,0,0,0,6,0,0,0,0,0,0,4,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
951	1405	5	21493bd7d5f2aae2bd1ba3de30ea75ad9f39491d7987002dee4dfed1b00cabf8	{1,1,0,0,0,0,0,2,5,0,0,0,0,0,1,10,0,0,0,0,0,0,10,0,0,0,0,0,0,5,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0}
953	1407	5	d04f3280d45817379f5ee7298e6ec167fba5c62624e18b62785bf97e5754e98e	{1,3,3,1,0,0,0,1,4,6,4,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
954	1408	5	7fe9cc65d6f4ba452e84ee34bb6ed8234b9e742a160cd91cd6d157b3b82c0a70	{1,3,3,1,0,0,0,1,5,10,10,5,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
955	1409	5	a83c45ff48a59a232705c0613771bc187b0b425310863cb13ddb6d4b0ba90146	{1,1,0,0,0,0,0,1,4,6,4,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
957	1411	5	bc883f37a8c80e7465650dd625f2ca304d6310dd981bbe631a9fe420aed19298	{1,3,3,1,0,0,0,1,6,15,20,15,6,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
958	1412	5	e353f46268989ceddefef25261bad749cdcbcfdfb301dc504c27b8cb6e89a5d5	{1,2,3,4,5,6,7,1,3,6,10,15,21,28,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
959	1413	5	03c044a416886a276cdeff88236971fe97ae04200cdf822e3606a5a8b0c35c53	{1,3,6,10,15,21,28,1,4,10,20,35,56,84,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
960	1414	5	dfb375e550d8632a6f283d2638fd45e27c5d55ff3c3da803de6d8c0cacbccf11	{1,1,1,1,1,1,1,1,4,10,20,35,56,84,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
962	1416	5	c7adc5702f00942d91df722ae53ad1d1543bb5342db95bcc6d4a9bdd1d73f910	{1,3,6,10,15,21,28,1,5,15,35,70,126,210,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
964	1418	5	b8d212343b912ed0b85820effa1f643500b6e6d5830cc1bb1d3b5c2ea50337b3	{1,1,1,1,1,1,1,3,5,7,9,11,13,15,6,15,28,45,66,91,120,10,35,84,165,286,455,680,15,70,210,495,1001,1820,3060,21,126,462,1287,3003,6188,11628,28,210,924,3003,8008,18564,38760}
967	1421	5	e19c2cc34f4c9e67a0fac1f4c7dfc0d3dd181a11d48baf399e55d3d6e9a21801	{1,2,3,4,5,6,7,2,6,12,20,30,42,56,1,4,10,20,35,56,84,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
968	1422	5	83bb7d22a5453b885adf4daede40d36cbd49742a7904f7005dd79de74eff6891	{1,3,6,10,15,21,28,2,8,20,40,70,112,168,1,5,15,35,70,126,210,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
969	1423	5	d930874abb39e5158ad4bf40a9bb11cb71a084972cdfd0ec80784519ce660833	{1,1,1,1,1,1,1,2,6,12,20,30,42,56,1,5,15,35,70,126,210,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
971	1425	5	b5c0ee78dfd267c18546d4928496d798d0aff69eecb4182cdac2dd5063174432	{1,1,1,1,1,1,1,2,8,20,40,70,112,168,1,7,28,84,210,462,924,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
972	1426	5	76fb9a48f85301876a108c9e3ac1ef457f805ae397e85b158243a584ae389cbc	{1,2,3,4,5,6,7,2,10,30,70,140,252,420,1,8,36,120,330,792,1716,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
973	1428	5	f9d630aaa8901a32ecaf77e3da9c3996558c8f20452e1dd6f8e87144312cbb58	{1,3,6,10,15,21,28,3,12,30,60,105,168,252,3,15,45,105,210,378,630,1,6,21,56,126,252,462,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
975	1430	5	0f699103441223016ed83ba142e36fa4215bbe7b3502a6ab6bbd252e06088f39	{1,3,6,10,15,21,28,3,15,45,105,210,378,630,3,21,84,252,630,1386,2772,1,9,45,165,495,1287,3003,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
976	1431	5	06bf85bccca2ec59e9719ca539fad188e40d48d0f32b4a4eeb108a5c508cfc5e	{1,1,1,1,1,1,1,3,12,30,60,105,168,252,3,21,84,252,630,1386,2772,1,10,55,220,715,2002,5005,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
977	1432	5	d14436e2d1c72fb45dd7c6079f52a2ed01a0341b0f866f1445b25837424e4a52	{1,2,3,4,5,6,7,3,15,45,105,210,378,630,3,24,108,360,990,2376,5148,1,11,66,286,1001,3003,8008,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
978	1433	5	1443b2b00b89867a4e65e671174b8cccaeba37dc977fe0a6098af6d2dee19c0b	{1,2,1,0,0,0,0,1,5,10,10,5,1,0,1,8,28,56,70,56,28,1,11,55,165,330,462,462,1,14,91,364,1001,2002,3003,1,17,136,680,2380,6188,12376,1,20,190,1140,4845,15504,38760}
979	1434	5	b068f149262ea6f987ca3714b216b713d3b83018f4ef68354f7a3fde7f81e94f	{1,3,3,1,0,0,0,1,6,15,20,15,6,1,1,9,36,84,126,126,84,1,12,66,220,495,792,924,1,15,105,455,1365,3003,5005,1,18,153,816,3060,8568,18564,1,21,210,1330,5985,20349,54264}
981	1436	5	d1a46b36ed0d4611611663c41c72993a788a7a49a155b9d8a54de2c8dbb9661d	{1,3,3,1,0,0,0,2,8,12,8,2,0,0,3,15,30,30,15,3,0,4,24,60,80,60,24,4,5,35,105,175,175,105,35,6,48,168,336,420,336,168,7,63,252,588,882,882,588}
983	1438	5	43ff16e9e2f0fa56e856c8766547458fe170ee8497bb63dd10a9619186194b97	{1,1,0,0,0,0,0,2,8,12,8,2,0,0,3,21,63,105,105,63,21,4,40,180,480,840,1008,840,5,65,390,1430,3575,6435,8580,6,96,720,3360,10920,26208,48048,7,133,1197,6783,27132,81396,189924}
984	1439	5	b9d63b8cdc96d1ead06e1a8825bd83ca7de59f529751e921f6feef0f5169e0b4	{1,2,1,0,0,0,0,2,10,20,20,10,2,0,3,24,84,168,210,168,84,4,44,220,660,1320,1848,1848,5,70,455,1820,5005,10010,15015,6,102,816,4080,14280,37128,74256,7,140,1330,7980,33915,108528,271320}
986	1441	5	3fb1ff3333a9e5e4e07bad54afc9e373b0e100a5dc140a57e180d99ad89c9ec1	{1,2,1,0,0,0,0,3,9,9,3,0,0,0,6,24,36,24,6,0,0,10,50,100,100,50,10,0,15,90,225,300,225,90,15,21,147,441,735,735,441,147,28,224,784,1568,1960,1568,784}
987	1442	5	a89e3fb5b8cbf7b5578b55ca2645205fc5fc783c1d7f45b5041498f2f5a7fa4c	{1,3,3,1,0,0,0,3,12,18,12,3,0,0,6,30,60,60,30,6,0,10,60,150,200,150,60,10,15,105,315,525,525,315,105,21,168,588,1176,1470,1176,588,28,252,1008,2352,3528,3528,2352}
988	1443	5	1c28fd34611020cd04d0fc3126878c40f7c6c8ee1ae36c4fc33e0b6e8c4f3ac1	{1,1,0,0,0,0,0,3,9,9,3,0,0,0,6,30,60,60,30,6,0,10,70,210,350,350,210,70,15,135,540,1260,1890,1890,1260,21,231,1155,3465,6930,9702,9702,28,364,2184,8008,20020,36036,48048}
990	1445	5	bd6f7ddd7e6acbcd01e528e20910f2f6ea9a3db160991b5bb7f20eb76a3adc23	{1,1,0,0,0,0,0,3,12,18,12,3,0,0,6,42,126,210,210,126,42,10,100,450,1200,2100,2520,2100,15,195,1170,4290,10725,19305,25740,21,336,2520,11760,38220,91728,168168,28,532,4788,27132,108528,325584,759696}
991	1446	5	5fa97721ec28e3497b626b7b05da9cf62f447abeeab642877329b6fe7beba8f6	{1,2,1,0,0,0,0,3,15,30,30,15,3,0,6,48,168,336,420,336,168,10,110,550,1650,3300,4620,4620,15,210,1365,5460,15015,30030,45045,21,357,2856,14280,49980,129948,259896,28,560,5320,31920,135660,434112,1085280}
992	1447	5	8688118c78d101adda1a97a4df0c4f18558ff93a8306ac18bd5a140e7369bc05	{1,2,3,4,5,6,7,1,5,15,35,70,126,210,1,8,36,120,330,792,1716,1,11,66,286,1001,3003,8008,1,14,105,560,2380,8568,27132,1,17,153,969,4845,20349,74613,1,20,210,1540,8855,42504,177100}
993	1448	5	c9c63669f1ea603645ba28e6b03df9f3fd59e1bc0e2b5bf614b59f9c7f98e604	{1,1,1,1,1,1,1,2,6,12,20,30,42,56,3,15,45,105,210,378,630,4,28,112,336,840,1848,3696,5,45,225,825,2475,6435,15015,6,66,396,1716,6006,18018,48048,7,91,637,3185,12740,43316,129948}
995	1450	5	5a2d165085773e2400b0ed20a100707079404024fdaa6e8cfae256132ffa7aa6	{1,3,6,10,15,21,28,2,10,30,70,140,252,420,3,21,84,252,630,1386,2772,4,36,180,660,1980,5148,12012,5,55,330,1430,5005,15015,40040,6,78,546,2730,10920,37128,111384,7,105,840,4760,21420,81396,271320}
996	1451	5	6df2cb5f067d5dd87b0d149f47979a326f075e38f095ddd0e197dcb1be89cf34	{1,2,3,4,5,6,7,2,10,30,70,140,252,420,3,24,108,360,990,2376,5148,4,44,264,1144,4004,12012,32032,5,70,525,2800,11900,42840,135660,6,102,918,5814,29070,122094,447678,7,140,1470,10780,61985,297528,1239700}
997	1452	5	de8e4803e972d6694e3334d3a305e4fb6a664d696c49471303fd6f268dedaae6	{1,3,6,10,15,21,28,1,5,15,35,70,126,210,2,14,56,168,420,924,1848,5,45,225,825,2475,6435,15015,14,154,924,4004,14014,42042,112112,42,546,3822,19110,76440,259896,779688,132,1980,15840,89760,403920,1534896,5116320}
998	1453	5	e7a078d44651acdce7805caa8d5b36b7b6ce8623beaea929a83e6773c1e49d38	{1,2,3,4,5,6,7,1,5,15,35,70,126,210,2,16,72,240,660,1584,3432,5,55,330,1430,5005,15015,40040,14,196,1470,7840,33320,119952,379848,42,714,6426,40698,203490,854658,3133746,132,2640,27720,203280,1168860,5610528,23377200}
1002	1457	5	4bb464d453096c35b877250a6111c86108d3ee66c282c5c8a06c924b7ecd7377	{1,3,6,10,15,21,28,2,10,30,70,140,252,420,5,35,140,420,1050,2310,4620,14,126,630,2310,6930,18018,42042,42,462,2772,12012,42042,126126,336336,132,1716,12012,60060,240240,816816,2450448,429,6435,51480,291720,1312740,4988412,16628040}
1003	1458	5	e42e8be2394260e2f6821554352d5d091ef0050d83c08529c2b901068b5e8aea	{1,1,1,1,1,1,1,2,8,20,40,70,112,168,5,35,140,420,1050,2310,4620,14,140,770,3080,10010,28028,70070,42,546,3822,19110,76440,259896,779688,132,2112,17952,107712,511632,2046528,7162848,429,8151,81510,570570,3138135,14435421,57741684}
1005	1460	5	0b5fad0e3dce724675facce8a36049f758029f9edde162e4cc6d03f3954f6442	{1,3,6,10,15,21,28,2,12,42,112,252,504,924,5,45,225,825,2475,6435,15015,14,168,1092,5096,19110,61152,173264,42,630,5040,28560,128520,488376,1627920,132,2376,22572,150480,790020,3476088,13325004,429,9009,99099,759759,4558554,22792770,98768670}
1006	1461	5	16855860953d302495ec5470488208312a59389e7d5b7759d463056df9d7a031	{1,3,3,1,0,0,0,2,10,20,20,10,2,0,5,35,105,175,175,105,35,14,126,504,1176,1764,1764,1176,42,462,2310,6930,13860,19404,19404,132,1716,10296,37752,94380,169884,226512,429,6435,45045,195195,585585,1288287,2147145}
1007	1462	5	90470290fd4c4ad815efb386b3bc19457d71140c9a63fabfa9fb58dd3df71912	{1,1,0,0,0,0,0,2,8,12,8,2,0,0,5,35,105,175,175,105,35,14,140,630,1680,2940,3528,2940,42,546,3276,12012,30030,54054,72072,132,2112,15840,73920,240240,576576,1057056,429,8151,73359,415701,1662804,4988412,11639628}
1008	1463	5	e3b39f5cb6cbc9e51e944c794ee15241247d26555c9b54dd6cdad4bd51711b60	{1,2,1,0,0,0,0,2,10,20,20,10,2,0,5,40,140,280,350,280,140,14,154,770,2310,4620,6468,6468,42,588,3822,15288,42042,84084,126126,132,2244,17952,89760,314160,816816,1633632,429,8580,81510,489060,2078505,6651216,16628040}
1010	1057	6	ad36060f9ac6415392619a6d7c78176bdd61aa7aca362a376cde07746da0ecb7	{1,6,27,110,429,1638,6188,1,6,27,110,429,1638,6188,2,12,54,220,858,3276,12376,5,30,135,550,2145,8190,30940,14,84,378,1540,6006,22932,86632,42,252,1134,4620,18018,68796,259896,132,792,3564,14520,56628,216216,816816}
1011	1058	6	e85065d558d8b4ba0f811bfdfdbe1d6a3a62a2d79d6a58c510cb7fe2cfbf15d3	{1,3,3,1,0,0,0,2,6,6,2,0,0,0,5,15,15,5,0,0,0,14,42,42,14,0,0,0,42,126,126,42,0,0,0,132,396,396,132,0,0,0,429,1287,1287,429,0,0,0}
1012	1059	6	51551155be835ffc325c3e469b0090fd32690f260ffe7185bbe9a10ec82a3ff6	{1,3,9,28,90,297,1001,2,6,18,56,180,594,2002,5,15,45,140,450,1485,5005,14,42,126,392,1260,4158,14014,42,126,378,1176,3780,12474,42042,132,396,1188,3696,11880,39204,132132,429,1287,3861,12012,38610,127413,429429}
1014	1061	6	f1c2dcc7e2eab512aeb309d85dd7a37a585bd2f5745cebe39fc5a1d5886aae41	{1,6,27,110,429,1638,6188,2,12,54,220,858,3276,12376,5,30,135,550,2145,8190,30940,14,84,378,1540,6006,22932,86632,42,252,1134,4620,18018,68796,259896,132,792,3564,14520,56628,216216,816816,429,2574,11583,47190,184041,702702,2654652}
1015	1062	6	21f090319e9ee616031e68e40942d143ee0d79d860c600204523fabfd01adb21	{1,1,0,0,0,0,0,3,3,0,0,0,0,0,9,9,0,0,0,0,0,28,28,0,0,0,0,0,90,90,0,0,0,0,0,297,297,0,0,0,0,0,1001,1001,0,0,0,0,0}
1016	1063	6	e3a1b9ec784823a48a104ede4f3b6be86e763f85a8560b65752c9163920ff4d9	{1,2,1,0,0,0,0,3,6,3,0,0,0,0,9,18,9,0,0,0,0,28,56,28,0,0,0,0,90,180,90,0,0,0,0,297,594,297,0,0,0,0,1001,2002,1001,0,0,0,0}
1019	1066	6	2e02a6a8667aec2704df1a02f8cecb3d012c842c59ff7a383d0a2810064c11c5	{1,2,3,4,5,6,7,3,6,9,12,15,18,21,9,18,27,36,45,54,63,28,56,84,112,140,168,196,90,180,270,360,450,540,630,297,594,891,1188,1485,1782,2079,1001,2002,3003,4004,5005,6006,7007}
1020	1067	6	77a9fb22648e366a036bc28065e65653528c46771b6c754ae56a8a532bafd153	{1,3,6,10,15,21,28,3,9,18,30,45,63,84,9,27,54,90,135,189,252,28,84,168,280,420,588,784,90,270,540,900,1350,1890,2520,297,891,1782,2970,4455,6237,8316,1001,3003,6006,10010,15015,21021,28028}
1021	1068	6	c2ad88c463b360d041a09fad83decb4763c6f986afee2b5520461e36463271fd	{1,1,2,5,14,42,132,3,3,6,15,42,126,396,9,9,18,45,126,378,1188,28,28,56,140,392,1176,3696,90,90,180,450,1260,3780,11880,297,297,594,1485,4158,12474,39204,1001,1001,2002,5005,14014,42042,132132}
1022	1069	6	21808b2abfc9dbe4d294a233d471db3143f93cf3f462ea0dd83fb662613d2df4	{1,2,5,14,42,132,429,3,6,15,42,126,396,1287,9,18,45,126,378,1188,3861,28,56,140,392,1176,3696,12012,90,180,450,1260,3780,11880,38610,297,594,1485,4158,12474,39204,127413,1001,2002,5005,14014,42042,132132,429429}
1024	1073	6	8ed3d633d1a0b7b311933e79d9c4bb0b41f281356e66810a921fad0c4c1160dd	{1,6,27,110,429,1638,6188,3,18,81,330,1287,4914,18564,9,54,243,990,3861,14742,55692,28,168,756,3080,12012,45864,173264,90,540,2430,9900,38610,147420,556920,297,1782,8019,32670,127413,486486,1837836,1001,6006,27027,110110,429429,1639638,6194188}
1025	1078	6	e07f7453fbf9a31c4fe4f893058e1c12e7bd8fad61944ecc62cacdddaa049040	{1,1,0,0,0,0,0,4,4,0,0,0,0,0,14,14,0,0,0,0,0,48,48,0,0,0,0,0,165,165,0,0,0,0,0,572,572,0,0,0,0,0,2002,2002,0,0,0,0,0}
1026	1079	6	74034fcce7b9dd5df2a277a54f070846f45d6126b1f55ce4d601e9640e075233	{1,2,1,0,0,0,0,4,8,4,0,0,0,0,14,28,14,0,0,0,0,48,96,48,0,0,0,0,165,330,165,0,0,0,0,572,1144,572,0,0,0,0,2002,4004,2002,0,0,0,0}
1028	1081	6	bff55e4b3c19f2a8fec76c25c1ab94a07466a34345b08d6c0945ac3aeddc6b0d	{1,1,1,1,1,1,1,4,4,4,4,4,4,4,14,14,14,14,14,14,14,48,48,48,48,48,48,48,165,165,165,165,165,165,165,572,572,572,572,572,572,572,2002,2002,2002,2002,2002,2002,2002}
1029	1082	6	7e4d27e93a42429a8cb6ebf38326e2dd95b22f901c241b16adf5e282190b9429	{1,2,3,4,5,6,7,4,8,12,16,20,24,28,14,28,42,56,70,84,98,48,96,144,192,240,288,336,165,330,495,660,825,990,1155,572,1144,1716,2288,2860,3432,4004,2002,4004,6006,8008,10010,12012,14014}
1030	1083	6	d83cac1f5b67cc41dcf0ba3e6d7bc373cdc53cc05e6aa17c79e44e2be7c8dff5	{1,3,6,10,15,21,28,4,12,24,40,60,84,112,14,42,84,140,210,294,392,48,144,288,480,720,1008,1344,165,495,990,1650,2475,3465,4620,572,1716,3432,5720,8580,12012,16016,2002,6006,12012,20020,30030,42042,56056}
1031	1084	6	d402b94076ffaab662826e972b8ceae4cccf69c7d0ef7c3bfd606082595ed9dc	{1,1,2,5,14,42,132,4,4,8,20,56,168,528,14,14,28,70,196,588,1848,48,48,96,240,672,2016,6336,165,165,330,825,2310,6930,21780,572,572,1144,2860,8008,24024,75504,2002,2002,4004,10010,28028,84084,264264}
1033	1086	6	b334103c9af04ddb4e54d1d774e4daea1d82b9d2cabbfba4cc7d6f8e1ff1a829	{1,3,9,28,90,297,1001,4,12,36,112,360,1188,4004,14,42,126,392,1260,4158,14014,48,144,432,1344,4320,14256,48048,165,495,1485,4620,14850,49005,165165,572,1716,5148,16016,51480,169884,572572,2002,6006,18018,56056,180180,594594,2004002}
1034	1088	6	323a454dab851f91c8138cb149a0884794fa8a61547a4add9b0f18b24c7025df	{1,4,14,48,165,572,2002,4,16,56,192,660,2288,8008,14,56,196,672,2310,8008,28028,48,192,672,2304,7920,27456,96096,165,660,2310,7920,27225,94380,330330,572,2288,8008,27456,94380,327184,1145144,2002,8008,28028,96096,330330,1145144,4008004}
1036	1090	6	a11095a5d13b43382479b9609a71dd4ebdc90a34008d49257c3e3d52a5cc2733	{1,1,0,0,0,0,0,6,6,0,0,0,0,0,27,27,0,0,0,0,0,110,110,0,0,0,0,0,429,429,0,0,0,0,0,1638,1638,0,0,0,0,0,6188,6188,0,0,0,0,0}
1038	1092	6	e2732365babf8cebfd25a90970c785597e7814d9c396b9299798e6012c5ae98d	{1,3,3,1,0,0,0,6,18,18,6,0,0,0,27,81,81,27,0,0,0,110,330,330,110,0,0,0,429,1287,1287,429,0,0,0,1638,4914,4914,1638,0,0,0,6188,18564,18564,6188,0,0,0}
1039	1093	6	530b3c340fad30ba3fd9604c62ae758da575c326374844b897dfa03bb680b33c	{1,1,1,1,1,1,1,6,6,6,6,6,6,6,27,27,27,27,27,27,27,110,110,110,110,110,110,110,429,429,429,429,429,429,429,1638,1638,1638,1638,1638,1638,1638,6188,6188,6188,6188,6188,6188,6188}
1040	1094	6	dfb2750e86530db8761b18df2e83b204806cc1a349c7072eeb6ff8c365cf13b8	{1,2,3,4,5,6,7,6,12,18,24,30,36,42,27,54,81,108,135,162,189,110,220,330,440,550,660,770,429,858,1287,1716,2145,2574,3003,1638,3276,4914,6552,8190,9828,11466,6188,12376,18564,24752,30940,37128,43316}
1041	1095	6	973df3c0b3624311d0f39b4bc4d5ec4d8f8f001b458c2d8b7cb88aae119e0a81	{1,3,6,10,15,21,28,6,18,36,60,90,126,168,27,81,162,270,405,567,756,110,330,660,1100,1650,2310,3080,429,1287,2574,4290,6435,9009,12012,1638,4914,9828,16380,24570,34398,45864,6188,18564,37128,61880,92820,129948,173264}
1042	1096	6	68a4491bb2767b1b34198ce51312910d946f1d1c132bd8037d46cda5f3112069	{1,1,2,5,14,42,132,6,6,12,30,84,252,792,27,27,54,135,378,1134,3564,110,110,220,550,1540,4620,14520,429,429,858,2145,6006,18018,56628,1638,1638,3276,8190,22932,68796,216216,6188,6188,12376,30940,86632,259896,816816}
1043	1097	6	7d3ae9f0eecf25a8768a0882bed53dabc332c48c826b28c8cbb9028b226ae817	{1,2,5,14,42,132,429,6,12,30,84,252,792,2574,27,54,135,378,1134,3564,11583,110,220,550,1540,4620,14520,47190,429,858,2145,6006,18018,56628,184041,1638,3276,8190,22932,68796,216216,702702,6188,12376,30940,86632,259896,816816,2654652}
1044	1098	6	68c0d43d1c2f275370f6d5fe80dac467519d23f5784efa1f90bb33ab9a53241d	{1,3,9,28,90,297,1001,6,18,54,168,540,1782,6006,27,81,243,756,2430,8019,27027,110,330,990,3080,9900,32670,110110,429,1287,3861,12012,38610,127413,429429,1638,4914,14742,45864,147420,486486,1639638,6188,18564,55692,173264,556920,1837836,6194188}
1046	1101	6	dcb54d0451ab061061909d702d95347b643304dac620202aba9b1ffceba3b672	{1,6,27,110,429,1638,6188,6,36,162,660,2574,9828,37128,27,162,729,2970,11583,44226,167076,110,660,2970,12100,47190,180180,680680,429,2574,11583,47190,184041,702702,2654652,1638,9828,44226,180180,702702,2683044,10135944,6188,37128,167076,680680,2654652,10135944,38291344}
1047	1102	6	1c3e8200d1e59a4188ec0783a64698acfff1f15525c27b860fe261325aef1916	{1,0,0,0,0,0,0,1,3,6,10,15,21,28,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
1048	1103	6	6c1e10a42c438aad38c50f3c8804f8ad714af990e44ce9d1ff079fed62f0a2cf	{1,0,0,0,0,0,0,1,3,9,28,90,297,1001,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
1049	1104	6	ef49ac2a27320afeb56b112bf88085eabcd169de59e38099374c3e99b0913b13	{1,0,0,0,0,0,0,1,4,14,48,165,572,2002,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
1051	1106	6	db6e3ad37fa19907f1b940b739f369a62ba9848c1468bc01137f80f561ae0f34	{1,0,0,0,0,0,0,2,2,0,0,0,0,0,1,2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
1053	1108	6	ac36b49d79b9ef92d8ee810b74ab2462fc34d2a4ecb44e237cedf2aa6cc38a04	{1,0,0,0,0,0,0,2,6,6,2,0,0,0,1,6,15,20,15,6,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
1056	1111	6	5e88fec8689130f1f9d467919c639741a59f578b5921137cd520dc683df3a8ba	{1,0,0,0,0,0,0,2,6,12,20,30,42,56,1,6,21,56,126,252,462,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
1057	1112	6	992053f0f9def261120566c69ee75402852735b9f323216866c04b9b30efeb04	{1,0,0,0,0,0,0,2,2,4,10,28,84,264,1,2,5,14,42,132,429,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
1058	1113	6	8e7e024beef4cb4e6caae14487a0b1ac217f91ca7c894c0aeb4257f866ebf417	{1,0,0,0,0,0,0,2,4,10,28,84,264,858,1,4,14,48,165,572,2002,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
1060	1116	6	ca82107b29431ac9d5f028b613e98a04c58f08cc6e04e4458bb8a1f403ea4633	{1,0,0,0,0,0,0,2,8,28,96,330,1144,4004,1,8,44,208,910,3808,15504,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
1061	1117	6	0bd7ab1a1f703c7f43a40800bf7059fd31c16253651cb04eb6a3f27bd388576c	{1,0,0,0,0,0,0,2,12,54,220,858,3276,12376,1,12,90,544,2907,14364,67298,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
1062	1118	6	c9acf7e5b228946c967e696473b1b1589d51ba3ba2bcaa86530684da004675be	{1,0,0,0,0,0,0,3,3,0,0,0,0,0,3,6,3,0,0,0,0,1,3,3,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
1064	1120	6	675a3cbe38fe8f9e5fdd48258673ded894a9b57f2ce58bc252152f9d88459501	{1,0,0,0,0,0,0,3,9,9,3,0,0,0,3,18,45,60,45,18,3,1,9,36,84,126,126,84,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
1065	1121	6	cdc39b6d97167395cf2d8b1608cdd6b1ed92e6bc4466e5fc4c75e773a8f8b79e	{1,0,0,0,0,0,0,3,3,3,3,3,3,3,3,6,9,12,15,18,21,1,3,6,10,15,21,28,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
1066	1122	6	237d2c84dc924d42bf206214fe3848f3a715e8ad613e8c61a11afac64d5b171b	{1,0,0,0,0,0,0,3,6,9,12,15,18,21,3,12,30,60,105,168,252,1,6,21,56,126,252,462,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
1067	1123	6	fd493258d61f6b51840c6d377519cb70dd73c8977073503d65c4560fad75a6d5	{1,0,0,0,0,0,0,3,9,18,30,45,63,84,3,18,63,168,378,756,1386,1,9,45,165,495,1287,3003,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
1069	1125	6	488f737ef547e25195ccae8e0fc4f6de2613a73868ec5ab35e3d446bea9f8746	{1,0,0,0,0,0,0,3,6,15,42,126,396,1287,3,12,42,144,495,1716,6006,1,6,27,110,429,1638,6188,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
1070	1014	6	ac2df10ffd776414d063ed6f5ddff23df0a3ffe3e09e24a1169894ce0c867e5b	{1,1,0,0,0,0,0,None,None,None,None,None,None,None,-2,-14,-42,-70,-70,-42,-14,4,40,180,480,840,1008,840,-10,-130,-780,-2860,-7150,-12870,-17160,28,448,3360,15680,50960,122304,224224,-84,-1596,-14364,-81396,-325584,-976752,-2279088}
1073	1037	6	f3f5f90bcb5f864a32533dd812262a5e1cabe5f933f6ac55f8736266b769837f	{1,3,3,1,0,0,0,None,None,None,None,None,None,None,-2,-18,-72,-168,-252,-252,-168,4,48,264,880,1980,3168,3696,-10,-150,-1050,-4550,-13650,-30030,-50050,28,504,4284,22848,85680,239904,519792,-84,-1764,-17640,-111720,-502740,-1709316,-4558176}
1075	1074	6	801b7f6d33ed75a4e4b18da56be525f245e26ac5dd0545108bec38450f26d583	{1,0,0,0,0,0,0,None,None,None,None,None,None,None,-2,-8,-12,-8,-2,0,0,4,24,60,80,60,24,4,-10,-80,-280,-560,-700,-560,-280,28,280,1260,3360,5880,7056,5880,-84,-1008,-5544,-18480,-41580,-66528,-77616}
1076	1075	6	46206e6e4d07b8a6ac8de4feb1115c150a348dd341c07792f2762ee2de62c8de	{1,0,0,0,0,0,0,None,None,None,None,None,None,None,-2,-12,-30,-40,-30,-12,-2,4,36,144,336,504,504,336,-10,-120,-660,-2200,-4950,-7920,-9240,28,420,2940,12740,38220,84084,140140,-84,-1512,-12852,-68544,-257040,-719712,-1559376}
1077	1071	6	051a475ae3003ae4570d1363e3b33dfa3b712d3f88071ad1302b0914e6731e6d	{1,3,3,1,0,0,0,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None}
1079	1077	6	31d9a05354c916ac2dbc986e768e935cfc63f83841550a26f22d45290e0e9af5	{1,2,1,0,0,0,0,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None}
1083	130	6	40994200817600c61472395cdfb32a8bf0368f2c7eb5918cb07efe45073b08e2	{1,2,3,4,5,6,7,2,10,28,60,110,182,280,3,28,126,396,1001,2184,4284,4,60,396,1716,5720,15912,38760,5,110,1001,5720,24310,83980,248710,6,182,2184,15912,83980,352716,1248072,7,280,4284,38760,248710,1248072,5200300}
1084	180	6	7468df8a06ce15e6cd8caf7a799727bbb6e867c8a209909721c8c7dcb03e9d09	{-1,-1,-1,-1,-1,-1,-1,2,3,4,5,6,7,8,-3,-6,-10,-15,-21,-28,-36,4,10,20,35,56,84,120,-5,-15,-35,-70,-126,-210,-330,6,21,56,126,252,462,792,-7,-28,-84,-210,-462,-924,-1716}
1089	735	2	e0dcfd819618253d75615b13628674928f9d94c5d048f7180fc84941dac4e0fe	{1,2,1,0,0,0,0,-2,-4,-2,0,0,0,0,-4,-8,-4,0,0,0,0,-8,-17,-8,0,0,0,0,-40,-81,-40,0,0,0,0,-196,-392,-196,0,0,0,0,-1002,-2005,-1002,0,0,0,0}
1090	243	6	a54e231de413c2d6686b12aa82fa95771a554b052736a75fcdf676c479493aa9	{0,0,1,0,0,0,0,0,0,1,0,0,0,0,1,0,1,0,0,0,0,1,0,1,0,0,0,0,1,0,1,0,0,0,0,1,0,1,0,0,0,0,1,0,1,0,0,0,0}
1091	480	3	f3014366966682cb0acdc51a98c13ed647c9195351510329c812fdd9c4906140	{1,2,1,0,0,0,0,2,4,2,0,0,0,0,5,10,5,0,0,0,0,14,28,14,0,0,0,0,42,84,42,0,0,0,0,132,264,132,0,0,0,0,429,858,429,0,0,0,0}
1092	485	3	22b3748b2eae034c53e1c2bcb9f563fa0e01d4b829b2e91b831a34445fc41bc9	{3,2,6,24,110,546,2856,4,4,12,48,220,1092,5712,10,10,30,120,550,2730,14280,28,28,84,336,1540,7644,39984,84,84,252,1008,4620,22932,119952,264,264,792,3168,14520,72072,376992,858,858,2574,10296,47190,234234,1225224}
1094	487	3	94383d967360b2d625f8be3e0e1a7f12ee680a7fef9764863d13652fdfc6a6f2	{1,1,3,12,55,273,1428,2,2,6,24,110,546,2856,1,1,3,12,55,273,1428,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
1096	1465	5	e3de5c73ac6470d8f1b0bca5a480628d5e1c49285395d533c17cfce214765420	{1,3,3,1,0,0,0,1,5,10,10,5,1,0,3,21,63,105,105,63,21,12,108,432,1008,1512,1512,1008,55,605,3025,9075,18150,25410,25410,273,3549,21294,78078,195195,351351,468468,1428,21420,149940,649740,1949220,4288284,7147140}
1102	544	3	0f43de2b1e1f06712dc6b85b42581dad47a6a42d634a4ec379948420ca19934e	{1,1,3,12,55,273,1428,1,1,3,12,55,273,1428,3,3,9,36,165,819,4284,12,12,36,144,660,3276,17136,55,55,165,660,3025,15015,78540,273,273,819,3276,15015,74529,389844,1428,1428,4284,17136,78540,389844,2039184}
1105	588	3	a0da85660bd054dc26a37ef46c689da630ce12fb7016101aa2439a70f2c703e8	{1,1,3,12,55,273,1428,1,4,18,88,455,2448,13566,1,7,42,245,1428,8379,49588,1,10,75,510,3325,21252,134550,1,13,117,910,6578,45630,308763,1,16,168,1472,11700,87696,632896,1,19,228,2223,19285,155496,1193808}
1081	127	6	22c13b69b8f1f0ef96348952c88503205b64e76b82884d34a8742645bbba0b94	{1,1,0,0,0,0,0,0,2,2,0,0,0,0,0,0,2,0,-2,0,0,0,0,0,0,-4,0,4,0,0,0,0,-2,0,12,0,0,0,0,0,0,12,0,0,0,0,0,0,4}
1082	128	6	fb361e8a3e651b71e9315c61c674c211f85ab6af94489578f29f3e04e72dc6a3	{1,0,0,0,0,0,0,6,1,0,0,0,0,0,30,6,1,0,0,0,0,140,30,6,1,0,0,0,630,140,30,6,1,0,0,2772,630,140,30,6,1,0,12012,2772,630,140,30,6,1}
1085	728	2	f2a1f5284df526dd59ea97f9f8d5a2b6150ba3118e703f6b9de5d7a4e638f45d	{1,1,0,0,0,0,0,-2,-2,0,0,0,0,0,-1,-1,1,1,1,1,1,-10,-10,10,10,10,10,10,-63,-63,63,63,63,63,63,-396,-396,396,396,396,396,396,-2502,-2502,2502,2502,2502,2502,2502}
1097	516	3	2258561a8ff488a61657c00d13aa66ae45b11df56f8608e2518c12e60c0378d7	{1,2,1,0,0,0,0,1,2,1,0,0,0,0,3,6,3,0,0,0,0,12,24,12,0,0,0,0,55,110,55,0,0,0,0,273,546,273,0,0,0,0,1428,2856,1428,0,0,0,0}
1095	1464	5	4c8dfec5e1bf3c6a068215a731a4a557a3b9abbda647d7ef19f8ff06c7fd3e1e	{1,2,1,0,0,0,0,1,4,6,4,1,0,0,3,18,45,60,45,18,3,12,96,336,672,840,672,336,55,550,2475,6600,11550,13860,11550,273,3276,18018,60060,135135,216216,252252,1428,19992,129948,519792,1429428,2858856,4288284}
1098	1466	5	c89adaebcbaaac2b705d7d0702e9c2d97444d54512c182d93d88ed49ba0a9b77	{1,0,0,0,0,0,0,1,3,3,1,0,0,0,3,18,45,60,45,18,3,12,108,432,1008,1512,1512,1008,55,660,3630,12100,27225,43560,50820,273,4095,28665,124215,372645,819819,1366365,1428,25704,218484,1165248,4369680,12235104,26509392}
1101	1467	5	70a1d306a8d76fe1c71293bc8ed237951fbb262bbe7d7142e7f461dca2af14a8	{1,1,0,0,0,0,0,1,4,6,4,1,0,0,3,21,63,105,105,63,21,12,120,540,1440,2520,3024,2520,55,715,4290,15730,39325,70785,94380,273,4368,32760,152880,496860,1192464,2186184,1428,27132,244188,1383732,5534928,16604784,38744496}
1103	1468	5	779b29d5d643869016158af15fa6566189cb6e46b741ed17e6629f63aaed0b71	{1,2,1,0,0,0,0,1,5,10,10,5,1,0,3,24,84,168,210,168,84,12,132,660,1980,3960,5544,5544,55,770,5005,20020,55055,110110,165165,273,4641,37128,185640,649740,1689324,3378648,1428,28560,271320,1627920,6918660,22139712,55349280}
1107	589	3	654ed56509e738594aea67de7e27f103bc673122230ceecb6795deebfb54d237	{1,1,3,12,55,273,1428,1,5,25,130,700,3876,21945,2,18,126,816,5130,31878,197340,5,65,585,4550,32890,228150,1543815,14,238,2618,23800,194922,1497734,11037488,42,882,11466,119364,1093680,9236304,73785474,132,3300,49500,580800,5890500,54285660,467867400}
1114	638	3	2fdbb3d3f9fbbf36b8cac9cb3eb8f4806440c52a57e745eda7fca781cf019367	{1,1,3,12,55,273,1428,2,2,6,24,110,546,2856,6,6,18,72,330,1638,8568,20,20,60,240,1100,5460,28560,70,70,210,840,3850,19110,99960,252,252,756,3024,13860,68796,359856,924,924,2772,11088,50820,252252,1319472}
1116	654	3	d6339e31406c9b2dfd4cee6564a6c7a988f9b4ddb628acda8baafbe5f63b6232	{1,1,3,12,55,273,1428,1,3,12,55,273,1428,7752,1,5,25,130,700,3876,21945,1,7,42,245,1428,8379,49588,1,9,63,408,2565,15939,98670,1,11,88,627,4235,27830,180180,1,13,117,910,6578,45630,308763}
1117	655	3	f7210ed418c098d78c2fea88769f8744869c90873a41cc198653bd96ac778290	{1,1,3,12,55,273,1428,1,4,18,88,455,2448,13566,2,14,84,490,2856,16758,99176,5,50,375,2550,16625,106260,672750,14,182,1638,12740,92092,638820,4322682,42,672,7056,61824,491400,3683232,26581632,132,2508,30096,293436,2545620,20525472,157582656}
1119	689	3	5043db6887dd1b652b30cf84f5430d44e9193c6c82fb4c1201f2a608f78a3ca6	{None,0,0,0,0,0,0,1,1,3,12,55,273,1428,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
1120	698	3	067a3aeabe7ffb8160f547ced754007c0b309a96995f6fa6da97fd5b403916a7	{None,0,0,0,0,0,0,1,1,2,5,14,42,132,2,4,10,28,84,264,858,5,15,45,140,450,1485,5005,14,56,196,672,2310,8008,28028,42,210,840,3150,11550,42042,152880,132,792,3564,14520,56628,216216,816816}
1121	699	3	624aab88dd11c34c339a40bc3497acd5f1222c1ff987129e91e9d4754c09f548	{None,0,0,0,0,0,0,1,2,5,14,42,132,429,2,8,28,96,330,1144,4004,5,30,135,550,2145,8190,30940,14,112,616,2912,12740,53312,217056,42,420,2730,14700,71400,325584,1424430,132,1584,11880,71808,383724,1896048,8883336}
1128	871	5	ea706417af3ab0027699d1e1034dbeee9e0d369c9bddb5087b268f82c2e47a86	{1,3,6,10,15,21,28,1,-5,10,-10,5,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
1137	919	5	b8c0877f8693ee630c2ddafa516fffc7b237e96007167d1b0278240775aecd30	{2,0,4,15,56,210,792,2,3,12,60,280,1260,5544,2,0,12,90,560,3150,16632,2,1,4,60,560,4200,27720,2,1,0,15,280,3150,27720,2,1,0,0,56,1260,16632,2,1,0,0,0,210,5544}
1138	950	5	6e0093574876bcafaa17aac8cadf469ae5b93386c0fe2e41931948f5caf828d6	{0,0,1,0,0,0,0,0,2,2,0,0,0,0,1,4,1,0,0,0,0,2,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
1139	951	5	57a6aab3f8ebdf89ac3f1f0d51da8f5ce6089e31687a65a9b2a719e183608de9	{0,1,0,0,0,0,0,1,2,0,0,0,0,0,2,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
1141	964	5	47f0d8f7b2e0b63de7ffc88d43bbfdad640af65bc4b0559953510541ee509e49	{1,1,2,1,0,0,0,1,2,1,0,0,0,0,2,1,0,-1,0,0,0,1,0,-1,0,1,0,-1,0,0,0,1,0,-1,0,0,0,0,0,-1,0,2,0,0,0,-1,0,2,0}
1142	965	5	90f9307a7f7a99bb6d9796814960cfb341b2c209d1c1670fa99fecb84d1416bc	{None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None}
1143	966	5	e5d8e6c876e0654ea572745d749740cd219d3976a5e55d24ba2092934129ccc6	{1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
1145	998	5	f35177cf016191ed14f859bf4f958974cb2cb2c22c9a7e2cac7839992fd2c523	{1,-1,0,0,0,0,0,1,0,0,0,0,0,0,1,1,1,1,1,1,1,1,2,3,4,5,6,7,1,3,6,10,15,21,28,1,4,10,20,35,56,84,1,5,15,35,70,126,210}
1147	1000	5	4fabf010ecde97062f64132b64f440babd7fd9a6068cac7b0833f89030d52b86	{1,-1,-1,-2,-5,-14,-42,1,0,0,0,0,0,0,1,1,2,5,14,42,132,1,2,5,14,42,132,429,1,3,9,28,90,297,1001,1,4,14,48,165,572,2002,1,5,20,75,275,1001,3640}
1148	920	5	5185943ac6dd0024a6ffbab252812d5ab832bf379ffb50cbb409e249dec44340	{-3,-2,-1,-6,-15,-58,-212,0,-2,-4,-14,-62,-282,-1262,0,-2,-1,-14,-92,-562,-3152,0,-2,-2,-6,-62,-562,-4202,0,-2,-2,-2,-15,-282,-3152,0,-2,-2,-2,-2,-58,-1262,0,-2,-2,-2,-2,-2,-212}
1157	284	6	b47f1731918d4fbfd6d69b63dea87eed1423eed27ad726c9587bf10d1836c4ae	{1,1,0,0,0,0,0,1,1,0,0,0,0,0,3,3,0,0,0,0,0,12,12,0,0,0,0,0,55,55,0,0,0,0,0,273,273,0,0,0,0,0,1428,1428,0,0,0,0,0}
1159	286	6	77ef45fd18d83f1a39d029fd1568f1c588a2e926e34d7c0099e9d77461006747	{1,1,1,1,1,1,1,1,2,3,4,5,6,7,3,7,12,18,25,33,42,12,30,55,88,130,182,245,55,143,273,455,700,1020,1428,273,728,1428,2448,3876,5814,8379,1428,3876,7752,13566,21945,33649,49588}
1160	287	6	3f5ec9474c8e4a47d6766f5184120f794193b74ad03c46285bb3d1e2ecf5b19a	{1,1,2,5,14,42,132,1,3,10,35,126,462,1716,3,12,50,210,882,3696,15444,12,55,260,1225,5712,26334,120120,55,273,1400,7140,35910,177870,868296,273,1428,7752,41895,223146,1168860,6023160,1428,7752,43890,247940,1381380,7567560,40756716}
1161	289	6	0d964348ae43d4e6dc18d68a8361cd21b5ceeaf962c8a0ad18cc1f5bc3b31000	{1,1,3,12,55,273,1428,1,2,7,30,143,728,3876,1,3,12,55,273,1428,7752,1,4,18,88,455,2448,13566,1,5,25,130,700,3876,21945,1,6,33,182,1020,5814,33649,1,7,42,245,1428,8379,49588}
1163	293	6	e1dac973e2f36f75c3d6fd867ce69bdea963038ebfe969b33eeb29e714ad0f3c	{1,1,3,12,55,273,1428,None,0,0,0,0,0,0,0,0,0,0,0,0,0,0,None,0,0,0,0,0,0,0,0,0,0,0,0,0,0,None,0,0,0,0,0,0,0,0,0,0,0}
1164	294	6	84f48660fd27b078491183a816e88c8b0ab164aefd55953969a83f82b482c686	{1,1,1,1,1,1,1,1,1,1,1,1,1,1,3,3,3,3,3,3,3,12,12,12,12,12,12,12,55,55,55,55,55,55,55,273,273,273,273,273,273,273,1428,1428,1428,1428,1428,1428,1428}
1165	295	6	014627f9b849fe8864d967d1c83bc81e2268742893fd8908e5c3be78ed5be372	{1,1,3,12,55,273,1428,1,1,3,12,55,273,1428,1,1,3,12,55,273,1428,1,1,3,12,55,273,1428,1,1,3,12,55,273,1428,1,1,3,12,55,273,1428,1,1,3,12,55,273,1428}
1166	296	6	61bcc5cdc6dd7d2222c24d2828af4acd339daeaab6abdca63c0747226c8ea9de	{1,1,2,5,14,42,132,1,2,6,20,70,252,924,3,7,24,90,350,1386,5544,12,30,110,440,1820,7644,32340,55,143,546,2275,9800,42840,188496,273,728,2856,12240,54264,244188,1106028,1428,3876,15504,67830,307230,1413258,6545616}
1168	301	6	b2e6e315f472edb61e31ed19b31064e7b33448c5bbec53f409f5b69b1a3b9980	{1,1,3,12,55,273,1428,1,6,36,220,1365,8568,54264,3,36,330,2730,21420,162792,1211364,12,220,2730,28560,271320,2422728,20720700,55,1365,21420,271320,3028410,31081050,300450150,273,8568,162792,2422728,31081050,360540180,3887563680,1428,54264,1211364,20720700,300450150,3887563680,46262007792}
1169	302	6	df73288ab956e95346e61cee6c273c782b9175f2b2557c1a582ba30d8a31fa41	{1,2,3,4,5,6,7,1,2,3,4,5,6,7,3,6,9,12,15,18,21,12,24,36,48,60,72,84,55,110,165,220,275,330,385,273,546,819,1092,1365,1638,1911,1428,2856,4284,5712,7140,8568,9996}
1170	303	6	005d7bf9bda40bace22b2b6706d32c251d2c27a8243f4d97be6ad008fc176997	{1,1,3,12,55,273,1428,2,2,6,24,110,546,2856,3,3,9,36,165,819,4284,4,4,12,48,220,1092,5712,5,5,15,60,275,1365,7140,6,6,18,72,330,1638,8568,7,7,21,84,385,1911,9996}
1173	1254	2	993b11ff59c8348416fb6b57e9e1798d01ff662d7de1d93e9b0265021b0b0ae3	{1,2,10,63,462,3583,29172,1,2,10,63,462,3583,29172,1,2,10,63,462,3583,29172,1,2,10,63,462,3583,29172,1,2,10,63,462,3583,29172,1,2,10,63,462,3583,29172,1,2,10,63,462,3583,29172}
1174	306	6	4651ece452df7a2ce4060026f6fcb752e1579a13a8d3c67ba976ec129dabdcaf	{1,1,3,12,55,273,1428,1,0,0,0,0,0,0,1,-1,-2,-7,-30,-143,-728,1,-2,-3,-10,-42,-198,-1001,1,-3,-3,-10,-42,-198,-1001,1,-4,-2,-8,-35,-168,-858,1,-5,0,-5,-25,-126,-660}
1156	270	6	d653ddbf3db68147cb8376417d5390675737c27d3a4195fa7c2b4b6573c9eae6	{1,2,1,0,0,0,0,2,6,6,2,0,0,0,5,20,30,20,5,0,0,14,70,140,140,70,14,0,42,252,630,840,630,252,42,132,924,2772,4620,4620,2772,924,429,3432,12012,24024,30030,24024,12012}
1123	701	3	fd0137b6a2453cb0756511565b031ae566539ed30d5eb225fad25167be6d1d4e	{None,0,0,0,0,0,0,1,1,2,5,14,42,132,1,2,5,14,42,132,429,1,3,9,28,90,297,1001,1,4,14,48,165,572,2002,1,5,20,75,275,1001,3640,1,6,27,110,429,1638,6188}
1124	702	3	ab96108864ae09961930dd9cb8a2ae2d88c24252a3cb5414ed378c9a71dbec8b	{1,0,0,0,0,0,0,1,2,6,20,70,252,924,1,4,16,64,256,1024,4096,1,6,30,140,630,2772,12012,1,8,48,256,1280,6144,28672,1,10,70,420,2310,12012,60060,1,12,96,640,3840,21504,114688}
1109	606	3	7b642f00dcf6a21a5246be45ebb9a023c14b90bbd5bec1680df37f4886973dc6	{1,2,6,20,70,252,924,1,2,6,20,70,252,924,3,6,18,60,210,756,2772,12,24,72,240,840,3024,11088,55,110,330,1100,3850,13860,50820,273,546,1638,5460,19110,68796,252252,1428,2856,8568,28560,99960,359856,1319472}
1112	607	3	9d369c8454d4548fe226ae2b36980e18f9aa359ecd0085b3b95843f0a69c7507	{1,2,6,20,70,252,924,1,0,0,0,0,0,0,2,-4,-4,-8,-20,-56,-168,5,-20,0,0,0,0,0,14,-84,84,56,84,168,392,42,-336,672,0,0,0,0,132,-1320,3960,-2640,-1320,-1584,-2640}
1113	612	3	3fcbd882ec6a6a90bb9f3da7010ff14ee22b387da4fe6daf8f6986a43d3d7e07	{None,1,-2,7,-30,143,-728,None,1,-2,7,-30,143,-728,None,0,0,0,0,0,0,None,0,0,0,0,0,0,None,0,0,0,0,0,0,None,0,0,0,0,0,0,None,0,0,0,0,0,0}
1106	1470	5	15b9cecc1c452fc3baf71d9e332d298e844e95f627843fba623fa7ccaf688335	{1,3,3,1,0,0,0,1,3,3,1,0,0,0,3,9,9,3,0,0,0,12,36,36,12,0,0,0,55,165,165,55,0,0,0,273,819,819,273,0,0,0,1428,4284,4284,1428,0,0,0}
1108	1474	5	107bf4b019abe430ee68a1704c6879c4d7280a9548b72a9e91a8867c6d5bbeb2	{1,0,0,0,0,0,0,1,3,6,10,15,21,28,3,18,63,168,378,756,1386,12,108,540,1980,5940,15444,36036,55,660,4290,20020,75075,240240,680680,273,4095,32760,185640,835380,3174444,10581480,1428,25704,244188,1627920,8546580,37604952,144152316}
1110	1475	5	9e88ea0f7a972cae503cc6c18b14b6c49acd2c5132dd467b740cf8763b362187	{1,1,1,1,1,1,1,1,4,10,20,35,56,84,3,21,84,252,630,1386,2772,12,120,660,2640,8580,24024,60060,55,715,5005,25025,100100,340340,1021020,273,4368,37128,222768,1058148,4232592,14814072,1428,27132,271320,1899240,10445820,48050772,192203088}
1125	864	5	fa3675b1d7634ebf1c7b23baf507e0d00419d526ecc92450dbfd8c28ee7f24d6	{1,1,1,1,1,1,1,1,2,3,4,5,6,7,3,9,18,30,45,63,84,12,48,120,240,420,672,1008,55,275,825,1925,3850,6930,11550,273,1638,5733,15288,34398,68796,126126,1428,9996,39984,119952,299880,659736,1319472}
1126	869	5	9ed7b263abdcdf832031866dae6b0c28da54bb9f615e1e169960a60564cc94c8	{1,3,6,10,15,21,28,1,1,1,1,1,1,1,2,-2,0,0,0,0,0,5,-15,15,-5,0,0,0,14,-70,140,-140,70,-14,0,42,-294,882,-1470,1470,-882,294,132,-1188,4752,-11088,16632,-16632,11088}
1131	884	5	8e3cf506b3b239ff2ab72d1c2b34b929c913c2cd957bbf25adb1d44832901ee2	{1,1,0,0,0,0,0,2,6,6,2,0,0,0,7,35,70,70,35,7,0,30,210,630,1050,1050,630,210,143,1287,5148,12012,18018,18018,12012,728,8008,40040,120120,240240,336336,336336,3876,50388,302328,1108536,2771340,4988412,6651216}
1132	887	5	ef21af4f267bb5205faff444a2930b52a02ffe1be59583f052d527bea7965c42	{1,2,1,0,0,0,0,2,8,12,8,2,0,0,7,42,105,140,105,42,7,30,240,840,1680,2100,1680,840,143,1430,6435,17160,30030,36036,30030,728,8736,48048,160160,360360,576576,672672,3876,54264,352716,1410864,3879876,7759752,11639628}
1133	888	5	2835ebe235575471d7bd845c10da36bc3dad43e32fbcfe39827af1780e508295	{1,3,3,1,0,0,0,2,10,20,20,10,2,0,7,49,147,245,245,147,49,30,270,1080,2520,3780,3780,2520,143,1573,7865,23595,47190,66066,66066,728,9464,56784,208208,520520,936936,1249248,3876,58140,406980,1763580,5290740,11639628,19399380}
1134	898	5	64316dbe709f87529d59b1b060c0dfbb7661b1766188e88a3687c557a918bef0	{1,2,3,4,5,6,7,2,8,20,40,70,112,168,7,42,147,392,882,1764,3234,30,240,1080,3600,9900,23760,51480,143,1430,7865,31460,102245,286286,715715,728,8736,56784,264992,993720,3179904,9009728,3876,54264,406980,2170560,9224880,33209568,105163632}
1135	899	5	82f3ab9711dec83def084f85f74de89ee4e7fa9ae389d1087159d07d5097032b	{1,1,1,1,1,1,1,2,6,12,20,30,42,56,7,35,105,245,490,882,1470,30,210,840,2520,6300,13860,27720,143,1287,6435,23595,70785,184041,429429,728,8008,48048,208208,728728,2186184,5829824,3876,50388,352716,1763580,7054320,23984688,71954064}
1158	285	6	560d2a8ef1f3b1c4a296b6948d3f27b8faeeca4f327968e12c6839fcdcd6cc32	{None,0,0,0,0,0,0,-1,0,0,0,0,0,0,-1,0,0,0,0,0,0,-7,0,0,0,0,0,0,-29,0,0,0,0,0,0,-143,0,0,0,0,0,0,-727,0,0,0,0,0,0}
1184	129	6	9569b99527bd24505dd226ff2b46bbffabd1488918a8e0ce417d84d892514fde	{1,0,0,0,0,0,0,2,2,0,0,0,0,0,3,9,3,0,0,0,0,4,24,24,4,0,0,0,5,50,100,50,5,0,0,6,90,300,300,90,6,0,7,147,735,1225,735,147,7}
1195	323	6	551e8b15be547418fbf59dbfdb9c1788e0846b7994be099e6e0e9960ff26457f	{None,0,0,0,0,0,0,-1,2,1,2,5,14,42,1,-5,5,0,0,-1,-5,-2,16,-40,32,-4,0,0,5,-55,220,-385,275,-55,0,-14,196,-1078,2940,-4116,2744,-686,42,-714,4998,-18564,39270,-47124,29988}
428	345	1	71ffc9070b86c4f5123776c0259c92ecf8943e8d74d598c8ec622ea7e1b7d3ad	{1,1,2,5,14,42,132,2,-2,-2,-4,-10,-28,-84,-3,9,0,3,9,27,84,10,-50,50,0,0,-10,-50,-42,294,-588,294,0,0,0,198,-1782,5346,-5940,1782,0,0,-1001,11011,-44044,77077,-55055,11011,0}
2	2	1	3a2a1c60feb1047f7d8216c858810f993213ffee6c42070493707cc7900308f0	{0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
535	482	1	d41919590bca89785adc96de8f5fb61ca637cbf78592d7ce7a5a5877a4d140fd	{1,2,5,14,42,132,429,2,8,30,112,420,1584,6006,5,28,135,616,2730,11880,51051,14,96,550,2912,14700,71808,342342,42,330,2145,12740,71400,383724,1996995,132,1144,8190,53312,325584,1896048,10636626,429,4004,30940,217056,1424430,8883336,53183130}
225	100	1	58c987c68fc315bd7f2dc5f9999f83a437558959a32d88c6eb5b7875b13fd88a	{1,0,2,0,6,0,20,1,0,6,0,30,0,140,1,0,12,0,90,0,560,1,0,20,0,210,0,1680,1,0,30,0,420,0,4200,1,0,42,0,756,0,9240,1,0,56,0,1260,0,18480}
393	300	1	4bfedcf80fb86e73fffbbf68551984028b4387cc266b5d409b48afbeddb31b99	{1,0,1,0,2,0,5,1,0,3,0,10,0,35,1,0,6,0,30,0,140,1,0,10,0,70,0,420,1,0,15,0,140,0,1050,1,0,21,0,252,0,2310,1,0,28,0,420,0,4620}
1080	123	6	298b0fc27963238a19a4a262cb0ce2842075332dd5e3ade1dfda3b7796cfe462	{1,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-3,-1,0,0,0,0,-1,-6,-6,-1,0,0,0,-1,-10,-20,-10,-1,0}
1181	124	1	583f68074495ff72fc4430b4d9cfa5ea7e8322baf1fc4b80ccffb4c1f8594e75	{1,-1,-1,-2,-5,-14,-42,0,-1,-2,-6,-20,-70,-252,0,-1,-3,-12,-50,-210,-882,0,-1,-4,-20,-100,-490,-2352,0,-1,-5,-30,-175,-980,-5292,0,-1,-6,-42,-280,-1764,-10584,0,-1,-7,-56,-420,-2940,-19404}
256	137	1	226d34e0f3d29858dc7e24d5eb77a4f4b5e38a474a4fa8a668a25d55d011a70f	{1,-1,2,-5,14,-42,132,-2,6,-20,70,-252,924,-3432,5,-28,135,-616,2730,-11880,51051,-14,120,-770,4368,-23100,116688,-570570,42,-495,4004,-27300,168300,-969969,5325320,-132,2002,-19656,157080,-1108536,7189182,-43835792,429,-8008,92820,-852720,6789783,-48992944,328768440}
326	210	1	5ed376170696d3f4e2c182670e6e1797fa7c3213da320392d9598967b45073a1	{1,1,2,5,14,42,132,2,5,16,55,196,714,2640,1,10,56,275,1274,5712,25080,0,10,112,825,5096,28560,150480,0,5,140,1650,14014,99960,639540,0,1,112,2310,28028,259896,2046528,0,0,56,2310,42042,519792,5116320}
222	97	1	4587257756a996fd46f050fb099ce3ccb247a87079ad1662f81049f278d9d785	{1,2,6,20,70,252,924,2,12,60,280,1260,5544,24024,6,60,420,2520,13860,72072,360360,20,280,2520,18480,120120,720720,4084080,70,1260,13860,120120,900900,6126120,38798760,252,5544,72072,720720,6126120,46558512,325909584,924,24024,360360,4084080,38798760,325909584,2498640144}
354	241	1	f3acfa62cccf342587908eeabcc63a0310233f61f148c226e9ec7e6b643eba3e	{0,1,0,0,0,0,0,1,2,0,0,0,0,0,3,3,0,0,0,0,0,6,4,0,0,0,0,0,10,5,0,0,0,0,0,15,6,0,0,0,0,0,21,7,0,0,0,0,0}
1187	242	6	00e5a31d8576010d39530b834b60f58d447441d38a16e5fdb487e35b847c8362	{0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
1206	712	1	89c6d66fdc75016ea568e1755e37281c09b3c9a912f154f0f2d4d0c67ee85bab	{1,2,-2,4,-10,28,-84,1,4,0,0,0,0,0,0,0,0,None,0,0,0,0,0,0,0,0,0,0,0,0,0,0,None,None,0,0,0,0,0,0,0,0,0,0,0,0,0,None,None}
1197	377	6	6cfaff70d158db0f545ad081172916427affb99740b8759ca195abf675987b4f	{1,2,6,20,70,252,924,None,-4,0,0,0,0,0,None,10,-30,20,10,12,20,None,-32,192,-512,512,0,0,None,110,-990,4620,-11550,13860,-4620,None,-392,4704,-31360,125440,-301056,401408,None,1428,-21420,185640,-1021020,3675672,-8576568}
1188	256	6	3ee429e93ad5767696039d296a8773448616285ac7879b625282584a8bb3c31b	{1,1,0,0,0,0,0,1,0,0,0,0,0,0,2,0,0,0,0,0,0,5,0,0,0,0,0,0,14,0,0,0,0,0,0,42,0,0,0,0,0,0,132,0,0,0,0,0,0}
1198	703	1	d43f29055277f01abff61ce4dc3673e0eb71a73e85053cb95ff5aabd65dff7d0	{1,1,0,0,0,0,0,2,2,0,0,0,0,0,-2,-2,0,0,0,0,0,4,4,0,0,0,0,0,-10,-10,0,0,0,0,0,28,28,0,0,0,0,0,-84,-84,0,0,0,0,0}
1189	288	1	47f23987f765844103a9824cba71f4c12ae5c40f0f1e3aa0f70d1a586db425dd	{1,1,-1,2,-5,14,-42,1,0,1,-4,15,-56,210,3,0,2,-6,15,-28,0,12,0,7,-20,50,-112,210,55,0,30,-84,210,-490,1050,273,0,143,-396,990,-2352,5292,1428,0,728,-2002,5005,-12012,27720}
1190	291	6	56507b984f399280afebc6fc7e273ddc6c19724d35a21b38506d832ed3aee564	{1,1,3,12,55,273,1428,None,0,0,0,0,0,0,None,1,2,7,30,143,728,None,-4,-6,-20,-84,-396,-2002,None,15,15,50,210,990,5005,None,-56,-28,-112,-490,-2352,-12012,None,210,0,210,1050,5292,27720}
310	192	1	0aa7079922333bf4ebacd9b96a201b4aa38214e319ab2b71d01ac66dd4731189	{1,1,2,5,14,42,132,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
1192	310	6	ee2b4be2a2c5ae93f05da0f332c4e7df0b0d68a422380a62e437df61ae0cc460	{1,1,2,5,14,42,132,1,-2,-1,-2,-5,-14,-42,-1,5,-5,0,0,1,5,2,-16,40,-32,4,0,0,-5,55,-220,385,-275,55,0,14,-196,1078,-2940,4116,-2744,686,-42,714,-4998,18564,-39270,47124,-29988}
1194	322	6	4f59e7a9a621545f919e5c4bd4627e263b6592bc451c3fba8171eaceefc07dbe	{0,-1,1,-2,5,-14,42,0,1,-3,10,-35,126,-462,0,2,-3,0,35,-252,1386,0,7,-10,10,0,42,-924,0,30,-42,50,-35,0,0,0,143,-198,252,-245,126,0,0,728,-1001,1320,-1470,1176,-462}
1200	705	1	b8393af74b3811f110e605af40087b8d79739b9181771be118a2eada96ce2111	{1,1,2,5,14,42,132,2,6,20,70,252,924,3432,-2,6,60,350,1764,8316,37752,4,None,40,700,5880,38808,226512,-10,6,None,350,8820,97020,792792,28,-12,None,None,3528,116424,1585584,-84,27,-40,None,None,38808,1585584}
1207	713	1	51d52ac2defbe0abf4822f637efd75e35e82f55d68f1dc53b032dc02d07eb497	{1,0,0,0,0,0,0,1,2,-2,4,-10,28,-84,2,8,0,0,0,0,0,5,30,30,None,30,-60,139,14,112,224,0,0,0,0,42,419,1260,839,None,None,-839,132,1584,6336,8448,0,0,0}
1201	707	1	8b06d2835ea16d3c6d954032ff29d5e8b850507f2cb5e8aaa08fb0585c4e1770	{1,2,5,14,42,132,429,2,8,30,112,420,1584,6006,-2,0,30,224,1260,6336,30030,4,0,None,0,840,8448,60060,-10,0,30,0,None,0,30030,28,0,-60,0,None,0,None,-84,0,139,0,-840,0,None}
1202	708	1	7246884a6bf5c23ccb49f18af7070a2b48cc4d4fd8df32101c6f13f4099f10ac	{1,2,3,4,5,6,7,2,4,6,8,10,12,14,-2,-4,-6,-8,-10,-12,-14,4,8,12,16,20,24,28,-10,-20,-30,-40,-50,-60,-70,28,56,84,112,140,168,196,-84,-168,-252,-336,-420,-504,-588}
1204	710	1	ac5f26825a79024d641c06f1fa23fcba473f3bda0c4e05c1a3712f1ac6b164bd	{1,1,0,0,0,0,0,2,4,2,0,0,0,0,2,6,6,2,0,0,0,0,0,0,0,0,0,0,None,None,None,None,None,None,None,0,0,0,0,0,0,0,None,None,None,None,None,None,None}
1205	711	1	13c592656a59b9b6872c92b0812a4231d08e6b49321b69ef687f9b7d4893c7f9	{1,0,0,0,0,0,0,1,2,-2,4,-10,27,-84,0,2,0,0,0,0,0,0,0,2,None,12,-40,139,0,0,0,0,0,0,0,0,0,0,0,None,None,-59,0,0,0,0,0,0,0}
1208	714	1	f9c549e9233177dbea6e1c2cb91baf072eb8fd824b9e798c725393f1ab1750bc	{1,0,0,0,0,0,0,2,4,-4,8,-20,56,-168,5,20,0,0,0,0,0,14,84,84,None,84,-168,391,42,336,672,0,0,0,0,132,1319,3960,2639,None,None,-2639,429,5148,20592,27456,0,0,0}
1210	715	1	fecb2b559efd73f597106bf2242610e92adb9878b7c1b3ab2d42a5964e5ed3bd	{1,0,0,0,0,0,0,1,2,-2,4,-10,28,-84,-1,-4,0,0,0,0,0,2,12,12,None,12,-24,55,-5,-40,-80,0,0,0,0,14,140,420,280,None,None,-280,-42,-504,-2016,-2688,0,0,0}
1212	717	1	759b216cb60747f259e0ecd24387489cc1b54137fae14b660a860e58c3cdd11e	{1,2,-2,4,-10,28,-84,1,6,6,None,6,-12,27,1,10,30,20,None,None,-20,1,14,70,140,70,None,None,1,18,126,420,630,252,None,1,22,198,924,2310,2772,924,1,25,286,1716,6006,12012,12012}
1211	716	1	a66adaebafa9030dadd10080d4fca9a9df6a45ee0d4eab1ad8a17971e2f262d6	{1,0,0,0,0,0,0,2,4,-4,8,-20,56,-168,6,24,0,0,0,0,0,20,120,120,None,120,-240,559,70,560,1120,0,0,0,0,252,2520,7560,5040,None,None,-5040,924,11088,44352,59136,0,0,0}
1176	393	6	e8dbc12b5d8139447bfc277cbd842e3c70e908ea4d84d392d5d3345a755a0785	{1,2,6,20,70,252,924,1,2,6,20,70,252,924,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
1177	394	6	19fc24612b0bf6d1c0850d037acf06e85228f4c1219d0301cf9d35cbd92934ac	{1,2,6,20,70,252,924,1,4,16,64,256,1024,4096,1,6,30,140,630,2772,12012,1,8,48,256,1280,6144,28672,1,10,70,420,2310,12012,60060,1,12,96,640,3840,21504,114688,1,14,126,924,6006,36036,204204}
1213	396	\N	0c9a6fd5e0f5303622f0f76fcd5c779ae15c4a895b26c09396b4b78440c94677	{1,2,6,20,70,252,924,1,0,0,0,0,0,0,-1,2,2,4,10,28,84,2,-8,0,0,0,0,0,-5,30,-30,-20,-30,-60,-140,14,-112,224,0,0,0,0,-42,420,-1260,840,420,504,840}
1193	321	6	5698f907bac010cef7b7581c58f5d49a620a6ed320f452349ca647751716cd4b	{1,1,-1,2,-5,14,-42,1,None,None,None,None,None,None,3,None,None,None,None,None,None,12,None,None,None,None,None,None,55,None,None,None,None,None,None,273,None,None,None,None,None,None,1428,None,None,None,None,None,None}
1214	225	6	560d2a8ef1f3b1c4a296b6948d3f27b8faeeca4f327968e12c6839fcdcd6cc32	{None,1,-1,2,-5,14,-42,2,-2,6,-20,70,-252,924,5,-1,-9,70,-385,1890,-8778,14,-2,2,-100,1050,-7644,47124,42,-5,0,50,-1470,18018,-157080,132,-14,0,-4,980,-24948,336336,429,-42,1,0,-245,19404,-462462}
1217	1055	6	f6c441340710ca79c7f79476683c9e305ddb296fea9b2414cd7e23ecdf777fab	{6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6}
1216	732	1	560d2a8ef1f3b1c4a296b6948d3f27b8faeeca4f327968e12c6839fcdcd6cc32	{1,1,1,1,1,1,1,2,2,2,2,2,2,2,-3,-3,-3,-3,-3,-3,-3,10,10,10,10,10,10,10,-42,-42,-42,-42,-42,-42,-42,198,198,198,198,198,198,198,-1001,-1001,-1001,-1001,-1001,-1001,-1001}
1218	738	1	560d2a8ef1f3b1c4a296b6948d3f27b8faeeca4f327968e12c6839fcdcd6cc32	{1,2,3,4,5,6,7,2,4,6,8,10,12,14,-3,-6,-9,-12,-15,-18,-21,10,20,30,40,50,60,70,-42,-84,-126,-168,-210,-252,-294,198,396,594,792,990,1188,1386,-1001,-2002,-3003,-4004,-5005,-6006,-7007}
707	742	1	048630aaa264d32b7ca90a5ebe06efe1ac5d5b7a7bc4b4c7cef18d8f403b2111	{1,1,0,0,0,0,0,3,6,3,0,0,0,0,6,18,18,6,0,0,0,10,40,60,40,10,0,0,15,75,150,150,75,15,0,21,126,315,420,315,126,21,28,196,588,980,980,588,196}
1220	743	1	b14438d780003325ce0a7e5a3f8920ae2af1e87bd7ac61ac99c0f614fdef7a4b	{1,2,1,0,0,0,0,3,6,3,0,0,0,0,-3,-6,-3,0,0,0,0,10,20,10,0,0,0,0,-42,-84,-42,0,0,0,0,198,396,198,0,0,0,0,-1001,-2002,-1001,0,0,0,0}
1221	745	1	2079a128d14154886ead3ebcb2a9b4dfa0fb74bac3bd635180ea984e0f8b7f9f	{1,1,0,0,0,0,0,4,4,0,0,0,0,0,-2,-2,0,0,0,0,0,8,8,0,0,0,0,0,-35,-35,0,0,0,0,0,168,168,0,0,0,0,0,-858,-858,0,0,0,0,0}
1178	402	6	83d975ebb9b52634d88a834e769dbef689fa8b0eb85723749598e2a188c33f6b	{1,2,5,14,42,132,429,1,2,5,14,42,132,429,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
1179	404	6	fd60e9d692f461b0a24d6825c6e1f4ca02b0e1b4bc3c1695c3afd8ff0a24786b	{1,2,5,14,42,132,429,1,6,27,110,429,1638,6188,2,20,130,700,3400,15504,67830,5,70,595,3990,23275,123970,619850,14,252,2646,21252,144900,884520,4987710,42,924,11550,108108,844074,5814732,36549744,132,3432,49764,531960,4681248,35939904,249333084}
1223	748	1	0ae76ab05b6938bec1f4399d750522b6b10cc50653881efc7154bda1bef6354c	{1,1,2,5,14,42,132,2,4,10,28,84,264,858,1,3,9,28,90,297,1001,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
1248	789	1	3386edef8dcfd84702f85ae4678d20d1a662e7aa3c9d10cd79866df052e2c8fb	{1,1,1,1,1,1,1,2,4,6,8,10,12,14,7,18,33,52,75,102,133,30,88,182,320,510,760,1078,143,455,1020,1938,3325,5313,8050,728,2448,5814,11704,21252,35880,57330,3876,13566,33649,70840,134550,237510,396459}
1224	749	1	a437e4ec255c501197cc9afdb032ff4917a5445717559ad4da41fa2ba6316353	{1,1,2,5,14,42,132,2,6,18,56,180,594,2002,5,25,100,375,1375,5005,18200,14,98,490,2156,8918,35672,139944,42,378,2268,11466,52920,231336,976752,132,1452,10164,58080,296208,1406988,6372828,429,5577,44616,284427,1589445,8159151,39507468}
1249	790	1	99c0f23da89ecca4410004a5b448d156e1eb44171fa01011cb7a9d28fae8eaa1	{1,1,2,5,14,42,132,2,6,20,70,252,924,3432,7,33,150,665,2898,12474,53196,30,182,1020,5390,27300,133980,641784,143,1020,6650,40250,230202,1260336,6666660,728,5814,42504,286650,1812384,10885644,62730096,3876,33649,269100,1982295,13634544,88666578,550606056}
1226	753	1	560d2a8ef1f3b1c4a296b6948d3f27b8faeeca4f327968e12c6839fcdcd6cc32	{1,2,6,20,70,252,924,2,4,12,40,140,504,1848,-3,-6,-18,-60,-210,-756,-2772,10,20,60,200,700,2520,9240,-42,-84,-252,-840,-2940,-10584,-38808,198,396,1188,3960,13860,49896,182952,-1001,-2002,-6006,-20020,-70070,-252252,-924924}
1227	757	1	e41d20970d69e7462659b9a34a0e825be64c2f777e53af4aba7030c1b1e117e1	{1,1,1,1,1,1,1,3,6,9,12,15,18,21,9,27,54,90,135,189,252,28,112,280,560,980,1568,2352,90,450,1350,3150,6300,11340,18900,297,1782,6237,16632,37422,74844,137214,1001,7007,28028,84084,210210,462462,924924}
1228	758	1	d8bd00c29af54fce42c99378ff6039e513fb196aaa2c01b2f13cea9a9c63123f	{1,2,1,0,0,0,0,3,12,18,12,3,0,0,9,54,135,180,135,54,9,28,224,784,1568,1960,1568,784,90,900,4050,10800,18900,22680,18900,297,3564,19602,65340,147015,235224,274428,1001,14014,91091,364364,1002001,2004002,3006003}
1229	759	1	2718f59fee1fdee276985c140dc2cb6800b51c5740365aed8a0460fdc67035bc	{1,2,3,4,5,6,7,3,12,30,60,105,168,252,9,54,189,504,1134,2268,4158,28,224,1008,3360,9240,22176,48048,90,900,4950,19800,64350,180180,450450,297,3564,23166,108108,405405,1297296,3675672,1001,14014,105105,560560,2382380,8576568,27159132}
1250	791	1	6689c54129fd447be61d614025bf8ae9cfc6503788ce9cb4615c6b8fb89438a1	{1,2,5,14,42,132,429,2,8,30,112,420,1584,6006,7,36,165,728,3150,13464,57057,30,176,910,4480,21420,100320,462462,143,910,5100,27132,139650,701316,3453450,728,4896,29070,163856,892584,4736160,24594570,3876,27132,168245,991760,5651100,31351320,170080911}
1231	762	1	403189e2d86590e969d0fd87149d57a75c968317755b07d08c44f97a916c7137	{1,1,-1,2,-5,14,-42,3,6,-3,6,-15,42,-126,9,27,0,9,-27,81,-252,28,112,56,0,-28,112,-392,90,450,450,0,0,90,-450,297,1782,2673,594,0,0,-297,1001,7007,14014,7007,0,0,0}
1232	763	1	4b7a069c505d4c7be1e9bac1e0829c4cf009921c7f23374f071c0c8750c491ab	{1,2,-2,4,-10,28,-84,3,12,0,0,0,0,0,9,54,54,None,54,-108,251,28,224,448,0,0,0,0,90,900,2700,1800,None,None,-1800,297,3564,14256,19008,0,0,0,1001,14014,70070,140140,70070,None,None}
1233	764	1	588a1305b96868b9e4881c9b1c4f1f4efecd538401054019d743694dcda6ea67	{1,2,6,20,70,252,924,3,18,90,420,1890,8316,36036,9,54,270,1260,5670,24948,108108,28,280,1960,11760,64680,336336,1681680,90,900,6300,37800,207900,1081080,5405400,297,4158,37422,274428,1783782,10702692,60648588,1001,14014,126126,924924,6012006,36072036,204408204}
1236	767	1	f1d049b1c9fb6da64d95b4df1202bea800ce49eb9a32675d7996a7cd0f5fe53c	{1,2,-2,4,-10,28,-84,2,4,-4,8,-20,56,-168,-3,-6,6,-12,30,-84,252,10,20,-20,40,-100,280,-840,-42,-84,84,-168,420,-1176,3528,198,396,-396,792,-1980,5544,-16632,-1001,-2002,2002,-4004,10010,-28028,84084}
716	768	1	8d84b332ddc9457a8758ca72086f3e4e531469abce8df14ba289e0c223957d9b	{1,2,-2,4,-10,28,-84,2,8,0,0,0,0,0,1,6,6,None,6,-12,27,0,0,0,0,0,0,0,0,0,0,0,None,None,0,0,0,0,0,0,0,0,0,0,0,0,0,None,None}
1251	792	1	1e77238eed82eac424d856c22ebb2d9eb8a40cdc33496253335fd4d7e7797aa4	{1,1,2,5,14,42,132,2,4,12,40,140,504,1848,7,18,66,260,1050,4284,17556,30,88,364,1600,7140,31920,142296,143,455,2040,9690,46550,223146,1062600,728,2448,11628,58520,297528,1506960,7567560,3876,13566,67298,354200,1883700,9975420,52332588}
1238	771	1	7b70287b3b8d9f1dba0491e12dea06fbc673c61283a7992d8274ff36817d4aba	{1,1,3,12,55,273,1428,2,4,14,60,286,1456,7752,1,3,12,55,273,1428,7752,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
1239	772	1	05ec933fed3295193cf52c4ad296b6e81e1ac75b9f92329f5034a418e9d9bc33	{1,1,3,12,55,273,1428,2,6,24,110,546,2856,15504,5,25,125,650,3500,19380,109725,14,98,588,3430,19992,117306,694232,42,378,2646,17136,107730,669438,4144140,132,1452,11616,82764,559020,3673560,23783760,429,5577,50193,390390,2821962,19575270,132459327}
1240	773	1	646cc73e41b2891ab8047a29e89c201e0e97bc8322de5699f952264d34ae53e2	{1,1,0,0,0,0,0,2,2,0,0,0,0,0,7,7,0,0,0,0,0,30,30,0,0,0,0,0,143,143,0,0,0,0,0,728,728,0,0,0,0,0,3876,3876,0,0,0,0,0}
1242	777	1	3e5c703da9453abcc63386405bb1965778e5b340cffeca6f973b801f4e8bd5b1	{1,1,1,1,1,1,1,2,2,2,2,2,2,2,7,7,7,7,7,7,7,30,30,30,30,30,30,30,143,143,143,143,143,143,143,728,728,728,728,728,728,728,3876,3876,3876,3876,3876,3876,3876}
1243	779	1	e1ee73ea11127618849f2493df0c8a43f76353332e08c6df130dabb6d3601ed8	{1,2,3,4,5,6,7,2,4,6,8,10,12,14,7,14,21,28,35,42,49,30,60,90,120,150,180,210,143,286,429,572,715,858,1001,728,1456,2184,2912,3640,4368,5096,3876,7752,11628,15504,19380,23256,27132}
1252	793	1	6482638b11aaf6cb5e6ba1d8e362bd00cbd178fb57026a9e708805750dc62a5c	{1,2,7,30,143,728,3876,2,14,90,572,3640,23256,149226,7,90,858,7280,58140,447678,3364900,30,572,7280,77520,746130,6729800,58017960,143,3640,58140,746130,8412250,87026940,846723150,728,23256,447678,6729800,87026940,1016067780,11014763760,3876,149226,3364900,58017960,846723150,11014763760,131668791408}
1244	781	1	3d48be96b0c248db189240e0b77062207e256b9cdb61e9d4f102ad58a719d3db	{3,2,4,10,28,84,264,4,4,8,20,56,168,528,14,14,28,70,196,588,1848,60,60,120,300,840,2520,7920,286,286,572,1430,4004,12012,37752,1456,1456,2912,7280,20384,61152,192192,7752,7752,15504,38760,108528,325584,1023264}
1246	785	1	4ef80a746de4f79779e130d193bcfaaf150c6d4cda107555365e635872b9d640	{1,1,0,0,0,0,0,3,3,0,0,0,0,0,12,12,0,0,0,0,0,55,55,0,0,0,0,0,273,273,0,0,0,0,0,1428,1428,0,0,0,0,0,7752,7752,0,0,0,0,0}
1247	787	1	0f4b094b94e3236c7382ff8d8dada0db4a84864a65d984bf79be3758b112e192	{1,2,1,0,0,0,0,3,6,3,0,0,0,0,12,24,12,0,0,0,0,55,110,55,0,0,0,0,273,546,273,0,0,0,0,1428,2856,1428,0,0,0,0,7752,15504,7752,0,0,0,0}
1253	794	1	560d2a8ef1f3b1c4a296b6948d3f27b8faeeca4f327968e12c6839fcdcd6cc32	{1,0,0,0,0,0,0,1,1,0,0,0,0,0,3,6,3,0,0,0,0,12,36,36,12,0,0,0,55,220,330,220,55,0,0,273,1365,2730,2730,1365,273,0,1428,8568,21420,28560,21420,8568,1428}
394	307	1	57a5d291b84fe34db106a2cc33927ac9a6aee32d4bf666f4f55bdb434db361e3	{1,1,2,5,14,42,132,1,1,2,5,14,42,132,2,2,4,10,28,84,264,5,5,10,25,70,210,660,14,14,28,70,196,588,1848,42,42,84,210,588,1764,5544,132,132,264,660,1848,5544,17424}
1255	796	1	53302aee6a091e29cf64b57976fe83349402ef0e04a420483926c7bd53cd17da	{1,0,0,0,0,0,0,1,1,1,1,1,1,1,3,6,9,12,15,18,21,12,36,72,120,180,252,336,55,220,550,1100,1925,3080,4620,273,1365,4095,9555,19110,34398,57330,1428,8568,29988,79968,179928,359856,659736}
1257	409	2	8207679d196570a8e5d74d27f6e9361fc1ee4c72e58121efdcdd5d1de2b77842	{None,1,3,12,55,273,1428,None,-1,-2,-7,-30,-143,-728,None,6,6,20,84,396,2002,None,-35,0,-35,-175,-882,-4620,None,210,-210,0,210,1470,8820,None,-1287,2574,-429,0,-1287,-12012,None,8008,-24024,16016,0,0,8008}
623	601	1	f84cb6a2818921f22b34a36681521420a2ec78c2237b5109dc5a05d501a002bb	{1,-1,0,-2,-4,-13,-42,1,0,0,0,0,0,0,2,2,3,8,26,85,262,5,10,30,76,202,668,2140,14,42,105,364,1228,4124,14035,42,168,672,1904,7056,24158,84224,132,660,2310,10340,35805,132660,479930}
1259	615	\N	ea7dc9d2b31220ed995e2c7e6594ea11f5908f08d0029dd63091ed5516f22d20	{1,-1,-1,-7,-29,-143,-727,1,-1,-1,-7,-29,-143,-727,1,-1,-1,-7,-29,-143,-727,1,-1,-1,-7,-29,-143,-727,1,-1,-1,-7,-29,-143,-727,1,-1,-1,-7,-29,-143,-727,1,-1,-1,-7,-29,-143,-727}
1260	616	\N	ef40fd335d94ba4405ed1f73d6da30b5556fb24b138790043bd799df92daefa2	{1,-1,-1,-7,-29,-143,-727,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
1261	619	5	e53ba41222fce753ad413827ab57f31e0779196f4f56515ed9719106d8f7cf48	{1,-1,-1,-7,-29,-143,-727,2,-2,-3,-15,-58,-287,-1454,3,-3,-4,-23,-87,-431,-2181,4,-4,-6,-30,-117,-575,-2908,5,-5,-7,-38,-146,-719,-3635,6,-6,-9,-46,-175,-862,-4363,7,-7,-10,-53,-204,-1006,-5090}
96	1017	6	cf04c77a1714aa03b60d04837d0b29677e0ebff6d2afc3dcb05e3ac1f9d6fd47	{1,1,0,0,0,0,0,3,3,0,0,0,0,0,3,3,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
1265	1340	2	f1be011fdf85714039335de3e904e6d12eb22f39e0c35caf50fe78fc7f5249c5	{1,3,3,1,0,0,0,1,9,36,84,126,126,84,3,45,315,1365,4095,9009,15015,12,252,2520,15960,71820,244188,651168,55,1485,19305,160875,965250,4440150,16280550,273,9009,144144,1489488,11171160,64792728,302366064,1428,55692,1058148,13050492,117454428,822180996,4659025644}
1267	1354	2	54f457fe4c6e6fddf99d50351fe06970e14ba61a621e1b45b0af365c574a0529	{1,6,30,140,630,2772,12012,1,12,96,640,3840,21504,114688,2,36,396,3432,25740,175032,1108536,5,120,1680,17920,161280,1290240,9461760,14,420,7140,90440,949620,8736504,72804200,42,1512,30240,443520,5322240,55351296,516612096,132,5544,127512,2125200,28690200,332806320,3438998640}
1268	1355	2	73fb12ef0d34b2233cc422473dc381b31e82b5e4ec5b6887d7899a3a8f909942	{1,6,30,140,630,2772,12012,1,18,198,1716,12870,87516,554268,3,90,1530,19380,203490,1872108,15600900,12,504,11592,193200,2608200,30255120,312636240,55,2970,86130,1780020,29370330,411184620,5071276980,273,18018,630630,15555540,303333030,4974661692,71303484252,1428,111384,4566744,130913328,2945549880,55376337744,904480183152}
1270	1357	2	152dd5c7d587e9d4c00264395a7b5a1f32b949dbaefac2c4e1a3c15071b04f53	{1,1,2,5,14,42,132,1,3,9,28,90,297,1001,3,15,60,225,825,3003,10920,12,84,420,1848,7644,30576,119952,55,495,2970,15015,69300,302940,1279080,273,3003,21021,120120,612612,2909907,13180167,1428,18564,148512,946764,5290740,27159132,131507376}
1272	1362	2	3505c2642693f555e1b5f97886f4fa5af6e2bf0cd5d0765ae8ef561904693d89	{1,3,9,28,90,297,1001,1,9,54,273,1260,5508,23256,3,45,405,2850,17325,95634,493350,12,252,3024,27300,206388,1381212,8457792,55,1485,22275,245520,2221560,17494785,124230645,273,9009,162162,2111109,22252230,201675474,1630641012,1428,55692,1169532,17561544,211351140,2167309872,19666330320}
1273	1477	2	12c91e5635ac76be061426c0c0413a25177dd9f73a0003d04381ad29e7a162d8	{1,3,6,10,15,21,28,1,6,21,56,126,252,462,3,27,135,495,1485,3861,9009,12,144,936,4368,16380,52416,148512,55,825,6600,37400,168300,639540,2131800,273,4914,46683,311220,1633905,7189182,27558531,1428,29988,329868,2528988,15173928,75869640,328768440}
1275	1072	2	91f9859be7db451ed893bb9650b9a4d6baa6d9783c685b1ea264b9bbbe7a79d7	{0,1,5,16,54,190,667,1,4,14,48,165,572,2002,2,11,42,144,495,1715,6006,9,37,130,448,1540,5338,18685,29,120,420,1440,4949,17160,60060,99,396,1386,4752,16335,56628,198198,333,1334,4671,16016,55055,190857,668000}
1276	991	2	5a1d036b49c6b973e2e4e922b7de88263c2bc01471ca7e9af6737ebdeb63f331	{1,0,0,0,0,0,0,2,2,0,0,0,0,0,5,10,5,0,0,0,0,14,42,42,14,0,0,0,42,168,252,168,42,0,0,132,660,1320,1320,660,132,0,429,2574,6435,8580,6435,2574,429}
1277	807	2	a43dff69820ba1ab0e91ac955e8669f5dde1cb9f4531d3a073f2f11f8c3c4aa2	{1,0,0,0,0,0,0,2,2,4,10,28,84,264,5,10,25,70,210,660,2145,14,42,126,392,1260,4158,14014,42,168,588,2016,6930,24024,84084,132,660,2640,9900,36300,132132,480480,429,2574,11583,47190,184041,702702,2654652}
1279	1087	2	587e61ddfbfe242989aa879d485b8809936f77d3d668b67d28fb9602de3ef5a3	{1,3,3,1,0,0,0,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None}
1280	1217	2	a513507ba418b91d8f552a4b4a4ec4617c1e8be26994d35c803ff6984c94f7d5	{1,2,14,132,1430,16796,208012,1,2,14,132,1430,16796,208012,1,2,14,132,1430,16796,208012,1,2,14,132,1430,16796,208012,1,2,14,132,1430,16796,208012,1,2,14,132,1430,16796,208012,1,2,14,132,1430,16796,208012}
1281	1218	2	aede2d19100aef3cd484256720d8f1fc92ddf86498848808e5a7064745810b8e	{1,2,10,63,462,3583,29172,1,2,10,63,462,3583,29172,1,2,10,63,462,3583,29172,1,2,10,63,462,3583,29172,1,2,10,63,462,3583,29172,1,2,10,63,462,3583,29172,1,2,10,63,462,3583,29172}
1282	1189	2	1cbc7cf397b2d61e815c4c213ac68f2e564ea7296e0f65ae508fa1e70bcb7676	{1,0,0,0,0,0,0,4,4,0,0,0,0,0,14,28,14,0,0,0,0,48,144,144,48,0,0,0,165,660,990,660,165,0,0,572,2860,5720,5720,2860,572,0,2002,12012,30030,40040,30030,12012,2002}
1289	1336	2	d90f67b07420f7a31fb03ac7d8d0a3edd018074de92795544823ea3ee1efe54d	{1,5,10,10,5,1,0,1,15,105,455,1365,3003,5005,3,75,900,6900,37950,159390,531300,12,420,7140,78540,628320,3895584,19477920,55,2475,54450,780450,8194725,67196745,447978300,273,15015,405405,7162155,93108015,949701753,7914181275,1428,92820,2970240,62375040,966813120,11795120064,117951200640}
1290	1427	2	be0ea93c5cd7d9776a39737a93fa28cfa9bb01f8e6a7f72f32599e0596117ac2	{1,2,3,4,5,6,7,3,9,18,30,45,63,84,3,12,30,60,105,168,252,1,5,15,35,70,126,210,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
1291	1471	2	9200e7b168080f52028ecaf4f9a19cc2e9b069a583597881e489ab3d3e06550f	{1,1,1,1,1,1,1,1,3,6,10,15,21,28,3,15,45,105,210,378,630,12,84,336,1008,2520,5544,11088,55,495,2475,9075,27225,70785,165165,273,3003,18018,78078,273273,819819,2186184,1428,18564,129948,649740,2598960,8836464,26509392}
1294	872	2	fa3675b1d7634ebf1c7b23baf507e0d00419d526ecc92450dbfd8c28ee7f24d6	{1,1,0,0,0,0,0,1,3,3,1,0,0,0,3,15,30,30,15,3,0,12,84,252,420,420,252,84,55,495,1980,4620,6930,6930,4620,273,3003,15015,45045,90090,126126,126126,1428,18564,111384,408408,1021020,1837836,2450448}
1295	810	3	1bb310986196b42b71794af41189879ccf20d183ed50da356ed8eeb20c954936	{1,1,1,2,5,14,42,1,1,2,5,14,42,132,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
1296	811	3	6829993d6db936d4d439bffb92f99a4b977e0ecdf597d363be4cc8e740b39043	{1,1,2,5,14,42,132,1,2,5,14,42,132,429,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
1310	868	6	2adda11b2be876f8c913f4228dfe090f122f66f5a34d34bdc7ffe4c9fbff9840	{1,3,6,10,15,21,28,1,4,10,20,35,56,84,3,15,45,105,210,378,630,12,72,252,672,1512,3024,5544,55,385,1540,4620,11550,25410,50820,273,2184,9828,32760,90090,216216,468468,1428,12852,64260,235620,706860,1837836,4288284}
1299	817	3	a9f309489413b2f38ca1dcbd311d1995066a3638364db7b96d072fb6a8e76fc0	{1,2,6,20,70,252,924,2,4,12,40,140,504,1848,3,6,18,60,210,756,2772,4,8,24,80,280,1008,3696,5,10,30,100,350,1260,4620,6,12,36,120,420,1512,5544,7,14,42,140,490,1764,6468}
1300	823	\N	743e9311aa93efc5a5382c9ad552db5ffeb312b2205d7f78d29e2596db463c4c	{1,0,0,0,0,0,0,2,2,6,24,110,546,2856,1,2,7,30,143,728,3876,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
1301	824	3	6afecc7840e84d9368961068ab6fa07c09098224c9800309e4b95d673d619c24	{1,0,0,0,0,0,0,2,2,6,24,110,546,2856,5,10,35,150,715,3640,19380,14,42,168,770,3822,19992,108528,42,168,756,3696,19110,102816,569772,132,660,3300,17160,92400,511632,2896740,429,2574,14157,78078,437580,2494206,14435421}
1302	825	3	960f334c07a07a6f8049a8db6f0ae82284ea985f95a35e1ab52150bbfa8fc094	{1,0,0,0,0,0,0,2,2,6,24,110,546,2856,3,6,21,90,429,2184,11628,4,12,48,220,1092,5712,31008,5,20,90,440,2275,12240,67830,6,30,150,780,4200,23256,131670,7,42,231,1274,7140,40698,235543}
1304	812	6	c3e54d1b4dd5497f2dd667cba681bee3c55d2052598ab94fcc7cc89b5d838a62	{0,1,0,0,0,0,0,1,1,0,0,0,0,0,1,3,0,0,0,0,0,3,12,0,0,0,0,0,12,55,0,0,0,0,0,55,273,0,0,0,0,0,273,1428,0,0,0,0,0}
1305	813	6	c89adaebcbaaac2b705d7d0702e9c2d97444d54512c182d93d88ed49ba0a9b77	{1,0,0,0,0,0,0,1,2,3,4,5,6,7,3,12,30,60,105,168,252,12,72,252,672,1512,3024,5544,55,440,1980,6600,18150,43560,94380,273,2730,15015,60060,195195,546546,1366365,1428,17136,111384,519792,1949220,6237504,17672928}
1306	814	6	53302aee6a091e29cf64b57976fe83349402ef0e04a420483926c7bd53cd17da	{1,0,0,0,0,0,0,1,2,1,0,0,0,0,3,12,18,12,3,0,0,12,72,180,240,180,72,12,55,440,1540,3080,3850,3080,1540,273,2730,12285,32760,57330,68796,57330,1428,17136,94248,314160,706860,1130976,1319472}
746	831	1	c7e6ed8cdc30fbccdcaf74dffbdea22ccaf12b2d475502e5369d21c7471b95ac	{1,3,6,10,15,21,28,1,4,10,20,35,56,84,1,5,15,35,70,126,210,1,6,21,56,126,252,462,1,7,28,84,210,462,924,1,8,36,120,330,792,1716,1,9,45,165,495,1287,3003}
1307	855	6	77729891fdbabaa58c5f0b6845af359b86e233b07ddb51248ed9c1b243fce15d	{1,1,0,0,0,0,0,1,2,1,0,0,0,0,3,9,9,3,0,0,0,12,48,72,48,12,0,0,55,275,550,550,275,55,0,273,1638,4095,5460,4095,1638,273,1428,9996,29988,49980,49980,29988,9996}
431	348	1	d03ad9c2a91ea45bbdef0bfb047fccadf5587359fa496b7f404b934e377f1752	{1,2,5,14,42,132,429,2,-4,-2,-4,-10,-28,-84,-3,18,-27,6,0,0,3,10,-100,350,-500,250,-20,0,-42,588,-3234,8820,-12348,8232,-2058,198,-3564,26730,-108108,254826,-352836,274428,-1001,22022,-209209,1123122,-3743740,8016008,-11022011}
462	382	1	2fb9c5f4a166bc53b29db1e945b0dcc732f784a2208125537457222ef36547b4	{1,1,0,0,0,0,0,1,-1,1,-1,1,-1,1,-2,6,-12,20,-30,42,-56,7,-35,105,-245,490,-882,1470,-30,210,-840,2520,-6300,13860,-27720,143,-1287,6435,-23595,70785,-184041,429429,-728,8008,-48048,208208,-728728,2186184,-5829824}
558	511	1	dc43859d4083260e58fc96f452ab88bf40c11ef5892297c13d890ef5f049e2d4	{1,1,0,0,0,0,0,1,0,0,0,0,0,0,2,-2,2,-2,2,-2,2,5,-10,15,-20,25,-30,35,14,-42,84,-140,210,-294,392,42,-168,420,-840,1470,-2352,3528,132,-660,1980,-4620,9240,-16632,27720}
631	611	1	4019bf38a9d6f3bd09e6130a006bb26001d59bc1ca91fb990a6bac6746ead3aa	{0,0,0,0,0,0,0,-4,None,None,None,None,None,None,-2,None,None,None,None,None,None,-1,None,None,None,None,None,None,-1,None,None,None,None,None,None,0,None,None,None,None,None,None,0,None,None,None,None,None,None}
599	564	1	ab73fbd31e4e2b1c19f304cf1173351df12b7b0e1f81c150bf1f96388c21e259	{1,2,3,4,5,6,7,1,10,55,220,715,2002,5005,2,36,342,2280,11970,52668,201894,5,130,1755,16380,118755,712530,3681405,14,476,8330,99960,924630,7027188,45676722,42,1764,37926,556248,6257790,57571668,450978066,132,6600,168300,2917200,38652900,417451320,3826637100}
25	1256	2	3fe6ea66ff86225d590af3644a69668229548811983e6ad196ba60738b64d652	{1,3,3,1,0,0,0,3,18,45,60,45,18,3,6,54,216,504,756,756,504,10,120,660,2200,4950,7920,9240,15,225,1575,6825,20475,45045,75075,21,378,3213,17136,64260,179928,389844,28,588,5880,37240,167580,569772,1519392}
778	867	1	8f9d7d1637da19d326cad1008f46426c2a71b1a8f348212cd217009954eb0253	{1,2,3,4,5,6,7,1,-3,3,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
1313	875	6	4e4ca6aa0c7999ea841ab5fd0d5d02ed03dad77bd0cf5ff974bc6fa988c33caa	{1,2,6,20,70,252,924,1,2,6,20,70,252,924,3,6,18,60,210,756,2772,12,24,72,240,840,3024,11088,55,110,330,1100,3850,13860,50820,273,546,1638,5460,19110,68796,252252,1428,2856,8568,28560,99960,359856,1319472}
781	879	1	1acc0f3eac2b1a1a9cc39f343775a413bc9756dabe7da8c9f516c40cf9f78953	{1,2,1,0,0,0,0,2,2,0,0,0,0,0,3,0,0,0,0,0,0,4,-4,4,-4,4,-4,4,5,-10,15,-20,25,-30,35,6,-18,36,-60,90,-126,168,7,-28,70,-140,245,-392,588}
1314	891	6	8e3cf506b3b239ff2ab72d1c2b34b929c913c2cd957bbf25adb1d44832901ee2	{1,1,1,1,1,1,1,2,4,6,8,10,12,14,7,21,42,70,105,147,196,30,120,300,600,1050,1680,2520,143,715,2145,5005,10010,18018,30030,728,4368,15288,40768,91728,183456,336336,3876,27132,108528,325584,813960,1790712,3581424}
1316	895	6	2835ebe235575471d7bd845c10da36bc3dad43e32fbcfe39827af1780e508295	{1,3,6,10,15,21,28,2,8,20,40,70,112,168,7,35,105,245,490,882,1470,30,180,630,1680,3780,7560,13860,143,1001,4004,12012,30030,66066,132132,728,5824,26208,87360,240240,576576,1249248,3876,34884,174420,639540,1918620,4988412,11639628}
1266	1345	1	6ec1d968c22e7be80fa0bdec5d88dcb0486d4bf0e9af7e044da040bdb9f9d44d	{1,4,6,4,1,0,0,1,12,66,220,495,792,924,3,60,570,3420,14535,46512,116280,12,336,4536,39312,245700,1179360,4520880,55,1980,34650,392700,3239775,20734560,107128560,273,12012,258258,3615612,37060023,296480184,1927121196,1428,74256,1893528,31558800,386595300,3711314880,29071966560}
694	724	1	a4b92998f609e58594b47a8abd85c2cd1a8feef5e210ff69769d3e20044f2d30	{1,4,6,4,1,0,0,2,14,42,70,70,42,14,5,50,225,600,1050,1260,1050,14,182,1092,4004,10010,18018,24024,42,672,5040,23520,76440,183456,336336,132,2508,22572,127908,511632,1534896,3581424,429,9438,99099,660660,3138135,11297286,32008977}
673	677	1	57c6b3d717388a8d3b0b027873d6a02586fc728bcd2ba8640a65a380ebe3a0de	{-1,-2,-6,-20,-70,-252,-924,1,4,16,64,256,1024,4096,-2,-12,-60,-280,-1260,-5544,-24024,5,40,240,1280,6400,30720,143360,-14,-140,-980,-5880,-32340,-168168,-840840,42,504,4032,26880,161280,903168,4816896,-132,-1848,-16632,-121968,-792792,-4756752,-26954928}
732	804	1	a477618ad2c2789c8d56c7b6f51927912d11f13a4886cb38229dabf80d326677	{1,0,0,0,0,0,0,2,2,2,2,2,2,2,5,10,15,20,25,30,35,14,42,84,140,210,294,392,42,168,420,840,1470,2352,3528,132,660,1980,4620,9240,16632,27720,429,2574,9009,24024,54054,108108,198198}
785	885	1	8b0592130a9b837e6feedadbf6bf183db097141c9e04f4b2daedfe61651c8d72	{1,1,0,0,0,0,0,2,4,2,0,0,0,0,3,9,9,3,0,0,0,4,16,24,16,4,0,0,5,25,50,50,25,5,0,6,36,90,120,90,36,6,7,49,147,245,245,147,49}
850	1138	3	fdb0da640837f33afb04ba1c71879d86918b349d8dcd9a66b86fafcb55ee18d3	{None,0,0,0,0,0,0,2,4,10,28,84,264,858,3,12,42,144,495,1716,6006,4,24,108,440,1716,6552,24752,5,40,220,1040,4550,19040,77520,6,60,390,2100,10200,46512,203490,7,84,630,3808,20349,100548,471086}
915	1228	3	03b4bcb421001cbd6a6947231c5098983eeaf8678c907a06b0d1c33bc34daaca	{1,6,27,110,429,1638,6188,2,24,180,1088,5814,28728,134596,1,18,189,1518,10350,63180,356265,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
980	1435	5	2087923eaf97723cc9619d5eb4eb3d5eb99bddc9c0bbc49056948feb83ddc73a	{1,2,1,0,0,0,0,2,6,6,2,0,0,0,3,12,18,12,3,0,0,4,20,40,40,20,4,0,5,30,75,100,75,30,5,6,42,126,210,210,126,42,7,56,196,392,490,392,196}
989	1444	5	e01b8fc54e3b131691d61cb8ff8f91b40632712f9e694aea3cf9f49fa07f14cf	{1,3,3,1,0,0,0,3,15,30,30,15,3,0,6,42,126,210,210,126,42,10,90,360,840,1260,1260,840,15,165,825,2475,4950,6930,6930,21,273,1638,6006,15015,27027,36036,28,420,2940,12740,38220,84084,140140}
1071	706	2	9929319e2e7ddd1886b2b51b2820922df34be0960c82b5aea39a41e0d4180318	{1,2,1,0,0,0,0,2,4,2,0,0,0,0,-2,-4,-2,0,0,0,0,4,8,4,0,0,0,0,-10,-20,-10,0,0,0,0,28,56,28,0,0,0,0,-84,-168,-84,0,0,0,0}
1122	700	3	3242b832aeec0b2ce3de1507753969786b98dc93c8912d96e6be775ce7829b61	{None,0,0,0,0,0,0,1,2,5,14,42,132,429,1,4,14,48,165,572,2002,1,6,27,110,429,1638,6188,1,8,44,208,910,3808,15504,1,10,65,350,1700,7752,33915,1,12,90,544,2907,14364,67298}
131	4	1	9fbc1f5e8256cacd805a5442d27439445487a78d728fd6cb16497cd240d69d30	{0,1,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
1225	750	1	560d2a8ef1f3b1c4a296b6948d3f27b8faeeca4f327968e12c6839fcdcd6cc32	{1,2,5,14,42,132,429,2,4,10,28,84,264,858,-3,-6,-15,-42,-126,-396,-1287,10,20,50,140,420,1320,4290,-42,-84,-210,-588,-1764,-5544,-18018,198,396,990,2772,8316,26136,84942,-1001,-2002,-5005,-14014,-42042,-132132,-429429}
1283	1199	2	1918d856e814bf7c424c985df31f672fd5576400caf27550bfeab50d6aa89b2f	{None,0,0,0,0,0,0,4,16,56,192,660,2288,8008,14,112,616,2912,12740,53312,217056,48,576,4320,26112,139536,689472,3230304,165,2640,25080,184800,1168860,6679200,35521200,572,11440,131560,1144000,8365500,54342288,323963640,2002,48048,648648,6502496,53993940,393224832,2599653056}
4	5	1	e22bf0a781dd13efb180e2cf030b495a8b2f0fbf5dccec524d1ff5f0f76d8f8f	{0,1,0,0,0,0,0,1,1,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0}
43	1277	2	8616d293739ca01d2d134fd490b04841bff330060747aded80c8dfc023440031	{1,4,14,48,165,572,2002,2,16,88,416,1820,7616,31008,5,60,450,2720,14535,71820,336490,14,224,2128,15680,99176,566720,3013920,42,840,9660,84000,614250,3990168,23787540,132,3168,42768,428736,3560040,25926912,171405696,429,12012,186186,2114112,19654635,158666508,1152665514}
58	1310	2	a2c54210617fa237ff2f92fee41895500283aaeeaea1735b3218333bdb4f93c9	{1,4,14,48,165,572,2002,4,32,176,832,3640,15232,62016,14,168,1260,7616,40698,201096,942172,48,768,7296,53760,340032,1943040,10333440,165,3300,37950,330000,2413125,15675660,93451050,572,13728,185328,1857856,15426840,112349952,742758016,2002,56056,868868,9865856,91721630,740443704,5379105732}
59	1311	2	1c0300e4dd37894fef2161073e569ce19b4b2c7ce2808272de5be0a1ee0f92ab	{1,6,27,110,429,1638,6188,4,48,360,2176,11628,57456,269192,14,252,2646,21252,144900,884520,4987710,48,1152,15552,155904,1294560,9427968,62329344,165,4950,81675,981750,9615375,81428490,618253350,572,20592,401544,5628480,63531468,613621008,5264478648,2002,84084,1891890,30298268,387290904,4202518320,40215765590}
68	1320	2	25c16c34acd606db3b709e13370a25e6fb0c6808d3a4300b3590dc704c5b5268	{1,3,9,28,90,297,1001,6,36,162,660,2574,9828,37128,27,243,1458,7371,34020,148716,627912,110,1320,9900,59840,319770,1580040,7402780,429,6435,57915,407550,2477475,13675662,70549050,1638,29484,309582,2486484,16953300,103488840,583562070,6188,129948,1559376,14077700,106427412,712244988,4361401408}
87	1347	2	8b2bb683c4f88acd023198523f54cbedb1b01d765467afa99a5b88140aa4ba16	{1,5,10,10,5,1,0,1,10,45,120,210,252,210,2,30,210,910,2730,6006,10010,5,100,950,5700,24225,77520,193800,14,350,4200,32200,177100,743820,2479400,42,1260,18270,170520,1151010,5985252,24938550,132,4620,78540,863940,6911520,42851424,214257120}
108	1030	6	c0a43eaffc6419ae61e222e6340c85250ce347602a5e9ae03bb6b77c6364f96a	{1,3,6,10,15,21,28,1,3,6,10,15,21,28,1,3,6,10,15,21,28,1,3,6,10,15,21,28,1,3,6,10,15,21,28,1,3,6,10,15,21,28,1,3,6,10,15,21,28}
115	1038	6	1239309354edb5f1e7bef6ca9da2594bed04b4953b6edb135fbb1194908fc8b5	{1,4,14,48,165,572,2002,2,8,28,96,330,1144,4004,3,12,42,144,495,1716,6006,4,16,56,192,660,2288,8008,5,20,70,240,825,2860,10010,6,24,84,288,990,3432,12012,7,28,98,336,1155,4004,14014}
126	1050	6	a1fd9abc7e2b1b6dc5965ffe80cffdab903051ca71a2d5abdb5217b9ca68d129	{1,4,14,48,165,572,2002,3,12,42,144,495,1716,6006,6,24,84,288,990,3432,12012,10,40,140,480,1650,5720,20020,15,60,210,720,2475,8580,30030,21,84,294,1008,3465,12012,42042,28,112,392,1344,4620,16016,56056}
138	13	1	9f7ee1153ca826ea505abc40a4394d27c743e6360764688ba302ab1e047c22ba	{1,1,2,5,14,42,132,1,3,10,35,126,462,1716,0,3,20,105,504,2310,10296,0,1,20,175,1176,6930,37752,0,0,10,175,1764,13860,94380,0,0,2,105,1764,19404,169884,0,0,0,35,1176,19404,226512}
161	36	1	8263bdbe32186a9ff3978bb1d4187b66e3b3bf41a782771769af6a4b128b4e62	{1,1,0,0,0,0,0,1,2,1,0,0,0,0,2,6,6,2,0,0,0,5,20,30,20,5,0,0,14,70,140,140,70,14,0,42,252,630,840,630,252,42,132,924,2772,4620,4620,2772,924}
181	56	1	df145cb6b4203e83295d8cd5790a6a61d901228b625ee935575f4026b8d40549	{1,1,1,1,1,1,1,2,2,2,2,2,2,2,3,3,3,3,3,3,3,4,4,4,4,4,4,4,5,5,5,5,5,5,5,6,6,6,6,6,6,6,7,7,7,7,7,7,7}
227	102	1	b09717db52daf6e7237fa8304911904a1740e5889c2f88bcc0fc98702e7e425f	{1,2,6,20,70,252,924,1,6,30,140,630,2772,12012,1,12,90,560,3150,16632,84084,1,20,210,1680,11550,72072,420420,1,30,420,4200,34650,252252,1681680,1,42,756,9240,90090,756756,5717712,1,56,1260,18480,210210,2018016,17153136}
247	122	1	272865a0888eb7d93e29435a14e8a0380b210e8832c4298ff3e083999cc2266d	{1,2,6,20,70,252,924,2,4,12,40,140,504,1848,6,12,36,120,420,1512,5544,20,40,120,400,1400,5040,18480,70,140,420,1400,4900,17640,64680,252,504,1512,5040,17640,63504,232848,924,1848,5544,18480,64680,232848,853776}
220	95	1	b0ad3ccee49ae858469b0f7469023ec61947cc7b8002df2c9a3906d846ba9fdc	{0,1,3,6,10,15,21,1,6,18,40,75,126,196,3,18,60,150,315,588,1008,6,40,150,420,980,2016,3780,10,75,315,980,2520,5670,11550,15,126,588,2016,5670,13860,30492,21,196,1008,3780,11550,30492,72072}
263	144	1	d0b91f8fdd64157021a2691a5766e9e6cd160590d4f7b5df45063b1c95856358	{1,1,2,5,14,42,132,1,2,6,20,70,252,924,-1,-1,0,10,70,378,1848,2,2,2,0,0,84,924,-5,-5,-6,-5,0,0,0,14,14,18,20,14,0,0,-42,-42,-55,-70,-70,-42,0}
282	163	1	9cce9b67d412b56036ce3977ee931a981d56420a550cfe5ab5b090170de76bb9	{1,1,1,1,1,1,1,0,3,6,9,12,15,18,0,6,21,45,78,120,171,0,10,56,165,364,680,1140,0,15,126,495,1365,3060,5985,0,21,252,1287,4368,11628,26334,0,28,462,3003,12376,38760,100947}
299	181	1	fa52a85b98c615b8f8db2cbefa6cd9c201d690a3bc3cf554d4616c7efe9ac50f	{-1,1,-2,5,-14,42,-132,2,-5,16,-55,196,-714,2640,-3,15,-72,330,-1470,6426,-27720,4,-35,240,-1430,7840,-40698,203280,-5,70,-660,5005,-33320,203490,-1168860,6,-126,1584,-15015,119952,-854658,5610528,-7,210,-3432,40040,-379848,3133746,-23377200}
361	250	1	46832c2aaa05842e22bec6e33f82d682a04730973d7ae6a4ef7f007222a9aab5	{1,1,1,1,1,1,1,0,0,0,0,0,0,0,1,2,3,4,5,6,7,0,0,0,0,0,0,0,1,3,6,10,15,21,28,0,0,0,0,0,0,0,1,4,10,20,35,56,84}
337	222	1	cbf3c7656ec34c6999d0318834297f333080756c5c7762a2b82215b2fe9e5343	{1,1,1,1,1,1,1,2,2,2,2,2,2,2,5,5,5,5,5,5,5,14,14,14,14,14,14,14,42,42,42,42,42,42,42,132,132,132,132,132,132,132,429,429,429,429,429,429,429}
339	224	1	a0758f40d93b37d8c578e15a5f6d81c23416108c8531e67053b9ad86de30d30d	{1,1,2,5,14,42,132,2,4,12,40,140,504,1848,5,14,54,220,910,3780,15708,14,48,220,1040,4900,22848,105336,42,165,858,4550,23800,122094,614460,132,572,3276,19040,108528,603288,3272808,429,2002,12376,77520,474810,2826516,16364040}
362	251	1	07dc9d3c5319c3a599c0ac0e4113fb45c12548f8fdbe5fa9dbcdef2784d86e43	{1,0,1,0,1,0,1,1,0,3,0,6,0,10,2,0,10,0,30,0,70,5,0,35,0,140,0,420,14,0,126,0,630,0,2310,42,0,462,0,2772,0,12012,132,0,1716,0,12012,0,60060}
382	275	1	d880c028d2e2bcc278b2be34a9c7482649a259465d27898fa8221c432f00501b	{0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
392	299	1	25d50f38db5cdec1f4f820f0dd30fc6714fc9b1dfbec127a904d6cc73ab33ee7	{1,2,1,0,0,0,0,1,5,10,10,5,1,0,2,16,56,112,140,112,56,5,55,275,825,1650,2310,2310,14,196,1274,5096,14014,28028,42042,42,714,5712,28560,99960,259896,519792,132,2640,25080,150480,639540,2046528,5116320}
420	337	1	3e312496f4a53cc7253ee68918ff340c17a357a793646d4eb0d235d2ccd29444	{1,1,1,1,1,1,1,2,0,0,0,0,0,0,1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
439	356	1	46ff4648bec1aeb86b0f80ad84be170fd4b86916418b07572bfd00aa0b0522e6	{0,0,0,0,0,0,0,-1,1,-1,1,-1,1,-1,1,-3,6,-10,15,-21,28,-2,10,-30,70,-140,252,-420,5,-35,140,-420,1050,-2310,4620,-14,126,-630,2310,-6930,18018,-42042,42,-462,2772,-12012,42042,-126126,336336}
510	444	1	2232ffeca7a14eb1f32039a62ca5b26df6e926e6e15f85ad737e680e4ef44a5d	{0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,-3,3,-1,0,0,0,-2,12,-30,40,-30,12,-2,5,-45,180,-420,630,-630,420,-14,168,-924,3080,-6930,11088,-12936,42,-630,4410,-19110,57330,-126126,210210}
490	418	1	ac8d2017ae4753a3f5cf6a4f1317922f491b89cab1335bc271e8071deca6f883	{1,2,3,4,5,6,7,1,4,10,20,35,56,84,2,12,42,112,252,504,924,5,40,180,600,1650,3960,8580,14,140,770,3080,10010,28028,70070,42,504,3276,15288,57330,183456,519792,132,1848,13860,73920,314160,1130976,3581424}
531	466	1	666627519532192eddf2b02a85454f1652d6c4dbcae242df22de14262b01675a	{1,1,-1,2,-5,14,-42,1,-3,9,-28,90,-297,1001,-2,14,-70,308,-1274,5096,-19992,7,-77,539,-3080,15708,-74613,337953,-30,450,-4050,28500,-173250,956340,-4933500,143,-2717,29887,-249964,1766050,-11126115,64531467,-728,16744,-217672,2109744,-16995160,120422848,-776519744}
570	524	1	c722713f1d1a116a4e6130ee3a3eda0506de4847c90ee5fee06f755a01a71efa	{1,2,3,4,5,6,7,1,0,0,0,0,0,0,2,-4,2,0,0,0,0,5,-20,30,-20,5,0,0,14,-84,210,-280,210,-84,14,42,-336,1176,-2352,2940,-2352,1176,132,-1320,5940,-15840,27720,-33264,27720}
547	500	1	398180648120b3381faf7a535720d39d4e7e1fb8d7459ffd14c0b9de23afa23d	{1,2,3,4,5,6,7,1,8,36,120,330,792,1716,2,28,210,1120,4760,17136,54264,5,100,1050,7700,44275,212520,885500,14,364,4914,45864,332514,1995084,10307934,42,1344,22176,251328,2199120,15833664,97640928,132,5016,97812,1304160,13367640,112288176,804731928}
566	520	1	aafcec63b716d3a7aafe68ec743fa7f9645578ba8a36cf503bcb545b5b27df97	{1,2,1,0,0,0,0,1,-6,21,-56,126,-252,462,-1,14,-105,560,-2380,8568,-27132,2,-44,506,-4048,25300,-131560,592020,-5,150,-2325,24800,-204600,1391280,-8115800,14,-532,10374,-138320,1417780,-11909352,85350356,-42,1932,-45402,726432,-8898792,88987920,-756397320}
602	568	1	6e5cca08333780f3d4a88864113b365b744c21e3f8f1344b65da6c59a8dc6aab	{1,1,2,5,14,42,132,1,4,14,48,165,572,2002,1,7,35,154,637,2548,9996,1,10,65,350,1700,7752,33915,1,13,104,663,3705,19019,92092,1,16,152,1120,7084,40480,215280,1,19,209,1748,12350,77805,451269}
603	569	1	8ebfd9808e643d10166817d44f68ff2bda70a39ad42c267e1a2bb80fce364fb8	{1,1,2,5,14,42,132,1,5,20,75,275,1001,3640,2,18,108,546,2520,11016,46512,5,65,520,3315,18525,95095,460460,14,238,2380,18326,120428,711620,3898440,42,882,10584,95550,722358,4834242,29602272,132,3300,46200,478500,4092000,30608160,207345600}
620	597	1	d8d5aa816f031cdec53ae7d1be677d7bc78415aa69abdab12795ca88e2cf3e19	{1,1,-1,2,-5,14,-42,1,-1,2,-5,14,-42,132,1,-3,9,-28,90,-297,1001,1,-5,20,-75,275,-1001,3640,1,-7,35,-154,637,-2548,9996,1,-9,54,-273,1260,-5508,23256,1,-11,77,-440,2244,-10659,48279}
646	641	1	dd1685faff16fa1b6e28a3a652bc79ad35f76d25ea06b3549e959560c291720e	{1,1,-1,2,-5,14,-42,1,3,0,1,-3,9,-28,2,10,10,0,0,2,-10,5,35,70,35,0,0,0,14,126,378,420,126,0,0,42,462,1848,3234,2310,462,0,132,1716,8580,20592,24024,12012,1716}
656	651	1	c3e5b880e7aa030a4434b82a0c0e9a73fba813a28fef0009c9a68f97ec8e8bfa	{1,None,None,None,None,None,None,1,1,1,1,1,1,1,1,-1,-1,-1,-1,-1,-1,1,2,2,2,2,2,2,1,-5,-5,-5,-5,-5,-5,1,14,14,14,14,14,14,1,-42,-42,-42,-42,-42,-42}
674	678	1	eaec93f1a80154910210b53b57016a2b68c27e5c79216417325ca8ce1557b225	{1,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None,None}
690	720	1	c8254ba3c008da37e223c3a1c0779085235b8f975d102c516fff68b6d13fceb8	{1,2,-2,4,-10,28,-84,1,6,6,None,6,-12,27,0,0,0,0,None,None,0,0,0,0,0,0,None,None,0,0,0,0,0,0,None,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
710	751	1	d17ce43f90fa36745ef78baadd856c48f45af1ddc0a4a93bcc4702c8f2db7322	{1,2,5,14,42,132,429,2,8,28,96,330,1144,4004,1,6,27,110,429,1638,6188,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
727	799	1	7dee7a3c50307a524e1532af5eaeda8f405e75d6c48c2be72771874484806705	{1,2,1,0,0,0,0,-2,-6,-6,-2,0,0,0,5,20,30,20,5,0,0,-14,-70,-140,-140,-70,-14,0,42,252,630,840,630,252,42,-132,-924,-2772,-4620,-4620,-2772,-924,429,3432,12012,24024,30030,24024,12012}
767	852	1	cb8462a3c862277af897983ab060b8341d9ae58f1abc3125d513eeafe7e16e7a	{1,2,3,4,5,6,7,2,2,2,2,2,2,2,-1,0,0,0,0,0,0,2,-2,0,0,0,0,0,-5,10,-5,0,0,0,0,14,-42,42,-14,0,0,0,-42,168,-252,168,-42,0,0}
803	911	1	4094241d39b2ec2093b8c48552ad7bb79e0a1c1714cedbc111a6b2d6b20f3332	{1,2,-8,56,-480,4576,-46592,1,-2,24,-280,3360,-41184,512512,0,2,-48,840,-13440,205920,-3075072,0,-2,80,-1960,40320,-755040,13325312,0,2,-120,3920,-100800,2265120,-46638592,0,-2,168,-7056,221760,-5889312,139915776,0,2,-224,11760,-443520,13741728,-373108736}
821	947	1	6ac1cc5b12a2b829a074c354358cde31cdbe7b016bc03ef29e49878288c27389	{0,1,0,0,0,0,0,1,3,0,0,0,0,0,3,3,0,0,0,0,0,3,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
827	973	1	c3ef87f64ee5914d2d2968627243a6edf99867e39da1d9abdc9b5de8bba482f9	{1,1,0,0,0,0,0,1,2,1,0,0,0,0,-2,-6,-6,-2,0,0,0,7,28,42,28,7,0,0,-30,-150,-300,-300,-150,-30,0,143,858,2145,2860,2145,858,143,-728,-5096,-15288,-25480,-25480,-15288,-5096}
841	996	1	4c8128daeb95feccaa73de87bbe42b137e90bd17c85951b8e81c9f50cad01ae7	{1,-2,-1,-2,-5,-14,-42,1,-1,-1,-2,-5,-14,-42,1,0,0,0,0,0,0,1,1,2,5,14,42,132,1,2,5,14,42,132,429,1,3,9,28,90,297,1001,1,4,14,48,165,572,2002}
796	904	1	e9efdf441527d37aeec4b0265576b8a49e4db8be9c507308941b4a0b0ab2cb5e	{3,2,-1,-2,-3,-4,-5,3,2,-1,-2,-3,-4,-5,1,0,-1,-2,-3,-4,-5,1,0,-1,-2,-3,-4,-5,1,0,-1,-2,-3,-4,-5,1,0,-1,-2,-3,-4,-5,1,0,-1,-2,-3,-4,-5}
858	1147	3	655bba61b1932629ef291553b4e5961cd979e6002cbcd43251c50e308b414014	{1,0,0,0,0,0,0,3,6,9,12,15,18,21,6,24,60,120,210,336,504,10,60,210,560,1260,2520,4620,15,120,540,1800,4950,11880,25740,21,210,1155,4620,15015,42042,105105,28,336,2184,10192,38220,122304,346528}
875	1167	3	6fd79c4e85b4df2e7953ebb6df7442c814fc28c9df076a09372fb6e9e891f3a9	{None,0,0,0,0,0,0,2,12,54,220,858,3276,12376,5,60,450,2720,14535,71820,336490,14,252,2646,21252,144900,884520,4987710,42,1008,13608,136416,1132740,8249472,54538176,132,3960,65340,785400,7692300,65142792,494602680,429,15444,301158,4221360,47648601,460215756,3948358986}
891	1194	3	a47774b3e60a80301297a1cdb036bd6ced12e117532b1405217c92931b8b85d8	{1,0,0,0,0,0,0,4,12,24,40,60,84,112,14,84,294,784,1764,3528,6468,48,432,2160,7920,23760,61776,144144,165,1980,12870,60060,225225,720720,2042040,572,8580,68640,388960,1750320,6651216,22170720,2002,36036,342342,2282280,11981970,52720668,202095894}
906	1212	3	63102347d030b1be4f681b436a27e19fdd9d1ebada2c8f12901fea72a3a73346	{None,0,0,0,0,0,0,6,36,162,660,2574,9828,37128,27,324,2430,14688,78489,387828,1817046,110,1980,20790,166980,1138500,6949800,39189150,429,10296,138996,1393392,11570130,84262464,557068512,1638,49140,810810,9746100,95454450,808362828,6137569620,6188,222768,4343976,60889920,687294972,6638263632,56952087192}
907	1213	3	1ae9e99cda8ddca926b771b444861353d7e2f1d351443bbd3bc62d260856c78b	{1,3,6,10,15,21,28,1,6,21,56,126,252,462,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
914	1227	3	32c7f340311dad2a81f27485d1740ee274958dda8be76f79bf46565481b7d51a	{1,4,14,48,165,572,2002,2,16,88,416,1820,7616,31008,1,12,90,544,2907,14364,67298,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
925	1240	3	4e07414d79eb5662c9878fbc54b6627393f239fad6bbc1636e6c082080a87f16	{1,6,27,110,429,1638,6188,3,36,270,1632,8721,43092,201894,3,54,567,4554,31050,189540,1068795,1,24,324,3248,26970,196416,1298528,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
944	1398	5	f561ff5beed5c6b79a87c5f525a37a59cf56867be9e5489a9df3de697de39e97	{1,1,0,0,0,0,0,2,3,0,0,0,0,0,1,3,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
963	1417	5	8589e07b99654bac8a79e40b74a49f4185795b950ddb7a1ddf03479eda736a9a	{1,1,1,1,1,1,1,3,4,5,6,7,8,9,6,10,15,21,28,36,45,10,20,35,56,84,120,165,15,35,70,126,210,330,495,21,56,126,252,462,792,1287,28,84,210,462,924,1716,3003}
966	1420	5	dffd9ca7da255fa137357df270d20ef5e6bc13564b2078e7fd3712fb098afc6e	{1,1,1,1,1,1,1,3,6,9,12,15,18,21,6,21,45,78,120,171,231,10,56,165,364,680,1140,1771,15,126,495,1365,3060,5985,10626,21,252,1287,4368,11628,26334,53130,28,462,3003,12376,38760,100947,230230}
982	1437	5	50b97835b7014afc1a4aaf690df6cce687ec6179749281f8a55f38593717487a	{1,3,3,1,0,0,0,2,10,20,20,10,2,0,3,21,63,105,105,63,21,4,36,144,336,504,504,336,5,55,275,825,1650,2310,2310,6,78,468,1716,4290,7722,10296,7,105,735,3185,9555,21021,35035}
1000	1455	5	7a3a7607c213105e57cefc5d5181ec81847a6a47edc4d9cea456d390999e0445	{1,3,6,10,15,21,28,2,8,20,40,70,112,168,5,25,75,175,350,630,1050,14,84,294,784,1764,3528,6468,42,294,1176,3528,8820,19404,38808,132,1056,4752,15840,43560,104544,226512,429,3861,19305,70785,212355,552123,1288287}
1001	1456	5	8c978161f450cf949cde920812074728de16875e970446816a9ac8cfc8b6394f	{1,2,3,4,5,6,7,2,8,20,40,70,112,168,5,30,105,280,630,1260,2310,14,112,504,1680,4620,11088,24024,42,420,2310,9240,30030,84084,210210,132,1584,10296,48048,180180,576576,1633632,429,6006,45045,240240,1021020,3675672,11639628}
1017	1064	6	36d9991577d7489174987dfaf8fc408de0f2df3fb2c40ec2e5a371c444aae21b	{1,3,3,1,0,0,0,3,9,9,3,0,0,0,9,27,27,9,0,0,0,28,84,84,28,0,0,0,90,270,270,90,0,0,0,297,891,891,297,0,0,0,1001,3003,3003,1001,0,0,0}
1035	1089	6	7738dcefee09dca6564c1a67931c051b22d340688616e60e591b11224baaa52e	{1,6,27,110,429,1638,6188,4,24,108,440,1716,6552,24752,14,84,378,1540,6006,22932,86632,48,288,1296,5280,20592,78624,297024,165,990,4455,18150,70785,270270,1021020,572,3432,15444,62920,245388,936936,3539536,2002,12012,54054,220220,858858,3279276,12388376}
1052	1107	6	584bae74703889864f9def5ecdd4b34660016771321d13d1cc1d5f442a55d230	{1,0,0,0,0,0,0,2,4,2,0,0,0,0,1,4,6,4,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
1055	1110	6	4bb0ef08533044eb65077ebce6748cae0137194411a6263dd5e8749072597a66	{1,0,0,0,0,0,0,2,4,6,8,10,12,14,1,4,10,20,35,56,84,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
1072	1026	6	8db47527e60ea2243530a86a0160fa1001010999563f4fc16cbc024149af6ea0	{1,2,1,0,0,0,0,None,None,None,None,None,None,None,-2,-16,-56,-112,-140,-112,-56,4,44,220,660,1320,1848,1848,-10,-140,-910,-3640,-10010,-20020,-30030,28,476,3808,19040,66640,173264,346528,-84,-1680,-15960,-95760,-406980,-1302336,-3255840}
1099	534	3	6ec0db19458d16057b1fb23efbcebfa4f7deae6dbb18c59277b7b58c62d07c0c	{1,1,2,5,14,42,132,1,1,2,5,14,42,132,3,3,6,15,42,126,396,12,12,24,60,168,504,1584,55,55,110,275,770,2310,7260,273,273,546,1365,3822,11466,36036,1428,1428,2856,7140,19992,59976,188496}
1087	221	6	eb85335623abc4934a125644252202420b6252b1bfe7eb71c2da2f4753337ded	{1,1,2,5,14,42,132,2,6,20,70,252,924,3432,5,27,130,595,2646,11550,49764,14,110,700,3990,21252,108108,531960,42,429,3400,23275,144900,844074,4681248,132,1638,15504,123970,884520,5814732,35939904,429,6188,67830,619850,4987710,36549744,249333084}
1115	653	3	42396ad2c314fe890cc74eb4b436ca18ffffe48a902bfe721f079309196c869d	{1,1,3,12,55,273,1428,1,2,7,30,143,728,3876,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
1146	999	5	410a037f11fe697f28fe5dc674e261613f4a71339a52e3fc1e0aded8ace540d4	{1,-2,1,0,0,0,0,1,-1,0,0,0,0,0,1,0,0,0,0,0,0,1,1,1,1,1,1,1,1,2,3,4,5,6,7,1,3,6,10,15,21,28,1,4,10,20,35,56,84}
1172	305	6	11b75b7e17f51d6dc430d743e67d424e75cee66da49af07634e46ce9dd7ddb0a	{1,1,3,12,55,273,1428,1,1,3,12,55,273,1428,2,2,6,24,110,546,2856,5,5,15,60,275,1365,7140,14,14,42,168,770,3822,19992,42,42,126,504,2310,11466,59976,132,132,396,1584,7260,36036,188496}
1129	877	5	3e5c703da9453abcc63386405bb1965778e5b340cffeca6f973b801f4e8bd5b1	{1,1,0,0,0,0,0,2,4,2,0,0,0,0,7,21,21,7,0,0,0,30,120,180,120,30,0,0,143,715,1430,1430,715,143,0,728,4368,10920,14560,10920,4368,728,3876,27132,81396,135660,135660,81396,27132}
164	39	1	9f454d7ab8bd085975fac25c16a7a54e992b4d8b1e0ab44e9947e32b87e7dd17	{1,0,0,0,0,0,0,1,1,0,0,0,0,0,2,4,2,0,0,0,0,5,15,15,5,0,0,0,14,56,84,56,14,0,0,42,210,420,420,210,42,0,132,792,1980,2640,1980,792,132}
1191	292	6	acf9759271424588217e61df3f6f7626dd03f203676f80bbf7097f36a006ac51	{1,1,0,0,0,0,0,1,0,0,None,0,0,0,3,0,0,0,0,None,0,12,0,0,0,0,0,0,55,0,0,0,0,0,0,273,0,0,0,0,0,0,1428,0,0,0,0,0,0}
1175	387	6	c444db030c348a7c0a6e4df4a4e42ff05ac854f2dc236fb9faec04ded4c12347	{1,2,5,14,42,132,429,1,4,15,56,210,792,3003,0,2,15,84,420,1980,9009,0,0,5,56,420,2640,15015,0,0,0,14,210,1980,15015,0,0,0,0,42,792,9009,0,0,0,0,0,132,3003}
1180	423	6	560d2a8ef1f3b1c4a296b6948d3f27b8faeeca4f327968e12c6839fcdcd6cc32	{1,2,6,20,70,252,924,1,-4,0,0,0,0,0,-2,20,-60,40,20,24,40,7,-112,672,-1792,1792,0,0,-30,660,-5940,27720,-69300,83160,-27720,143,-4004,48048,-320320,1281280,-3075072,4100096,-728,24752,-371280,3217760,-17697680,63711648,-148660512}
1235	766	1	607bde06cab8747c743839c2a7afe0fc5c8c42889ab7b4050f773154e99396d8	{1,1,3,12,55,273,1428,3,6,21,90,429,2184,11628,9,27,108,495,2457,12852,69768,28,112,504,2464,12740,68544,379848,90,450,2250,11700,63000,348840,1975050,297,1782,9801,54054,302940,1726758,9993753,1001,7007,42042,245245,1429428,8387379,49637588}
1254	795	1	560d2a8ef1f3b1c4a296b6948d3f27b8faeeca4f327968e12c6839fcdcd6cc32	{1,0,0,0,0,0,0,2,2,0,0,0,0,0,7,14,7,0,0,0,0,30,90,90,30,0,0,0,143,572,858,572,143,0,0,728,3640,7280,7280,3640,728,0,3876,23256,58140,77520,58140,23256,3876}
1256	797	1	e0fcd55c89da717bcb12b648fbecabdca7379e75b31e39c0d17d6fe884f4debb	{1,0,0,0,0,0,0,2,2,2,2,2,2,2,7,14,21,28,35,42,49,30,90,180,300,450,630,840,143,572,1430,2860,5005,8008,12012,728,3640,10920,25480,50960,91728,152880,3876,23256,81396,217056,488376,976752,1790712}
1271	1358	2	244c9fe5672e0d018afa3ff05630e98d93bad05f126ddfd8314b764a8f2c2d0e	{1,2,5,14,42,132,429,1,6,27,110,429,1638,6188,3,30,195,1050,5100,23256,101745,12,168,1428,9576,55860,297528,1487640,55,990,10395,83490,569250,3474900,19594575,273,6006,75075,702702,5486481,37795758,237573336,1428,37128,538356,5754840,50642592,388804416,2697330636}
1292	1472	2	5ad111bbfe68f01a5266fd7ac0cd64451cfadd9a6c23ee7a004b64208e20fe14	{1,2,3,4,5,6,7,1,4,10,20,35,56,84,3,18,63,168,378,756,1386,12,96,432,1440,3960,9504,20592,55,550,3025,12100,39325,110110,275275,273,3276,21294,99372,372645,1192464,3378648,1428,19992,149940,799680,3398640,12235104,38744496}
1308	859	6	4e71315a8b69fdce1fa538b434885f399f4ab4ab1594d43b2a62cf48fd53ad62	{1,2,1,0,0,0,0,1,3,3,1,0,0,0,3,12,18,12,3,0,0,12,60,120,120,60,12,0,55,330,825,1100,825,330,55,273,1911,5733,9555,9555,5733,1911,1428,11424,39984,79968,99960,79968,39984}
1312	874	6	9fef1a50cc9524f2f2d3cac497babaf46db0e7d4eca4864e671d2e5fa5289d81	{1,2,6,20,70,252,924,1,2,6,20,70,252,924,3,6,18,60,210,756,2772,12,24,72,240,840,3024,11088,55,110,330,1100,3850,13860,50820,273,546,1638,5460,19110,68796,252252,1428,2856,8568,28560,99960,359856,1319472}
477	401	1	3b5186bc5b4b26fb7eff23b12c040d8b973889a51eed9ef640f3b21504cd3c2b	{0,0,0,0,0,0,0,1,-1,-1,-2,-5,-14,-42,-2,6,0,2,6,18,56,7,-35,35,0,0,-7,-35,-30,210,-420,210,0,0,0,143,-1287,3861,-4290,1287,0,0,-728,8008,-32032,56056,-40040,8008,0}
\.


--
-- Data for Name: relations; Type: TABLE DATA; Schema: public; Owner: prog
--

COPY public.relations (linked_pyramid_id, relatedto_pyramid_id, tag) FROM stdin;
202	201	Left on y
360	362	Right on x
782	781	Right on x
1130	783	Left on x
783	1130	Right on x
783	784	Left on x
785	1131	Right on x
785	786	Left on x
786	785	Right on x
1132	507	Left on x
1133	787	Left on x
787	1133	Right on x
787	788	Left on x
788	787	Right on x
1314	181	Left on x
1315	789	Left on x
493	1180	Left on x
199	255	Reversion on x
700	698	\N
698	700	\N
698	1085	\N
702	701	\N
1089	703	\N
493	370	Right on x
2	3	Change x y
3	2	Change x y
4	5	Change x y
5	4	Change x y
132	133	Change x y
199	1129	Right on x
133	132	Change x y
141	795	Reciprocal
453	452	Right on x
199	201	Right on y
141	1101	Right on x
453	492	Left on x
141	137	Left on x
453	454	Change x y
141	138	Change x y
135	140	Reciprocal
135	260	Reversion on y
135	137	Right on x
135	136	Right on y
136	374	Reciprocal
136	140	Reversion on y
136	139	Right on x
136	138	Right on y
136	135	Left on x
136	137	Change x y
137	261	Reciprocal
137	141	Right on x
137	139	Right on y
137	135	Left on x
137	136	Change x y
138	374	Reversion on y
138	141	Change x y
139	261	Reversion on y
139	136	Left on x
535	41	Reciprocal
140	135	Reciprocal
140	136	Reversion on y
140	259	Right on x
140	260	Right on y
140	261	Left on x
536	534	Right on x
536	537	Left on x
142	302	Reciprocal
142	303	Reversion on y
142	144	Right on x
142	143	Right on y
142	463	Left on x
142	160	Change x y
143	302	Reversion on y
143	146	Right on x
143	161	Change x y
144	300	Reciprocal
144	301	Reversion on y
144	147	Right on x
144	146	Right on y
144	142	Left on x
145	146	Left on x
146	300	Reversion on y
146	145	Right on x
146	143	Left on x
146	147	Change x y
148	408	Reciprocal
148	410	Reversion on y
148	150	Right on x
148	149	Right on y
226	229	Change x y
149	408	Reversion on y
149	151	Right on y
149	148	Left on y
1122	1121	Right on x
226	227	Change x y
1122	679	Left on x
1123	1120	Right on x
150	409	Reciprocal
150	408	Reversion on x
150	148	Left on x
151	149	Left on y
152	1155	Left on x
152	1156	Left on y
227	228	Left on y
491	511	Change x y
492	453	Right on x
1158	1161	Right on x
491	489	Right on x
1158	1157	Change x y
477	475	Right on x
227	226	Change x y
153	155	Right on x
153	162	Left on y
316	317	Right on y
228	227	Right on y
154	153	Left on y
317	1145	Change x y
158	157	Left on y
237	235	Left on x
237	236	Change x y
321	516	Left on x
321	402	Change x y
238	239	Right on x
229	244	Right on x
229	228	Change x y
238	664	Right on x
159	305	Reversion on x
159	160	Right on x
159	165	Left on x
322	321	Right on y
322	403	Change x y
239	237	Right on y
239	233	Change x y
160	303	Reversion on x
160	144	Right on y
160	142	Change x y
1181	233	Reciprocal
202	196	Change x y
255	199	Reversion on x
248	1081	Right on x
161	301	Reversion on x
165	159	Right on x
165	166	Change x y
165	448	Left on x
249	248	Left on x
242	245	Right on x
323	404	Change x y
203	205	Right on y
180	181	Right on y
324	325	Right on y
162	153	Right on y
162	943	Change x y
243	242	Change x y
325	324	Left on y
244	229	Right on x
244	242	Left on y
163	155	Right on y
245	229	Right on y
180	452	Change x y
256	505	Reversion on y
257	258	Right on y
1081	248	Left on x
166	159	Right on y
166	165	Change x y
167	392	Reversion on x
168	170	Right on y
168	377	Left on x
169	171	Right on y
169	168	Left on y
170	172	Right on x
170	176	Change x y
171	176	Left on x
171	172	Change x y
265	264	Left on x
172	169	Left on x
173	177	Left on y
174	544	Change x y
175	176	Right on y
175	377	Left on y
176	175	Left on y
177	178	Left on y
178	179	Right on x
178	485	Left on x
258	184	Left on x
179	263	Change x y
258	442	Change x y
183	184	Left on x
259	140	Left on x
260	135	Reversion on y
260	259	Change x y
266	267	Left on x
184	186	Right on y
261	795	Left on x
261	141	Reversion on x
261	140	Right on x
331	332	Right on x
331	370	Left on x
262	263	Right on y
263	262	Left on y
264	265	Right on x
264	285	Change x y
184	440	Change x y
185	258	Right on y
185	183	Left on x
181	511	Left on x
181	489	Change x y
326	325	Left on y
182	490	Change x y
267	268	Right on y
267	276	Left on x
185	444	Change x y
270	266	Left on x
186	257	Right on x
186	184	Left on y
186	441	Change x y
187	456	Left on x
187	190	Change x y
188	189	Right on y
188	518	Left on x
188	187	Left on y
188	191	Change x y
189	188	Left on y
189	192	Change x y
190	191	Right on x
190	475	Left on x
190	187	Change x y
191	192	Right on x
191	190	Left on x
191	188	Change x y
192	191	Left on x
192	189	Change x y
193	1125	Right on x
193	194	Right on y
193	397	Left on x
153	154	Right on y
316	319	Right on x
228	229	Change x y
317	316	Left on y
158	599	Change x y
237	239	Left on y
321	322	Left on y
238	235	Right on y
238	232	Change x y
159	303	Reciprocal
229	226	Right on x
229	245	Left on y
231	241	Change x y
155	153	Left on x
155	163	Left on y
232	234	Right on x
232	233	Right on y
232	936	Left on y
232	238	Change x y
319	316	Left on x
233	1181	Reciprocal
233	236	Right on x
233	232	Left on y
233	239	Change x y
234	236	Right on y
234	232	Left on x
234	235	Change x y
156	157	Right on y
156	597	Change x y
235	237	Right on x
235	238	Left on y
235	234	Change x y
159	304	Reversion on y
159	142	Right on y
159	166	Left on y
157	158	Right on y
157	156	Left on y
157	598	Change x y
322	323	Left on y
239	238	Left on x
160	301	Reciprocal
160	161	Right on x
236	1181	Reversion on x
236	233	Left on x
236	234	Left on y
236	237	Change x y
160	159	Left on x
1181	236	Reversion on x
203	206	Right on x
175	449	Left on x
161	143	Change x y
241	231	Change x y
175	168	Change x y
248	249	Right on y
242	244	Right on y
242	243	Change x y
323	322	Right on y
324	697	Change x y
162	163	Right on x
162	660	Left on x
325	326	Right on y
325	167	Change x y
244	246	Right on y
163	164	Right on x
163	162	Left on x
245	242	Left on x
165	306	Reversion on y
165	305	Reciprocal
246	244	Left on y
176	171	Right on x
165	463	Right on y
176	170	Change x y
177	173	Right on y
177	542	Change x y
166	304	Reciprocal
166	306	Reversion on x
168	169	Right on y
168	175	Change x y
169	172	Right on x
169	175	Left on x
170	168	Left on x
171	169	Left on y
178	177	Right on y
172	170	Left on y
172	171	Change x y
173	174	Right on y
173	543	Change x y
174	173	Left on y
175	169	Right on x
178	262	Change x y
257	186	Left on x
261	139	Reversion on y
179	178	Left on x
255	505	Reciprocal
255	256	Right on x
180	454	Left on y
256	200	Reversion on x
256	255	Left on y
259	135	Reversion on x
259	260	Change x y
258	257	Right on x
258	185	Left on y
260	140	Left on y
261	374	Change x y
261	137	Reciprocal
331	372	Change x y
262	178	Change x y
262	542	Right on x
263	179	Change x y
264	208	Right on x
265	538	Right on x
265	286	Change x y
266	270	Right on x
266	271	Left on y
181	180	Left on y
181	182	Right on y
326	392	Change x y
267	266	Right on x
182	181	Left on y
267	946	Change x y
268	267	Left on y
183	185	Right on y
183	443	Change x y
184	258	Right on x
184	183	Left on y
193	308	Change x y
194	309	Change x y
195	197	Left on x
196	195	Left on x
197	195	Right on x
197	199	Change x y
203	204	Left on y
360	361	Change x y
361	363	Right on x
362	360	Left on x
363	361	Left on y
1188	367	Left on x
1188	310	Change x y
367	1188	Right on x
367	397	Right on y
1157	1159	Right on y
368	369	Right on x
369	337	Change x y
370	493	Left on x
372	373	Right on y
372	371	Left on y
205	207	Right on y
205	467	Change x y
206	1175	Change x y
207	205	Left on y
208	264	Right on x
208	288	Change x y
209	210	Right on y
209	649	Change x y
211	633	Left on x
212	213	Right on y
212	1177	Change x y
373	372	Left on y
213	212	Left on y
223	767	Left on x
224	225	Change x y
334	457	Left on x
335	422	Left on x
336	423	Left on x
336	478	Change x y
1087	1179	Change x y
374	136	Reciprocal
337	420	Left on x
337	338	Left on y
374	138	Reversion on y
374	261	Change x y
210	205	Left on y
375	393	Left on x
376	387	Left on y
338	368	Change x y
1155	152	Right on x
339	337	Left on y
350	736	Change x y
355	357	Left on x
358	359	Change x y
1155	1156	Change x y
1156	378	Left on x
378	1156	Right on x
1157	558	Left on x
210	468	Change x y
199	505	Left on x
1159	1161	Change x y
393	386	Left on y
380	379	Change x y
384	383	Change x y
385	388	Right on y
385	386	Change x y
386	393	Right on y
386	385	Change x y
387	385	Left on x
388	376	Right on x
388	391	Change x y
389	390	Change x y
390	386	Right on x
390	389	Change x y
1160	1159	Left on y
1160	1162	Change x y
1162	1161	Left on x
1162	1160	Change x y
1161	1162	Right on x
1161	1158	Left on x
1161	1159	Change x y
1191	1191	Right on y
393	387	Change x y
1171	1174	Right on x
1174	1172	Right on x
1163	1164	Right on y
1166	1164	Left on y
1166	1167	Change x y
392	167	Left on x
392	326	Change x y
393	375	Right on x
393	693	Left on x
1174	1171	Left on x
394	395	Left on x
395	394	Right on x
395	396	Left on x
277	280	Left on y
272	273	Right on x
272	275	Left on x
272	949	Change x y
277	278	Right on y
277	669	Change x y
278	279	Right on y
278	277	Left on y
278	685	Change x y
284	281	Right on y
285	289	Right on x
285	286	Right on y
285	288	Left on y
285	264	Change x y
286	287	Right on y
286	285	Left on y
286	265	Change x y
288	649	Right on x
288	285	Right on y
288	482	Left on x
288	208	Change x y
289	285	Left on x
289	649	Left on y
290	291	Right on y
290	298	Left on x
290	292	Left on y
290	745	Change x y
194	193	Left on y
195	196	Right on x
195	201	Change x y
196	202	Change x y
197	198	Left on x
203	466	Change x y
361	360	Change x y
362	363	Change x y
363	362	Change x y
198	197	Right on x
198	200	Change x y
366	365	Change x y
1188	193	Right on y
1188	1154	Left on y
199	200	Left on y
199	197	Change x y
784	783	Right on x
1131	785	Left on x
200	256	Reversion on x
200	199	Right on y
200	198	Change x y
201	202	Right on y
201	199	Left on y
201	195	Change x y
367	495	Change x y
369	368	Left on x
370	331	Right on x
370	371	Change x y
372	636	Left on x
372	331	Change x y
373	332	Change x y
374	139	Reversion on x
205	203	Left on y
206	203	Left on x
207	468	Change x y
208	209	Right on y
209	208	Left on y
211	212	Right on y
211	1176	Change x y
212	211	Left on y
374	140	Right on y
213	472	Change x y
225	224	Change x y
335	336	Right on y
335	1178	Change x y
336	1087	Right on y
336	335	Left on y
1087	336	Left on x
1159	1157	Left on y
478	1179	Right on x
337	339	Right on y
337	369	Change x y
375	391	Left on y
338	337	Right on y
375	376	Change x y
339	421	Left on x
356	1090	Change x y
357	355	Right on x
376	388	Left on x
359	358	Change x y
376	375	Change x y
377	168	Right on x
1155	378	Left on y
1156	152	Right on y
1156	1155	Change x y
378	1155	Right on y
478	1178	Left on x
379	380	Change x y
383	384	Change x y
385	387	Right on x
385	389	Left on y
386	391	Right on x
386	390	Left on x
387	376	Right on y
387	393	Change x y
388	385	Left on y
478	336	Change x y
389	385	Right on y
390	693	Right on y
482	288	Right on x
391	375	Right on y
482	484	Left on x
1159	1160	Right on y
391	386	Left on x
1189	1157	Right on x
1189	1190	Change x y
391	388	Change x y
1190	1158	Right on x
1164	1166	Right on y
1164	568	Left on x
1164	1191	Left on y
1164	1165	Change x y
1165	1167	Right on x
1165	1163	Left on x
1165	313	Left on y
1165	1164	Change x y
1167	1165	Left on x
1167	1166	Change x y
1169	575	Left on x
1169	1170	Change x y
396	395	Right on x
1172	1174	Left on x
1172	1099	Change x y
271	266	Right on y
273	274	Right on x
273	272	Left on x
274	1098	Right on x
274	273	Left on x
275	272	Right on x
276	267	Right on x
279	278	Left on x
279	686	Change x y
280	277	Right on y
280	670	Change x y
281	282	Right on y
281	284	Left on y
281	1047	Change x y
282	283	Right on y
282	281	Left on y
282	19	Change x y
283	282	Left on y
283	865	Change x y
287	286	Left on y
287	538	Change x y
291	290	Left on y
291	998	Change x y
22	534	Change x y
789	1315	Right on x
97	17	Change x y
293	294	Right on y
293	296	Left on y
293	589	Change x y
294	295	Right on y
294	293	Left on y
294	590	Change x y
451	449	Right on x
452	489	Right on x
295	294	Left on y
295	591	Change x y
452	453	Left on x
452	180	Change x y
789	790	Left on x
1263	1262	Right on x
99	107	Change x y
790	789	Right on x
1086	310	Right on x
1086	497	Left on x
1086	1154	Change x y
1123	673	Left on x
1124	779	Right on x
1124	676	Left on x
100	112	Change x y
101	119	Change x y
489	490	Right on x
1209	259	Reciprocal
1209	135	Right on x
1209	462	Left on x
463	305	Reversion on y
463	142	Right on x
463	465	Left on x
463	165	Left on y
467	205	Change x y
468	467	Left on x
468	207	Change x y
489	452	Left on x
489	491	Left on y
489	181	Change x y
471	469	Right on x
204	469	Change x y
204	203	Right on y
1193	1191	Right on y
556	557	Right on x
556	555	Left on x
1214	338	Right on x
557	556	Left on x
381	382	Change x y
382	381	Change x y
558	1157	Right on x
558	559	Left on x
623	1258	Right on x
623	624	Left on x
624	623	Right on x
624	625	Left on x
559	558	Right on x
559	560	Left on x
560	559	Right on x
560	561	Left on x
561	560	Right on x
1097	563	Left on x
1109	1112	Left on x
1109	1114	Change x y
1112	1109	Right on x
1112	628	Left on x
1097	1094	Change x y
563	1097	Right on x
563	564	Left on x
564	564	Right on x
564	566	Left on x
102	128	Change x y
565	564	Right on x
565	566	Left on x
729	1256	Right on x
729	730	Left on x
22	41	Right on x
103	1011	Change x y
104	1017	Change x y
105	1027	Change x y
106	1038	Change x y
107	82	Right on x
107	81	Left on x
107	99	Change x y
110	37	Right on x
110	1028	Change x y
111	38	Right on x
111	1039	Change x y
112	100	Change x y
113	432	Change x y
114	1019	Change x y
1078	1071	Left on x
121	513	Change x y
1035	1045	Change x y
1036	14	Change x y
1037	95	Change x y
1038	106	Change x y
1039	111	Change x y
1040	116	Change x y
1041	127	Change x y
1042	1010	Change x y
1043	1014	Change x y
1044	1024	Change x y
1045	1035	Change x y
1052	869	Right on x
1053	870	Right on x
1054	732	Right on x
1055	733	Right on x
1056	871	Right on x
19	865	Right on x
19	1047	Left on x
19	282	Change x y
843	866	Right on x
843	1048	Left on x
844	867	Right on x
844	1049	Left on x
845	868	Right on x
845	1050	Left on x
72	71	Left on x
1316	791	Left on x
307	397	Change x y
308	309	Right on x
791	1316	Right on x
791	792	Left on x
308	310	Left on x
308	307	Left on y
297	292	Right on x
297	298	Right on y
793	1136	Right on x
308	193	Change x y
298	290	Right on x
298	297	Left on y
309	194	Change x y
292	290	Right on y
292	297	Left on x
292	74	Change x y
1084	299	Right on y
299	1084	Left on y
300	144	Reciprocal
300	147	Reversion on x
300	146	Reversion on y
300	302	Right on x
300	301	Right on y
404	323	Change x y
310	308	Right on x
301	160	Reciprocal
301	161	Reversion on x
302	142	Reciprocal
302	144	Reversion on x
302	143	Reversion on y
302	303	Right on y
302	300	Left on x
302	301	Change x y
310	1086	Left on x
301	144	Reversion on y
310	495	Left on y
301	303	Right on x
310	1188	Change x y
301	302	Left on x
303	159	Reciprocal
303	160	Reversion on x
303	142	Reversion on y
303	305	Right on x
303	304	Right on y
303	301	Left on x
303	302	Left on y
304	166	Reciprocal
304	159	Reversion on y
304	306	Right on x
304	303	Left on y
304	305	Change x y
305	165	Reciprocal
305	159	Reversion on x
305	463	Reversion on y
305	306	Right on y
305	303	Left on x
305	304	Change x y
307	308	Right on y
307	495	Left on x
405	404	Right on x
312	313	Right on y
312	314	Left on y
312	569	Change x y
313	1165	Right on y
313	312	Left on y
313	568	Change x y
314	312	Right on y
314	572	Change x y
1192	396	Right on x
397	193	Right on x
397	398	Left on x
397	367	Left on y
397	307	Change x y
398	397	Right on x
398	528	Left on x
399	1134	Right on x
399	400	Left on x
400	399	Right on x
402	321	Change x y
403	402	Right on x
403	404	Left on x
403	322	Change x y
404	403	Right on x
404	405	Left on x
405	532	Left on x
408	148	Reciprocal
408	150	Reversion on x
408	149	Reversion on y
408	410	Right on y
408	409	Left on x
409	150	Reciprocal
409	408	Right on x
410	148	Reciprocal
410	408	Reciprocal
415	416	Left on x
415	553	Change x y
416	415	Right on x
416	417	Left on x
417	416	Right on x
417	418	Left on x
418	417	Right on x
418	533	Left on x
420	337	Right on x
420	421	Right on y
420	427	Left on x
421	339	Right on x
421	420	Left on y
422	335	Right on x
422	423	Right on y
422	426	Left on x
423	336	Right on x
423	422	Left on y
424	425	Left on x
424	129	Change x y
425	424	Right on x
425	428	Left on x
426	422	Right on x
427	420	Right on x
429	430	Left on x
430	429	Right on x
430	431	Left on x
431	430	Right on x
432	433	Left on x
432	113	Change x y
433	432	Right on x
433	434	Left on x
701	702	Reciprocal
434	433	Right on x
435	436	Left on x
435	124	Change x y
436	435	Right on x
455	1095	Right on x
455	523	Left on x
455	21	Change x y
456	187	Right on x
456	518	Right on y
456	519	Left on x
457	334	Right on x
457	458	Left on x
630	629	Right on x
108	75	Left on x
792	791	Right on x
458	457	Right on x
549	550	Right on x
549	548	Change x y
1197	458	Right on x
1197	460	Left on x
1134	399	Left on x
550	549	Left on x
551	539	Right on x
551	651	Change x y
296	293	Right on y
296	1113	Left on y
472	1177	Left on x
472	213	Change x y
296	588	Change x y
1135	765	Left on x
108	120	Change x y
1113	296	Right on y
1260	1259	Right on x
475	190	Right on x
475	477	Left on x
1136	793	Left on x
109	36	Right on x
306	166	Reversion on x
306	165	Reversion on y
306	304	Left on x
1085	698	Right on x
1154	1188	Right on x
1154	1086	Change x y
306	305	Left on y
1178	478	Right on x
1178	479	Left on x
1178	335	Change x y
1179	478	Left on x
1179	1087	Change x y
552	545	Right on x
552	499	Change x y
109	94	Left on x
553	548	Right on x
553	415	Change x y
8	979	Right on x
8	96	Change x y
10	117	Change x y
10	926	Right on x
11	1015	Right on x
11	927	Change x y
12	920	Right on x
12	1025	Change x y
14	929	Right on x
14	1036	Change x y
16	731	Right on x
17	39	Right on x
17	97	Change x y
18	1001	Right on x
18	507	Change x y
20	40	Right on x
20	118	Change x y
21	455	Change x y
23	42	Right on x
23	1016	Change x y
24	43	Right on x
24	1026	Change x y
731	16	Left on x
95	44	Right on x
95	1037	Change x y
96	8	Change x y
108	35	Right on x
109	1018	Change x y
732	1054	Left on x
733	1055	Left on x
115	1029	Change x y
865	1108	Right on x
865	19	Left on x
865	283	Change x y
866	843	Left on x
867	844	Left on x
868	845	Left on x
869	1052	Left on x
870	1053	Left on x
871	1056	Left on x
872	1058	Left on x
873	1059	Left on x
926	10	Left on x
907	942	Change x y
926	966	Change x y
927	11	Left on x
928	12	Left on x
929	14	Left on x
35	108	Left on x
74	292	Change x y
71	72	Right on x
74	745	Right on x
75	108	Right on x
80	86	Right on x
81	107	Right on x
1265	82	Left on x
82	107	Left on x
82	1265	Right on x
83	84	Right on x
84	83	Left on x
84	85	Right on x
85	84	Left on x
1266	85	Left on x
85	1266	Right on x
86	80	Left on x
86	87	Right on x
88	89	Right on x
89	90	Right on x
800	801	Reciprocal
454	180	Right on y
454	453	Change x y
703	1089	Reciprocal
437	438	Left on x
438	437	Right on x
440	441	Right on x
440	442	Right on y
440	443	Left on x
440	184	Change x y
703	704	Reciprocal
704	703	Reciprocal
547	546	Left on x
547	502	Change x y
793	794	Left on x
485	178	Right on x
485	486	Left on x
441	186	Change x y
441	440	Left on x
442	444	Left on x
442	440	Left on y
442	258	Change x y
443	440	Right on x
443	444	Right on y
443	445	Left on x
443	183	Change x y
444	442	Right on x
444	443	Left on y
444	185	Change x y
554	555	Right on x
555	556	Right on x
460	1197	Right on x
465	463	Right on x
465	448	Left on y
466	467	Right on x
466	1175	Right on y
466	469	Left on x
445	443	Right on x
445	447	Left on x
447	445	Right on x
466	203	Change x y
1175	466	Left on x
448	165	Right on x
448	465	Right on y
449	175	Right on x
449	451	Left on x
1175	206	Change x y
555	554	Left on x
467	468	Right on x
467	466	Left on x
469	466	Right on x
469	471	Left on x
469	204	Change x y
1176	1177	Right on x
1177	472	Right on x
1177	1176	Left on x
1177	212	Change x y
1017	104	Change x y
566	565	Right on x
116	1040	Change x y
1213	1176	Right on x
1213	474	Left on x
117	10	Change x y
474	1213	Right on x
117	966	Right on x
118	20	Change x y
119	101	Change x y
120	108	Change x y
123	437	Change x y
124	435	Change x y
125	1020	Change x y
126	1030	Change x y
127	1041	Change x y
128	102	Change x y
128	1104	Right on x
129	424	Change x y
479	481	Left on x
479	1178	Right on x
130	1021	Change x y
1217	814	Left on x
738	1207	Right on x
1217	329	Change x y
1009	1031	Change x y
1010	1042	Change x y
1011	103	Change x y
1012	1022	Change x y
1013	1032	Change x y
1014	1043	Change x y
1015	11	Change x y
1016	23	Change x y
1018	109	Change x y
1019	114	Change x y
1020	125	Change x y
1021	130	Change x y
1022	1012	Change x y
1024	1044	Change x y
1025	12	Change x y
1026	24	Change x y
1027	105	Change x y
1028	110	Change x y
1029	115	Change x y
1030	126	Change x y
1031	1009	Change x y
738	1203	Left on x
1047	19	Right on x
1047	281	Change x y
1048	843	Right on x
1049	844	Right on x
1050	845	Right on x
1058	872	Right on x
1059	873	Right on x
1061	875	Right on x
1060	874	Right on x
874	1060	Left on x
875	1061	Left on x
36	109	Left on x
37	110	Left on x
38	111	Left on x
39	17	Left on x
40	20	Left on x
41	22	Left on x
41	535	Change x y
42	23	Left on x
43	24	Left on x
44	95	Left on x
728	726	Right on x
89	88	Left on x
730	729	Right on x
90	89	Left on x
92	93	Right on x
93	92	Left on x
93	1267	Right on x
1267	93	Left on x
1267	1268	Right on x
1268	1267	Left on x
1269	332	Left on x
1270	309	Left on x
94	109	Right on x
1272	36	Left on x
936	232	Right on y
936	664	Change x y
937	965	Right on y
937	958	Change x y
938	959	Change x y
939	962	Change x y
940	960	Change x y
941	961	Change x y
942	907	Change x y
943	162	Change x y
944	833	Change x y
945	953	Change x y
946	267	Change x y
947	651	Left on x
947	539	Change x y
948	954	Change x y
949	272	Change x y
950	955	Change x y
951	956	Change x y
734	787	Right on x
952	957	Change x y
953	945	Change x y
954	948	Change x y
955	950	Change x y
956	832	Left on x
956	951	Change x y
957	952	Change x y
958	992	Right on x
958	937	Change x y
959	938	Change x y
960	940	Change x y
961	941	Change x y
962	939	Change x y
963	746	Change x y
964	752	Change x y
965	937	Left on x
965	992	Change x y
966	117	Left on x
966	926	Change x y
967	1004	Right on x
969	1003	Right on x
978	833	Left on x
979	8	Left on x
992	958	Left on x
992	965	Change x y
998	745	Left on x
998	291	Change x y
1001	18	Left on x
1001	508	Change x y
1003	969	Left on x
1004	967	Left on x
1005	20	Left on x
1095	455	Left on x
1277	1057	Left on x
1108	865	Left on x
1098	274	Left on x
1101	795	Reversion on x
1101	141	Left on x
1103	755	Left on x
1104	128	Left on x
1110	1294	Left on y
1111	759	Left on x
1273	437	Left on x
1275	1033	Change x y
1032	1013	Change x y
1033	1275	Change x y
1276	1051	Left on x
1051	1276	Right on x
1057	1277	Right on x
1278	29	Right on x
29	1278	Left on x
1300	1301	Right on x
1301	1300	Left on x
794	793	Right on x
50	36	Right on x
50	94	Left on x
50	1018	Change x y
1287	167	Left on y
1288	134	Change x y
1289	87	Left on x
87	87	Left on x
797	798	Right on x
797	796	Left on x
1292	402	Left on x
1291	172	Left on x
1110	147	Left on x
795	141	Reciprocal
481	479	Right on x
486	485	Right on x
795	1101	Reversion on x
798	799	Reciprocal
483	288	Right on x
483	484	Left on x
484	482	Right on x
798	797	Left on x
486	488	Right on x
1180	493	Right on x
490	489	Left on x
490	182	Change x y
1290	1214	Change x y
1290	498	Left on x
1290	368	Right on x
548	549	Right on x
548	553	Left on x
735	1139	Change x y
736	350	Change x y
1298	1297	Left on x
740	695	Right on x
741	1142	Right on x
743	742	Left on x
744	695	Left on x
745	998	Right on x
745	74	Left on x
745	290	Change x y
746	747	Right on x
746	748	Left on x
746	963	Change x y
747	746	Left on x
748	746	Right on x
749	750	Right on x
749	751	Left on x
750	749	Left on x
751	749	Right on x
796	797	Right on x
1257	1190	Right on x
625	624	Right on x
625	626	Left on x
1305	686	Left on x
1306	270	Left on x
742	743	Right on x
752	753	Right on x
752	754	Left on x
752	964	Change x y
753	752	Left on x
754	752	Right on x
755	1103	Right on x
759	1111	Right on x
759	760	Left on x
760	759	Right on x
761	762	Left on x
762	761	Right on x
763	764	Left on x
764	763	Right on x
765	1135	Right on x
765	766	Left on x
766	765	Right on x
767	223	Right on x
768	769	Left on x
769	768	Right on x
1307	187	Left on x
771	770	Right on x
771	772	Left on x
772	771	Right on x
1308	770	Left on x
770	771	Left on x
770	1308	Right on x
1309	773	Left on x
773	1309	Right on x
773	774	Left on x
774	773	Right on x
774	775	Left on x
775	774	Right on x
1125	193	Left on x
776	777	Right on x
777	776	Right on x
777	771	Left on x
778	777	Right on x
1310	1126	Left on x
1126	1310	Right on x
1126	1127	Left on x
1127	1126	Right on x
1127	1128	Left on x
1128	1127	Right on x
1294	1110	Right on y
1294	161	Left on x
1311	779	Left on x
1318	368	Right on x
1312	334	Left on x
779	1311	Right on x
779	1124	Left on x
1129	199	Left on x
781	782	Left on x
1318	498	Left on x
1318	1214	Change x y
488	486	Right on x
1258	623	Left on x
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: prog
--

COPY public."user" (id, username, email, profile_imagefile, password, moderator) FROM stdin;
1	temax	gorropand@gmail.com	1//c2071b799d96e370.png	$2b$12$du.i0jFKWIkm9Z3cvYJjruOMqfLIEz0PdW3IsJodEEkcRSEbx8BiC	t
3	kristina	kristi-kris2002@mail.ru	default.png	$2b$12$xPXNMWnrXmCHE1BVPdgqEeYYUAc636TjIxCj3UVYjHaZJ.WdajOLO	t
5	radmila01_reva	revarad95@gmail.com	default.png	$2b$12$gi9o7pedQY45D1EcoJ4HK.0SNyRjQ9Py9ulL9Q.FE223E9E9WbZt.	t
6	polinaa	polya.alina.2018@yandex.ru	default.png	$2b$12$P8UZUdZ1v86el9rdDz6Toeipav.husO3ITWT6NJZ9lO9qaUspOlbW	t
8	thatdamnpand	damnpand@gmail.com	default.png	$2b$12$IIgYuhSv5eg5TXZk6FCdEeq6ANYr.Ci53Cdw.QQReP2P8ZBHVwCvS	f
9	testuser	test@text.coim	default.png	$2b$12$8m6tsg6hcBLLwdi2nphB8OgSSxTFklW3snaHfdKngK6dfqMyd.gHK	f
2	mirozy13	korneeva.111@mail.ru	default.png	$2b$12$5ejGv.Ry2l9P0CLSZpLpSOFSS.MGOazki83GopdDj5W8bomqO1dOy	t
4	polina	polina.alina.2015@mail.ru	default.png	$2b$12$vK9RKb2okV.uarF3QC8Jduidk/VCXJ0bM5ifKKxcPzAvpeMwOn1Za	t
11	supertestuser	supertest@gmail.com	default.png	$2b$12$jjs0U.zCF9XfD8AHxsAfLe97KZFHtHWwYWokQzYi9ex/2Q1bwj/py	f
12	irumako	tsepelev_pashka1@mail.ru	default.png	$2b$12$e25cBJcRzU0xsnddTn2sCOGD7EBeuQUDO4stP3pUfFaeSJ7kScSM6	f
\.


--
-- Data for Name: variable; Type: TABLE DATA; Schema: public; Owner: prog
--

COPY public.variable (id, variable_name, formula_id) FROM stdin;
1	x	1
2	y	1
3	n	2
4	m	2
5	k	2
6	x	3
7	y	3
8	n	4
9	m	4
10	k	4
11	x	5
12	y	5
13	n	6
14	m	6
15	k	6
16	x	7
17	y	7
18	n	8
19	m	8
20	k	8
21	x	9
22	y	9
23	n	10
24	m	10
25	k	10
26	x	11
27	y	11
28	n	12
29	m	12
30	k	12
31	x	13
32	y	13
33	n	14
34	m	14
35	k	14
36	n	15
37	m	15
38	k	15
39	x	16
40	y	16
41	n	17
42	m	17
43	k	17
44	x	18
45	y	18
46	n	19
47	m	19
48	k	19
49	x	20
50	y	20
51	n	21
52	m	21
53	k	21
54	x	22
55	y	22
56	n	23
57	m	23
58	k	23
59	x	24
60	y	24
61	n	25
62	m	25
63	k	25
64	x	26
65	y	26
66	n	27
67	m	27
68	k	27
69	x	28
70	y	28
71	n	29
72	m	29
73	k	29
74	x	30
75	y	30
76	n	31
77	m	31
78	k	31
79	x	32
80	y	32
81	n	33
82	m	33
83	k	33
84	x	34
85	y	34
86	n	35
87	m	35
88	k	35
89	x	36
90	y	36
91	n	37
92	m	37
93	k	37
94	x	38
95	y	38
96	n	39
97	m	39
98	k	39
99	x	40
100	y	40
101	n	41
102	m	41
103	k	41
104	x	42
105	y	42
106	n	43
107	m	43
108	k	43
109	x	44
110	y	44
111	n	45
112	m	45
113	k	45
114	x	46
115	y	46
116	n	47
117	m	47
118	k	47
119	x	48
120	y	48
121	n	49
122	m	49
123	k	49
124	x	50
125	y	50
126	n	51
127	m	51
128	k	51
129	x	52
130	y	52
131	n	53
132	m	53
133	k	53
134	x	54
135	y	54
136	n	55
137	m	55
138	k	55
139	x	56
140	y	56
141	n	57
142	m	57
143	k	57
144	x	58
145	y	58
146	n	59
147	m	59
148	k	59
149	n	60
150	m	60
151	k	60
152	x	61
153	y	61
154	n	62
155	m	62
156	k	62
157	x	63
158	y	63
159	n	64
160	m	64
161	k	64
162	x	65
163	y	65
164	n	66
165	m	66
166	k	66
167	x	67
168	y	67
169	n	68
170	m	68
171	k	68
172	x	69
173	y	69
174	n	70
175	m	70
176	k	70
177	x	71
178	y	71
179	n	72
180	m	72
181	k	72
182	x	73
183	y	73
184	n	74
185	m	74
186	k	74
187	x	75
188	y	75
189	n	76
190	m	76
191	k	76
192	x	77
193	y	77
194	n	78
195	m	78
196	k	78
197	x	79
198	y	79
199	n	80
200	m	80
201	k	80
202	x	81
203	y	81
204	n	82
205	m	82
206	k	82
207	x	83
208	y	83
209	n	84
210	m	84
211	k	84
212	x	85
213	y	85
214	n	86
215	m	86
216	k	86
217	x	87
218	y	87
219	n	88
220	m	88
221	k	88
222	x	89
223	y	89
224	n	90
225	m	90
226	k	90
227	x	91
228	y	91
229	n	92
230	m	92
231	k	92
232	x	93
233	y	93
234	n	94
235	m	94
236	k	94
237	x	95
238	y	95
239	n	96
240	m	96
241	k	96
242	x	97
243	y	97
244	n	98
245	m	98
246	k	98
247	x	99
248	y	99
249	n	100
250	m	100
251	k	100
252	x	101
253	y	101
254	n	102
255	m	102
256	k	102
257	x	103
258	y	103
259	n	104
260	m	104
261	k	104
262	x	105
263	y	105
264	n	106
265	m	106
266	k	106
267	x	107
268	y	107
269	n	108
270	m	108
271	k	108
272	x	109
273	y	109
274	n	110
275	m	110
276	k	110
277	x	111
278	y	111
279	n	112
280	m	112
281	k	112
282	x	113
283	y	113
284	n	114
285	m	114
286	k	114
287	x	115
288	y	115
289	n	116
290	m	116
291	k	116
292	x	117
293	y	117
294	n	118
295	m	118
296	k	118
297	x	119
298	y	119
299	n	120
300	m	120
301	k	120
302	x	121
303	y	121
304	n	122
305	m	122
306	k	122
307	x	123
308	y	123
309	n	124
310	m	124
311	k	124
312	x	125
313	y	125
314	n	126
315	m	126
316	k	126
317	x	127
318	y	127
319	n	128
320	m	128
321	k	128
322	x	129
323	y	129
324	n	130
325	m	130
326	k	130
327	x	131
328	y	131
329	n	132
330	m	132
331	k	132
332	x	133
333	y	133
334	n	134
335	m	134
336	k	134
337	x	135
338	y	135
339	n	136
340	m	136
341	k	136
342	x	137
343	y	137
344	n	138
345	m	138
346	k	138
347	x	139
348	y	139
349	n	140
350	m	140
351	k	140
352	x	141
353	y	141
354	n	142
355	m	142
356	k	142
357	x	143
358	y	143
359	n	144
360	m	144
361	k	144
362	x	145
363	y	145
364	n	146
365	m	146
366	k	146
367	x	147
368	y	147
369	n	148
370	m	148
371	k	148
372	x	149
373	y	149
374	n	150
375	m	150
376	k	150
377	x	151
378	y	151
379	n	152
380	m	152
381	k	152
382	x	153
383	y	153
384	n	154
385	m	154
386	k	154
387	x	155
388	y	155
389	n	156
390	m	156
391	k	156
392	x	157
393	y	157
394	n	158
395	m	158
396	k	158
397	x	159
398	y	159
399	n	160
400	m	160
401	k	160
402	x	161
403	y	161
404	n	162
405	m	162
406	k	162
407	x	163
408	y	163
409	n	164
410	m	164
411	k	164
412	x	165
413	y	165
414	n	166
415	m	166
416	k	166
417	x	167
418	y	167
419	n	168
420	m	168
421	k	168
422	x	169
423	y	169
424	n	170
425	m	170
426	k	170
427	x	171
428	y	171
429	n	172
430	m	172
431	k	172
432	x	173
433	y	173
434	n	174
435	m	174
436	k	174
437	x	175
438	y	175
439	n	176
440	m	176
441	k	176
442	x	177
443	y	177
444	n	178
445	m	178
446	k	178
447	x	179
448	y	179
449	n	180
450	m	180
451	k	180
452	x	181
453	y	181
454	n	182
455	m	182
456	k	182
457	x	183
458	y	183
459	n	184
460	m	184
461	k	184
462	x	185
463	y	185
464	n	186
465	m	186
466	k	186
467	x	187
468	y	187
469	n	188
470	m	188
471	k	188
472	x	189
473	y	189
474	n	190
475	m	190
476	k	190
477	x	191
478	y	191
479	n	192
480	m	192
481	k	192
482	x	193
483	y	193
484	n	194
485	m	194
486	k	194
487	x	195
488	y	195
489	n	196
490	m	196
491	k	196
492	x	197
493	y	197
494	n	198
495	m	198
496	k	198
497	x	199
498	y	199
499	n	200
500	m	200
501	k	200
502	x	201
503	y	201
504	n	202
505	m	202
506	k	202
507	x	203
508	y	203
509	n	204
510	m	204
511	k	204
512	x	205
513	y	205
514	n	206
515	m	206
516	k	206
517	x	207
518	y	207
519	n	208
520	m	208
521	k	208
522	x	209
523	y	209
524	n	210
525	m	210
526	k	210
527	x	211
528	y	211
529	n	212
530	m	212
531	k	212
532	x	213
533	y	213
534	n	214
535	m	214
536	k	214
537	x	215
538	y	215
539	n	216
540	m	216
541	k	216
542	x	217
543	y	217
544	n	218
545	m	218
546	k	218
547	x	219
548	y	219
549	n	220
550	m	220
551	k	220
552	x	221
553	y	221
554	n	222
555	m	222
556	k	222
557	x	223
558	y	223
559	n	224
560	m	224
561	k	224
562	x	225
563	y	225
564	n	226
565	m	226
566	k	226
567	x	227
568	y	227
569	n	228
570	m	228
571	k	228
572	x	229
573	y	229
574	n	230
575	m	230
576	k	230
577	x	231
578	y	231
579	n	232
580	m	232
581	k	232
582	x	233
583	y	233
584	n	234
585	m	234
586	k	234
587	x	235
588	y	235
589	n	236
590	m	236
591	k	236
592	x	237
593	y	237
594	n	238
595	m	238
596	k	238
597	x	239
598	y	239
599	n	240
600	m	240
601	k	240
602	x	241
603	y	241
604	n	242
605	m	242
606	k	242
607	x	243
608	y	243
609	n	244
610	m	244
611	k	244
612	x	245
613	y	245
614	n	246
615	m	246
616	k	246
617	x	247
618	y	247
619	n	248
620	m	248
621	k	248
622	x	249
623	y	249
624	n	250
625	m	250
626	k	250
627	x	251
628	y	251
629	n	252
630	m	252
631	k	252
632	x	253
633	y	253
634	n	254
635	m	254
636	k	254
637	x	255
638	y	255
639	n	256
640	m	256
641	k	256
642	x	257
643	y	257
644	n	258
645	m	258
646	k	258
647	x	259
648	y	259
649	n	260
650	m	260
651	k	260
652	x	261
653	y	261
654	n	262
655	m	262
656	k	262
657	x	263
658	y	263
659	n	264
660	m	264
661	k	264
662	x	265
663	y	265
664	n	266
665	m	266
666	k	266
667	x	267
668	y	267
669	n	268
670	m	268
671	k	268
672	x	269
673	y	269
674	n	270
675	m	270
676	k	270
677	x	271
678	y	271
679	n	272
680	m	272
681	k	272
682	x	273
683	y	273
684	n	274
685	m	274
686	k	274
687	x	275
688	y	275
689	n	276
690	m	276
691	k	276
692	x	277
693	y	277
694	n	278
695	m	278
696	k	278
697	x	279
698	y	279
699	n	280
700	m	280
701	k	280
702	x	281
703	y	281
704	n	282
705	m	282
706	k	282
707	x	283
708	y	283
709	n	284
710	m	284
711	k	284
712	x	285
713	y	285
714	n	286
715	m	286
716	k	286
717	x	287
718	y	287
719	n	288
720	m	288
721	k	288
722	x	289
723	y	289
724	n	290
725	m	290
726	k	290
727	x	291
728	y	291
729	n	292
730	m	292
731	k	292
732	x	293
733	y	293
734	n	294
735	m	294
736	k	294
737	x	295
738	y	295
739	n	296
740	m	296
741	k	296
742	x	297
743	y	297
744	n	298
745	m	298
746	k	298
747	x	299
748	y	299
749	n	300
750	m	300
751	k	300
752	x	301
753	y	301
754	n	302
755	m	302
756	k	302
757	x	303
758	y	303
759	n	304
760	m	304
761	k	304
762	x	305
763	y	305
764	n	306
765	m	306
766	k	306
767	x	307
768	y	307
769	n	308
770	m	308
771	k	308
772	x	309
773	y	309
774	n	310
775	m	310
776	k	310
777	x	311
778	y	311
779	n	312
780	m	312
781	k	312
782	x	313
783	y	313
784	n	314
785	m	314
786	k	314
787	x	315
788	y	315
789	n	316
790	m	316
791	k	316
792	x	317
793	y	317
794	n	318
795	m	318
796	k	318
797	x	319
798	y	319
799	n	320
800	m	320
801	k	320
802	x	321
803	y	321
804	n	322
805	m	322
806	k	322
807	n	323
808	m	323
809	k	323
810	x	324
811	y	324
812	n	325
813	m	325
814	k	325
815	n	326
816	m	326
817	k	326
818	x	327
819	y	327
820	n	328
821	m	328
822	k	328
823	x	329
824	y	329
825	n	330
826	m	330
827	k	330
828	x	331
829	y	331
830	n	332
831	m	332
832	k	332
833	x	333
834	y	333
835	n	334
836	m	334
837	k	334
838	x	335
839	y	335
840	n	336
841	m	336
842	k	336
843	x	337
844	y	337
845	n	338
846	m	338
847	k	338
848	x	339
849	y	339
850	n	340
851	m	340
852	k	340
853	x	341
854	y	341
855	n	342
856	m	342
857	k	342
858	x	343
859	y	343
860	n	344
861	m	344
862	k	344
863	x	345
864	y	345
865	n	346
866	m	346
867	k	346
868	x	347
869	y	347
870	n	348
871	m	348
872	k	348
873	x	349
874	y	349
875	n	350
876	m	350
877	k	350
878	n	351
879	m	351
880	k	351
881	x	352
882	y	352
883	n	353
884	m	353
885	k	353
886	n	354
887	m	354
888	k	354
889	x	355
890	y	355
891	n	356
892	m	356
893	k	356
894	x	357
895	y	357
896	n	358
897	m	358
898	k	358
899	x	359
900	y	359
901	n	360
902	m	360
903	k	360
904	x	361
905	y	361
906	n	362
907	m	362
908	k	362
909	x	363
910	y	363
911	n	364
912	m	364
913	k	364
914	x	365
915	y	365
916	n	366
917	m	366
918	k	366
919	x	367
920	y	367
921	n	368
922	m	368
923	k	368
924	x	369
925	y	369
926	n	370
927	m	370
928	k	370
929	x	371
930	y	371
931	n	372
932	m	372
933	k	372
934	x	373
935	y	373
936	n	374
937	m	374
938	k	374
939	x	375
940	y	375
941	n	376
942	m	376
943	k	376
944	x	377
945	y	377
946	n	378
947	m	378
948	k	378
949	n	379
950	m	379
951	k	379
952	n	380
953	m	380
954	k	380
955	x	381
956	y	381
957	n	382
958	m	382
959	k	382
960	n	383
961	m	383
962	k	383
963	n	384
964	m	384
965	k	384
966	x	385
967	y	385
968	n	386
969	m	386
970	k	386
971	x	387
972	y	387
973	n	388
974	m	388
975	k	388
976	x	389
977	y	389
978	n	390
979	m	390
980	k	390
981	x	391
982	y	391
983	n	392
984	m	392
985	k	392
986	x	393
987	y	393
988	n	394
989	m	394
990	k	394
991	x	395
992	y	395
993	n	396
994	m	396
995	k	396
996	x	397
997	y	397
998	n	398
999	m	398
1000	k	398
1001	x	399
1002	y	399
1003	n	400
1004	m	400
1005	k	400
1006	x	401
1007	y	401
1008	n	402
1009	m	402
1010	k	402
1011	x	403
1012	y	403
1013	n	404
1014	m	404
1015	k	404
1016	x	405
1017	y	405
1018	n	406
1019	m	406
1020	k	406
1026	n	409
1027	m	409
1028	k	409
1035	x	412
1036	y	412
1037	n	413
1038	m	413
1039	k	413
1040	x	414
1041	y	414
1042	n	415
1043	m	415
1044	k	415
1045	x	416
1046	y	416
1047	n	417
1048	m	417
1049	k	417
1050	x	418
1051	y	418
1052	n	419
1053	m	419
1054	k	419
1055	n	420
1056	m	420
1057	k	420
1058	x	421
1059	y	421
1060	n	422
1061	m	422
1062	k	422
1063	n	423
1064	m	423
1065	k	423
1066	x	424
1067	y	424
1068	n	425
1069	m	425
1070	k	425
1071	x	426
1072	y	426
1073	n	427
1074	m	427
1075	k	427
1076	x	428
1077	y	428
1078	n	429
1079	m	429
1080	k	429
1081	x	430
1082	y	430
1083	n	431
1084	m	431
1085	k	431
1086	x	432
1087	y	432
1088	n	433
1089	m	433
1090	k	433
1091	n	434
1092	m	434
1093	k	434
1094	x	435
1095	y	435
1096	n	436
1097	m	436
1098	k	436
1099	n	437
1100	m	437
1101	k	437
1102	x	438
1103	y	438
1104	n	439
1105	m	439
1106	k	439
1107	x	440
1108	y	440
1109	n	441
1110	m	441
1111	k	441
1112	x	442
1113	y	442
1114	n	443
1115	m	443
1116	k	443
1117	n	444
1118	m	444
1119	k	444
1120	x	445
1121	y	445
1122	n	446
1123	m	446
1124	k	446
1125	x	447
1126	y	447
1127	n	448
1128	m	448
1129	k	448
1130	x	449
1131	y	449
1132	n	450
1133	m	450
1134	k	450
1135	x	451
1136	y	451
1137	n	452
1138	m	452
1139	k	452
1140	x	453
1141	y	453
1142	n	454
1143	m	454
1144	k	454
1145	x	455
1146	y	455
1147	n	456
1148	m	456
1149	k	456
1150	x	457
1151	y	457
1152	n	458
1153	m	458
1154	k	458
1155	x	459
1156	y	459
1157	n	460
1158	m	460
1159	k	460
1160	x	461
1161	y	461
1162	n	462
1163	m	462
1164	k	462
1165	x	463
1166	y	463
1167	n	464
1168	m	464
1169	k	464
1170	x	465
1171	y	465
1172	n	466
1173	m	466
1174	k	466
1175	x	467
1176	y	467
1177	n	468
1178	m	468
1179	k	468
1180	x	469
1181	y	469
1182	n	470
1183	m	470
1184	k	470
1185	x	471
1186	y	471
1187	n	472
1188	m	472
1189	k	472
1190	n	473
1191	m	473
1192	k	473
1193	x	474
1194	y	474
1195	n	475
1196	m	475
1197	k	475
1198	n	476
1199	m	476
1200	k	476
1201	x	477
1202	y	477
1203	n	478
1204	m	478
1205	k	478
1206	n	479
1207	m	479
1208	k	479
1209	x	480
1210	y	480
1211	n	481
1212	m	481
1213	k	481
1214	n	482
1215	m	482
1216	k	482
1217	x	483
1218	y	483
1219	n	484
1220	m	484
1221	k	484
1222	n	485
1223	m	485
1224	k	485
1225	x	486
1226	y	486
1227	n	487
1228	m	487
1229	k	487
1230	n	488
1231	m	488
1232	k	488
1233	x	489
1234	y	489
1235	n	490
1236	m	490
1237	k	490
1238	n	491
1239	m	491
1240	k	491
1241	x	492
1242	y	492
1243	n	493
1244	m	493
1245	k	493
1246	n	494
1247	m	494
1248	k	494
1249	x	495
1250	y	495
1251	n	496
1252	m	496
1253	k	496
1254	n	497
1255	m	497
1256	k	497
1257	x	498
1258	y	498
1259	n	499
1260	m	499
1261	k	499
1262	n	500
1263	m	500
1264	k	500
1265	x	501
1266	y	501
1267	n	502
1268	m	502
1269	k	502
1270	x	503
1271	y	503
1272	n	504
1273	m	504
1274	k	504
1275	x	505
1276	y	505
1277	n	506
1278	m	506
1279	k	506
1280	x	507
1281	y	507
1282	n	508
1283	m	508
1284	k	508
1285	n	509
1286	m	509
1287	k	509
1288	x	510
1289	y	510
1290	n	511
1291	m	511
1292	k	511
1293	x	512
1294	y	512
1295	n	513
1296	m	513
1297	k	513
1298	x	514
1299	y	514
1300	n	515
1301	m	515
1302	k	515
1303	n	516
1304	m	516
1305	k	516
1306	n	517
1307	m	517
1308	k	517
1309	x	518
1310	y	518
1311	n	519
1312	m	519
1313	k	519
1314	n	520
1315	m	520
1316	k	520
1317	n	521
1318	m	521
1319	k	521
1320	x	522
1321	y	522
1322	n	523
1323	m	523
1324	k	523
1325	x	524
1326	y	524
1327	n	525
1328	m	525
1329	k	525
1330	x	526
1331	y	526
1332	n	527
1333	m	527
1334	k	527
1335	x	528
1336	y	528
1337	n	529
1338	m	529
1339	k	529
1340	n	530
1341	m	530
1342	k	530
1343	n	531
1344	m	531
1345	k	531
1346	x	532
1347	y	532
1348	n	533
1349	m	533
1350	k	533
1351	n	534
1352	m	534
1353	k	534
1354	n	535
1355	m	535
1356	k	535
1357	n	536
1358	m	536
1359	k	536
1360	x	537
1361	y	537
1362	n	538
1363	m	538
1364	k	538
1365	x	539
1366	y	539
1367	n	540
1368	m	540
1369	k	540
1370	x	541
1371	y	541
1372	n	542
1373	m	542
1374	k	542
1375	x	543
1376	y	543
1377	n	544
1378	m	544
1379	k	544
1380	x	545
1381	y	545
1382	n	546
1383	m	546
1384	k	546
1385	x	547
1386	y	547
1387	n	548
1388	m	548
1389	k	548
1390	x	549
1391	y	549
1392	n	550
1393	m	550
1394	k	550
1395	x	551
1396	y	551
1397	n	552
1398	m	552
1399	k	552
1400	n	553
1401	m	553
1402	k	553
1403	x	554
1404	y	554
1405	n	555
1406	m	555
1407	k	555
1408	n	556
1409	m	556
1410	k	556
1411	x	557
1412	y	557
1413	n	558
1414	m	558
1415	k	558
1416	x	559
1417	y	559
1418	n	560
1419	m	560
1420	k	560
1421	x	561
1422	y	561
1423	n	562
1424	m	562
1425	k	562
1426	x	563
1427	y	563
1428	n	564
1429	m	564
1430	k	564
1431	x	565
1432	y	565
1433	n	566
1434	m	566
1435	k	566
1436	x	567
1437	y	567
1438	n	568
1439	m	568
1440	k	568
1441	n	569
1442	m	569
1443	k	569
1444	x	570
1445	y	570
1446	n	571
1447	m	571
1448	k	571
1449	x	572
1450	y	572
1451	n	573
1452	m	573
1453	k	573
1454	n	574
1455	m	574
1456	k	574
1457	n	575
1458	m	575
1459	k	575
1460	n	576
1461	m	576
1462	k	576
1463	x	577
1464	y	577
1465	n	578
1466	m	578
1467	k	578
1468	x	579
1469	y	579
1470	n	580
1471	m	580
1472	k	580
1473	x	581
1474	y	581
1475	n	582
1476	m	582
1477	k	582
1478	x	583
1479	y	583
1480	n	584
1481	m	584
1482	k	584
1483	n	585
1484	m	585
1485	k	585
1486	n	586
1487	m	586
1488	k	586
1489	x	587
1490	y	587
1491	n	588
1492	m	588
1493	k	588
1494	n	589
1495	m	589
1496	k	589
1497	n	590
1498	m	590
1499	k	590
1500	x	591
1501	y	591
1502	n	592
1503	m	592
1504	k	592
1505	x	593
1506	y	593
1507	n	594
1508	m	594
1509	k	594
1510	x	595
1511	y	595
1512	n	596
1513	m	596
1514	k	596
1515	x	597
1516	y	597
1517	n	598
1518	m	598
1519	k	598
1520	n	599
1521	m	599
1522	k	599
1523	n	600
1524	m	600
1525	k	600
1526	x	601
1527	y	601
1528	n	602
1529	m	602
1530	k	602
1531	x	603
1532	y	603
1533	n	604
1534	m	604
1535	k	604
1536	x	605
1537	y	605
1538	n	606
1539	m	606
1540	k	606
1541	x	607
1542	y	607
1543	n	608
1544	m	608
1545	k	608
1546	n	609
1547	m	609
1548	k	609
1549	n	610
1550	m	610
1551	k	610
1552	x	611
1553	y	611
1554	n	612
1555	m	612
1556	k	612
1557	x	613
1558	y	613
1559	n	614
1560	m	614
1561	k	614
1562	x	615
1563	y	615
1564	n	616
1565	m	616
1566	k	616
1567	x	617
1568	y	617
1569	n	618
1570	m	618
1571	k	618
1572	n	619
1573	m	619
1574	k	619
1575	x	620
1576	y	620
1577	n	621
1578	m	621
1579	k	621
1580	x	622
1581	y	622
1582	n	623
1583	m	623
1584	k	623
1585	x	624
1586	y	624
1587	n	625
1588	m	625
1589	k	625
1590	x	626
1591	y	626
1592	n	627
1593	m	627
1594	k	627
1595	x	628
1596	y	628
1597	n	629
1598	m	629
1599	k	629
1600	x	630
1601	y	630
1602	n	631
1603	m	631
1604	k	631
1605	x	632
1606	y	632
1607	n	633
1608	m	633
1609	k	633
1610	x	634
1611	y	634
1612	n	635
1613	m	635
1614	k	635
1615	n	636
1616	m	636
1617	k	636
1618	x	637
1619	y	637
1620	n	638
1621	m	638
1622	k	638
1632	x	642
1633	y	642
1634	n	643
1635	m	643
1636	k	643
1637	n	644
1638	m	644
1639	k	644
1640	n	645
1641	m	645
1642	k	645
1643	n	646
1644	m	646
1645	k	646
1646	x	647
1647	y	647
1648	n	648
1649	m	648
1650	k	648
1651	x	649
1652	y	649
1653	n	650
1654	m	650
1655	k	650
1656	x	651
1657	y	651
1658	n	652
1659	m	652
1660	k	652
1661	x	653
1662	y	653
1663	n	654
1664	m	654
1665	k	654
1666	x	655
1667	y	655
1668	n	656
1669	m	656
1670	k	656
1671	x	657
1672	y	657
1673	n	658
1674	m	658
1675	k	658
1676	x	659
1677	y	659
1678	n	660
1679	m	660
1680	k	660
1681	x	661
1682	y	661
1683	n	662
1684	m	662
1685	k	662
1686	x	663
1687	y	663
1688	n	664
1689	m	664
1690	k	664
1691	x	665
1692	y	665
1693	n	666
1694	m	666
1695	k	666
1696	x	667
1697	y	667
1698	n	668
1699	m	668
1700	k	668
1701	x	669
1702	y	669
1706	n	671
1707	m	671
1708	k	671
1709	x	672
1710	y	672
1717	n	675
1718	m	675
1719	k	675
1723	x	677
1724	y	677
1731	n	680
1732	m	680
1733	k	680
1734	x	681
1735	y	681
1736	n	682
1737	m	682
1738	k	682
1739	x	683
1740	y	683
1741	n	684
1742	m	684
1743	k	684
1744	x	685
1745	y	685
1746	n	686
1747	m	686
1748	k	686
1749	x	687
1750	y	687
1751	n	688
1752	m	688
1753	k	688
1754	x	689
1755	y	689
1756	n	690
1757	m	690
1758	k	690
1759	x	691
1760	y	691
1761	n	692
1762	m	692
1763	k	692
1764	x	693
1765	y	693
1766	n	694
1767	m	694
1768	k	694
1769	x	695
1770	y	695
1771	n	696
1772	m	696
1773	k	696
1774	x	697
1775	y	697
1776	n	698
1777	m	698
1778	k	698
1779	n	699
1780	m	699
1781	k	699
1782	n	700
1783	m	700
1784	k	700
1785	x	701
1786	y	701
1787	n	702
1788	m	702
1789	k	702
1790	x	703
1791	y	703
1792	n	704
1793	m	704
1794	k	704
1795	x	705
1796	y	705
1797	n	706
1798	m	706
1799	k	706
1800	x	707
1801	y	707
1802	n	708
1803	m	708
1804	k	708
1805	x	709
1806	y	709
1807	n	710
1808	m	710
1809	k	710
1810	x	711
1811	y	711
1812	n	712
1813	m	712
1814	k	712
1815	x	713
1816	y	713
1817	n	714
1818	m	714
1819	k	714
1820	x	715
1821	y	715
1822	n	716
1823	m	716
1824	k	716
1825	x	717
1826	y	717
1827	n	718
1828	m	718
1829	k	718
1830	x	719
1831	y	719
1832	n	720
1833	m	720
1834	k	720
1835	x	721
1836	y	721
1837	n	722
1838	m	722
1839	k	722
1840	x	723
1841	y	723
1842	n	724
1843	m	724
1844	k	724
1845	x	725
1846	y	725
1847	n	726
1848	m	726
1849	k	726
1850	x	727
1851	y	727
1852	n	728
1853	m	728
1854	k	728
1855	x	729
1856	y	729
1857	n	730
1858	m	730
1859	k	730
1860	x	731
1861	y	731
1862	n	732
1863	m	732
1864	k	732
1865	x	733
1866	y	733
1867	n	734
1868	m	734
1869	k	734
1870	x	735
1871	y	735
1872	n	736
1873	m	736
1874	k	736
1875	n	737
1876	m	737
1877	k	737
1878	x	738
1879	y	738
1880	n	739
1881	m	739
1882	k	739
1883	x	740
1884	y	740
1885	n	741
1886	m	741
1887	k	741
1888	n	742
1889	m	742
1890	k	742
1891	n	743
1892	m	743
1893	k	743
1894	n	744
1895	m	744
1896	k	744
1897	x	745
1898	y	745
1899	n	746
1900	m	746
1901	k	746
1902	x	747
1903	y	747
1904	n	748
1905	m	748
1906	k	748
1907	x	749
1908	y	749
1909	n	750
1910	m	750
1911	k	750
1912	x	751
1913	y	751
1914	n	752
1915	m	752
1916	k	752
1917	x	753
1918	y	753
1919	n	754
1920	m	754
1921	k	754
1922	x	755
1923	y	755
1924	n	756
1925	m	756
1926	k	756
1927	x	757
1928	y	757
1929	n	758
1930	m	758
1931	k	758
1932	x	759
1933	y	759
1934	n	760
1935	m	760
1936	k	760
1937	n	761
1938	m	761
1939	k	761
1940	n	762
1941	m	762
1942	k	762
1943	x	763
1944	y	763
1945	n	764
1946	m	764
1947	k	764
1948	x	765
1949	y	765
1950	n	766
1951	m	766
1952	k	766
1953	x	767
1954	y	767
1955	n	768
1956	m	768
1957	k	768
1958	x	769
1959	y	769
1960	n	770
1961	m	770
1962	k	770
1963	x	771
1964	y	771
1965	n	772
1966	m	772
1967	k	772
1968	x	773
1969	y	773
1970	n	774
1971	m	774
1972	k	774
1973	x	775
1974	y	775
1975	n	776
1976	m	776
1977	k	776
1978	n	777
1979	m	777
1980	k	777
1981	x	778
1982	y	778
1983	n	779
1984	m	779
1985	k	779
1986	x	780
1987	y	780
1988	n	781
1989	m	781
1990	k	781
1991	n	782
1992	m	782
1993	k	782
1994	x	783
1995	y	783
1996	n	784
1997	m	784
1998	k	784
1999	n	785
2000	m	785
2001	k	785
2002	x	786
2003	y	786
2004	n	787
2005	m	787
2006	k	787
2007	x	788
2008	y	788
2009	n	789
2010	m	789
2011	k	789
2012	x	790
2013	y	790
2014	n	791
2015	m	791
2016	k	791
2017	x	792
2018	y	792
2019	n	793
2020	m	793
2021	k	793
2022	x	794
2023	y	794
2024	n	795
2025	m	795
2026	k	795
2027	x	796
2028	y	796
2029	n	797
2030	m	797
2031	k	797
2032	x	798
2033	y	798
2034	n	799
2035	m	799
2036	k	799
2037	x	800
2038	y	800
2039	n	801
2040	m	801
2041	k	801
2042	n	802
2043	m	802
2044	k	802
2045	n	803
2046	m	803
2047	k	803
2048	x	804
2049	y	804
2050	n	805
2051	m	805
2052	k	805
2053	n	806
2054	m	806
2055	k	806
2056	n	807
2057	m	807
2058	k	807
2059	n	808
2060	m	808
2061	k	808
2062	x	809
2063	y	809
2064	n	810
2065	m	810
2066	k	810
2067	n	811
2068	m	811
2069	k	811
2070	x	812
2071	y	812
2072	n	813
2073	m	813
2074	k	813
2075	n	814
2076	m	814
2077	k	814
2078	x	815
2079	y	815
2080	n	816
2081	m	816
2082	k	816
2083	x	817
2084	y	817
2085	n	818
2086	m	818
2087	k	818
2088	x	819
2089	y	819
2090	n	820
2091	m	820
2092	k	820
2093	x	821
2094	y	821
2095	n	822
2096	m	822
2097	k	822
2098	x	823
2099	y	823
2100	n	824
2101	m	824
2102	k	824
2103	n	825
2104	m	825
2105	k	825
2106	x	826
2107	y	826
2108	n	827
2109	m	827
2110	k	827
2111	x	828
2112	y	828
2113	n	829
2114	m	829
2115	k	829
2116	x	830
2117	y	830
2118	n	831
2119	m	831
2120	k	831
2121	x	832
2122	y	832
2123	n	833
2124	m	833
2125	k	833
2126	x	834
2127	y	834
2128	n	835
2129	m	835
2130	k	835
2131	x	836
2132	y	836
2133	n	837
2134	m	837
2135	k	837
2136	x	838
2137	y	838
2138	n	839
2139	m	839
2140	k	839
2141	x	840
2142	y	840
2143	n	841
2144	m	841
2145	k	841
2146	x	842
2147	y	842
2148	n	843
2149	m	843
2150	k	843
2151	x	844
2152	y	844
2153	n	845
2154	m	845
2155	k	845
2156	x	846
2157	y	846
2158	n	847
2159	m	847
2160	k	847
2161	x	848
2162	y	848
2163	n	849
2164	m	849
2165	k	849
2166	x	850
2167	y	850
2168	n	851
2169	m	851
2170	k	851
2171	x	852
2172	y	852
2173	n	853
2174	m	853
2175	k	853
2176	x	854
2177	y	854
2178	n	855
2179	m	855
2180	k	855
2181	x	856
2182	y	856
2183	n	857
2184	m	857
2185	k	857
2186	x	858
2187	y	858
2188	n	859
2189	m	859
2190	k	859
2191	x	860
2192	y	860
2193	n	861
2194	m	861
2195	k	861
2196	x	862
2197	y	862
2198	n	863
2199	m	863
2200	k	863
2201	x	864
2202	y	864
2206	n	866
2207	m	866
2208	k	866
2215	x	869
2216	y	869
2217	n	870
2218	m	870
2219	k	870
2220	x	871
2221	y	871
2222	n	872
2223	m	872
2224	k	872
2225	n	873
2226	m	873
2227	k	873
2228	x	874
2229	y	874
2230	n	875
2231	m	875
2232	k	875
2233	x	876
2234	y	876
2235	n	877
2236	m	877
2237	k	877
2238	x	878
2239	y	878
2240	n	879
2241	m	879
2242	k	879
2243	x	880
2244	y	880
2245	n	881
2246	m	881
2247	k	881
2248	x	882
2249	y	882
2250	n	883
2251	m	883
2252	k	883
2253	x	884
2254	y	884
2255	n	885
2256	m	885
2257	k	885
2258	x	886
2259	y	886
2260	n	887
2261	m	887
2262	k	887
2263	x	888
2264	y	888
2265	n	889
2266	m	889
2267	k	889
2268	n	890
2269	m	890
2270	k	890
2271	x	891
2272	y	891
2273	n	892
2274	m	892
2275	k	892
2276	n	893
2277	m	893
2278	k	893
2279	x	894
2280	y	894
2290	n	898
2291	m	898
2292	k	898
2293	x	899
2294	y	899
2295	n	900
2296	m	900
2297	k	900
2298	n	901
2299	m	901
2300	k	901
2301	n	902
2302	m	902
2303	k	902
2304	x	903
2305	y	903
2312	n	906
2313	m	906
2314	k	906
2315	x	907
2316	y	907
2317	n	908
2318	m	908
2319	k	908
2320	n	909
2321	m	909
2322	k	909
2323	x	910
2324	y	910
2325	n	911
2326	m	911
2327	k	911
2328	n	912
2329	m	912
2330	k	912
2331	x	913
2332	y	913
2333	n	914
2334	m	914
2335	k	914
2336	n	915
2337	m	915
2338	k	915
2339	x	916
2340	y	916
2341	n	917
2342	m	917
2343	k	917
2344	n	918
2345	m	918
2346	k	918
2347	x	919
2348	y	919
2349	n	920
2350	m	920
2351	k	920
2352	n	921
2353	m	921
2354	k	921
2355	x	922
2356	y	922
2357	n	923
2358	m	923
2359	k	923
2360	n	924
2361	m	924
2362	k	924
2363	x	925
2364	y	925
2365	n	926
2366	m	926
2367	k	926
2368	n	927
2369	m	927
2370	k	927
2371	x	928
2372	y	928
2373	n	929
2374	m	929
2375	k	929
2376	n	930
2377	m	930
2378	k	930
2379	x	931
2380	y	931
2381	n	932
2382	m	932
2383	k	932
2384	n	933
2385	m	933
2386	k	933
2387	n	934
2388	m	934
2389	k	934
2390	n	935
2391	m	935
2392	k	935
2393	x	936
2394	y	936
2395	n	937
2396	m	937
2397	k	937
2398	n	938
2399	m	938
2400	k	938
2401	n	939
2402	m	939
2403	k	939
2404	x	940
2405	y	940
2406	n	941
2407	m	941
2408	k	941
2409	x	942
2410	y	942
2411	n	943
2412	m	943
2413	k	943
2414	x	944
2415	y	944
2416	n	945
2417	m	945
2418	k	945
2419	x	946
2420	y	946
2421	n	947
2422	m	947
2423	k	947
2424	x	948
2425	y	948
2426	n	949
2427	m	949
2428	k	949
2429	x	950
2430	y	950
2431	n	951
2432	m	951
2433	k	951
2434	x	952
2435	y	952
2436	n	953
2437	m	953
2438	k	953
2439	x	954
2440	y	954
2441	n	955
2442	m	955
2443	k	955
2444	x	956
2445	y	956
2446	n	957
2447	m	957
2448	k	957
2449	n	958
2450	m	958
2451	k	958
2452	x	959
2453	y	959
2454	n	960
2455	m	960
2456	k	960
2457	x	961
2458	y	961
2459	n	962
2460	m	962
2461	k	962
2462	x	963
2463	y	963
2464	n	964
2465	m	964
2466	k	964
2467	n	965
2468	m	965
2469	k	965
2470	x	966
2471	y	966
2472	n	967
2473	m	967
2474	k	967
2475	x	968
2476	y	968
2477	n	969
2478	m	969
2479	k	969
2480	x	970
2481	y	970
2482	n	971
2483	m	971
2484	k	971
2485	x	972
2486	y	972
2487	n	973
2488	m	973
2489	k	973
2490	x	974
2491	y	974
2492	n	975
2493	m	975
2494	k	975
2495	x	976
2496	y	976
2497	n	977
2498	m	977
2499	k	977
2500	x	978
2501	y	978
2502	n	979
2503	m	979
2504	k	979
2505	x	980
2506	y	980
2507	n	981
2508	m	981
2509	k	981
2510	n	982
2511	m	982
2512	k	982
2513	x	983
2514	y	983
2515	n	984
2516	m	984
2517	k	984
2518	x	985
2519	y	985
2520	n	986
2521	m	986
2522	k	986
2523	x	987
2524	y	987
2525	n	988
2526	m	988
2527	k	988
2528	x	989
2529	y	989
2530	n	990
2531	m	990
2532	k	990
2533	x	991
2534	y	991
2535	n	992
2536	m	992
2537	k	992
2538	x	993
2539	y	993
2540	n	994
2541	m	994
2542	k	994
2543	x	995
2544	y	995
2545	n	996
2546	m	996
2547	k	996
2548	n	997
2549	m	997
2550	k	997
2551	x	998
2552	y	998
2553	n	999
2554	m	999
2555	k	999
2556	n	1000
2557	m	1000
2558	k	1000
2559	n	1001
2560	m	1001
2561	k	1001
2562	x	1002
2563	y	1002
2564	n	1003
2565	m	1003
2566	k	1003
2567	x	1004
2568	y	1004
2569	n	1005
2570	m	1005
2571	k	1005
2572	x	1006
2573	y	1006
2574	n	1007
2575	m	1007
2576	k	1007
2577	n	1008
2578	m	1008
2579	k	1008
2580	x	1009
2581	y	1009
2582	n	1010
2583	m	1010
2584	k	1010
2585	n	1011
2586	m	1011
2587	k	1011
2588	n	1012
2589	m	1012
2590	k	1012
2591	x	1013
2592	y	1013
2593	n	1014
2594	m	1014
2595	k	1014
2596	x	1015
2597	y	1015
2598	n	1016
2599	m	1016
2600	k	1016
2601	x	1017
2602	y	1017
2603	n	1018
2604	m	1018
2605	k	1018
2606	n	1019
2607	m	1019
2608	k	1019
2609	x	1020
2610	y	1020
2611	n	1021
2612	m	1021
2613	k	1021
2614	x	1022
2615	y	1022
2616	n	1023
2617	m	1023
2618	k	1023
2619	x	1024
2620	y	1024
2621	n	1025
2622	m	1025
2623	k	1025
2624	x	1026
2625	y	1026
2626	n	1027
2627	m	1027
2628	k	1027
2629	x	1028
2630	y	1028
2631	n	1029
2632	m	1029
2633	k	1029
2634	n	1030
2635	m	1030
2636	k	1030
2637	n	1031
2638	m	1031
2639	k	1031
2640	x	1032
2641	y	1032
2642	n	1033
2643	m	1033
2644	k	1033
2645	n	1034
2646	m	1034
2647	k	1034
2648	x	1035
2649	y	1035
2650	n	1036
2651	m	1036
2652	k	1036
2653	n	1037
2654	m	1037
2655	k	1037
2656	n	1038
2657	m	1038
2658	k	1038
2659	x	1039
2660	y	1039
2661	n	1040
2662	m	1040
2663	k	1040
2664	x	1041
2665	y	1041
2666	n	1042
2667	m	1042
2668	k	1042
2669	x	1043
2670	y	1043
2671	n	1044
2672	m	1044
2673	k	1044
2674	x	1045
2675	y	1045
2676	n	1046
2677	m	1046
2678	k	1046
2679	n	1047
2680	m	1047
2681	k	1047
2682	x	1048
2683	y	1048
2684	n	1049
2685	m	1049
2686	k	1049
2687	x	1050
2688	y	1050
2689	n	1051
2690	m	1051
2691	k	1051
2692	x	1052
2693	y	1052
2694	n	1053
2695	m	1053
2696	k	1053
2697	x	1054
2698	y	1054
2699	n	1055
2700	m	1055
2701	k	1055
2702	x	1056
2703	y	1056
2704	n	1057
2705	m	1057
2706	k	1057
2707	x	1058
2708	y	1058
2712	n	1060
2713	m	1060
2714	k	1060
2715	x	1061
2716	y	1061
2717	n	1062
2718	m	1062
2719	k	1062
2720	x	1063
2721	y	1063
2722	n	1064
2723	m	1064
2724	k	1064
2725	x	1065
2726	y	1065
2727	n	1066
2728	m	1066
2729	k	1066
2730	x	1067
2731	y	1067
2732	n	1068
2733	m	1068
2734	k	1068
2735	x	1069
2736	y	1069
2737	n	1070
2738	m	1070
2739	k	1070
2740	n	1071
2741	m	1071
2742	k	1071
2743	x	1072
2744	y	1072
2745	n	1073
2746	m	1073
2747	k	1073
2748	n	1074
2749	m	1074
2750	k	1074
2751	n	1075
2752	m	1075
2753	k	1075
2754	x	1076
2755	y	1076
2756	n	1077
2757	m	1077
2758	k	1077
2759	x	1078
2760	y	1078
2761	n	1079
2762	m	1079
2763	k	1079
2764	x	1080
2765	y	1080
2766	n	1081
2767	m	1081
2768	k	1081
2769	x	1082
2770	y	1082
2771	n	1083
2772	m	1083
2773	k	1083
2774	n	1084
2775	m	1084
2776	k	1084
2777	n	1085
2778	m	1085
2779	k	1085
2780	x	1086
2781	y	1086
2782	n	1087
2783	m	1087
2784	k	1087
2785	n	1088
2786	m	1088
2787	k	1088
2788	n	1089
2789	m	1089
2790	k	1089
2791	x	1090
2792	y	1090
2793	n	1091
2794	m	1091
2795	k	1091
2796	n	1092
2797	m	1092
2798	k	1092
2799	n	1093
2800	m	1093
2801	k	1093
2802	x	1094
2803	y	1094
2804	n	1095
2805	m	1095
2806	k	1095
2807	n	1096
2808	m	1096
2809	k	1096
2810	x	1097
2811	y	1097
2812	n	1098
2813	m	1098
2814	k	1098
2815	n	1099
2816	m	1099
2817	k	1099
2818	n	1100
2819	m	1100
2820	k	1100
2821	x	1101
2822	y	1101
2823	n	1102
2824	m	1102
2825	k	1102
2826	n	1103
2827	m	1103
2828	k	1103
2829	n	1104
2830	m	1104
2831	k	1104
2832	n	1105
2833	m	1105
2834	k	1105
2835	x	1106
2836	y	1106
2837	n	1107
2838	m	1107
2839	k	1107
2840	n	1108
2841	m	1108
2842	k	1108
2843	n	1109
2844	m	1109
2845	k	1109
2846	x	1110
2847	y	1110
2848	n	1111
2849	m	1111
2850	k	1111
2851	n	1112
2852	m	1112
2853	k	1112
2854	n	1113
2855	m	1113
2856	k	1113
2857	n	1114
2858	m	1114
2859	k	1114
2860	x	1115
2861	y	1115
2862	n	1116
2863	m	1116
2864	k	1116
2865	x	1117
2866	y	1117
2867	n	1118
2868	m	1118
2869	k	1118
2870	x	1119
2871	y	1119
2872	n	1120
2873	m	1120
2874	k	1120
2875	n	1121
2876	m	1121
2877	k	1121
2878	n	1122
2879	m	1122
2880	k	1122
2881	n	1123
2882	m	1123
2883	k	1123
2884	x	1124
2885	y	1124
2886	n	1125
2887	m	1125
2888	k	1125
2889	n	1126
2890	m	1126
2891	k	1126
2892	n	1127
2893	m	1127
2894	k	1127
2895	n	1128
2896	m	1128
2897	k	1128
2898	x	1129
2899	y	1129
2900	n	1130
2901	m	1130
2902	k	1130
2903	n	1131
2904	m	1131
2905	k	1131
2906	x	1132
2907	y	1132
2908	n	1133
2909	m	1133
2910	k	1133
2911	n	1134
2912	m	1134
2913	k	1134
2914	x	1135
2915	y	1135
2916	n	1136
2917	m	1136
2918	k	1136
2919	n	1137
2920	m	1137
2921	k	1137
2922	n	1138
2923	m	1138
2924	k	1138
2925	n	1139
2926	m	1139
2927	k	1139
2928	x	1140
2929	y	1140
2930	n	1141
2931	m	1141
2932	k	1141
2933	n	1142
2934	m	1142
2935	k	1142
2936	x	1143
2937	y	1143
2938	n	1144
2939	m	1144
2940	k	1144
2941	n	1145
2942	m	1145
2943	k	1145
2944	x	1146
2945	y	1146
2946	n	1147
2947	m	1147
2948	k	1147
2949	n	1148
2950	m	1148
2951	k	1148
2952	n	1149
2953	m	1149
2954	k	1149
2955	n	1150
2956	m	1150
2957	k	1150
2972	x	1156
2973	y	1156
2974	n	1157
2975	m	1157
2976	k	1157
2977	n	1158
2978	m	1158
2979	k	1158
2980	n	1159
2981	m	1159
2982	k	1159
2983	n	1160
2984	m	1160
2985	k	1160
2986	x	1161
2987	y	1161
2988	n	1162
2989	m	1162
2990	k	1162
2991	n	1163
2992	m	1163
2993	k	1163
2994	n	1164
2995	m	1164
2996	k	1164
2997	n	1165
2998	m	1165
2999	k	1165
3000	x	1166
3001	y	1166
3002	n	1167
3003	m	1167
3004	k	1167
3005	n	1168
3006	m	1168
3007	k	1168
3008	n	1169
3009	m	1169
3010	k	1169
3011	x	1170
3012	y	1170
3013	n	1171
3014	m	1171
3015	k	1171
3016	x	1172
3017	y	1172
3018	n	1173
3019	m	1173
3020	k	1173
3021	n	1174
3022	m	1174
3023	k	1174
3024	n	1175
3025	m	1175
3026	k	1175
3027	x	1176
3028	y	1176
3029	n	1177
3030	m	1177
3031	k	1177
3032	n	1178
3033	m	1178
3034	k	1178
3035	n	1179
3036	m	1179
3037	k	1179
3038	n	1180
3039	m	1180
3040	k	1180
3041	x	1181
3042	y	1181
3043	n	1182
3044	m	1182
3045	k	1182
3046	n	1183
3047	m	1183
3048	k	1183
3049	n	1184
3050	m	1184
3051	k	1184
3052	x	1185
3053	y	1185
3054	n	1186
3055	m	1186
3056	k	1186
3057	x	1187
3058	y	1187
3059	n	1188
3060	m	1188
3061	k	1188
3062	x	1189
3063	y	1189
3064	n	1190
3065	m	1190
3066	k	1190
3067	n	1191
3068	m	1191
3069	k	1191
3070	n	1192
3071	m	1192
3072	k	1192
3073	n	1193
3074	m	1193
3075	k	1193
3076	x	1194
3077	y	1194
3078	n	1195
3079	m	1195
3080	k	1195
3081	n	1196
3082	m	1196
3083	k	1196
3084	n	1197
3085	m	1197
3086	k	1197
3087	x	1198
3088	y	1198
3089	n	1199
3090	m	1199
3091	k	1199
3092	n	1200
3093	m	1200
3094	k	1200
3095	n	1201
3096	m	1201
3097	k	1201
3098	n	1202
3099	m	1202
3100	k	1202
3101	x	1203
3102	y	1203
3103	n	1204
3104	m	1204
3105	k	1204
3106	n	1205
3107	m	1205
3108	k	1205
3109	n	1206
3110	m	1206
3111	k	1206
3112	x	1207
3113	y	1207
3114	n	1208
3115	m	1208
3116	k	1208
3117	x	1209
3118	y	1209
3119	n	1210
3120	m	1210
3121	k	1210
3122	n	1211
3123	m	1211
3124	k	1211
3125	n	1212
3126	m	1212
3127	k	1212
3128	n	1213
3129	m	1213
3130	k	1213
3131	x	1214
3132	y	1214
3133	n	1215
3134	m	1215
3135	k	1215
3136	n	1216
3137	m	1216
3138	k	1216
3139	n	1217
3140	m	1217
3141	k	1217
3142	x	1218
3143	y	1218
3144	n	1219
3145	m	1219
3146	k	1219
3147	n	1220
3148	m	1220
3149	k	1220
3150	n	1221
3151	m	1221
3152	k	1221
3153	n	1222
3154	m	1222
3155	k	1222
3156	x	1223
3157	y	1223
3158	n	1224
3159	m	1224
3160	k	1224
3161	n	1225
3162	m	1225
3163	k	1225
3164	n	1226
3165	m	1226
3166	k	1226
3167	x	1227
3168	y	1227
3169	n	1228
3170	m	1228
3171	k	1228
3172	x	1229
3173	y	1229
3174	n	1230
3175	m	1230
3176	k	1230
3177	x	1231
3178	y	1231
3179	n	1232
3180	m	1232
3181	k	1232
3182	n	1233
3183	m	1233
3184	k	1233
3185	x	1234
3186	y	1234
3187	n	1235
3188	m	1235
3189	k	1235
3190	n	1236
3191	m	1236
3192	k	1236
3193	x	1237
3194	y	1237
3195	n	1238
3196	m	1238
3197	k	1238
3198	n	1239
3199	m	1239
3200	k	1239
3201	n	1240
3202	m	1240
3203	k	1240
3204	n	1241
3205	m	1241
3206	k	1241
3207	x	1242
3208	y	1242
3209	n	1243
3210	m	1243
3211	k	1243
3212	n	1244
3213	m	1244
3214	k	1244
3215	x	1245
3216	y	1245
3217	n	1246
3218	m	1246
3219	k	1246
3220	x	1247
3221	y	1247
3222	n	1248
3223	m	1248
3224	k	1248
3225	x	1249
3226	y	1249
3227	n	1250
3228	m	1250
3229	k	1250
3230	n	1251
3231	m	1251
3232	k	1251
3233	n	1252
3234	m	1252
3235	k	1252
3236	n	1253
3237	m	1253
3238	k	1253
3239	x	1254
3240	y	1254
3241	n	1255
3242	m	1255
3243	k	1255
3244	n	1256
3245	m	1256
3246	k	1256
3247	x	1257
3248	y	1257
3249	n	1258
3250	m	1258
3251	k	1258
3252	n	1259
3253	m	1259
3254	k	1259
3255	x	1260
3256	y	1260
3257	n	1261
3258	m	1261
3259	k	1261
3260	n	1262
3261	m	1262
3262	k	1262
3263	x	1263
3264	y	1263
3265	n	1264
3266	m	1264
3267	k	1264
3268	n	1265
3269	m	1265
3270	k	1265
3271	n	1266
3272	m	1266
3273	k	1266
3274	n	1267
3275	m	1267
3276	k	1267
3277	x	1268
3278	y	1268
3279	n	1269
3280	m	1269
3281	k	1269
3282	n	1270
3283	m	1270
3284	k	1270
3285	x	1271
3286	y	1271
3287	n	1272
3288	m	1272
3289	k	1272
3290	n	1273
3291	m	1273
3292	k	1273
3293	n	1274
3294	m	1274
3295	k	1274
3296	n	1275
3297	m	1275
3298	k	1275
3299	x	1276
3300	y	1276
3301	n	1277
3302	m	1277
3303	k	1277
3304	n	1278
3305	m	1278
3306	k	1278
3307	x	1279
3308	y	1279
3309	n	1280
3310	m	1280
3311	k	1280
3312	n	1281
3313	m	1281
3314	k	1281
3315	x	1282
3316	y	1282
3317	n	1283
3318	m	1283
3319	k	1283
3320	n	1284
3321	m	1284
3322	k	1284
3323	n	1285
3324	m	1285
3325	k	1285
3326	n	1286
3327	m	1286
3328	k	1286
3329	x	1287
3330	y	1287
3331	n	1288
3332	m	1288
3333	k	1288
3334	n	1289
3335	m	1289
3336	k	1289
3337	n	1290
3338	m	1290
3339	k	1290
3340	n	1291
3341	m	1291
3342	k	1291
3343	x	1292
3344	y	1292
3345	n	1293
3346	m	1293
3347	k	1293
3348	n	1294
3349	m	1294
3350	k	1294
3351	x	1295
3352	y	1295
3353	n	1296
3354	m	1296
3355	k	1296
3356	n	1297
3357	m	1297
3358	k	1297
3359	n	1298
3360	m	1298
3361	k	1298
3362	x	1299
3363	y	1299
3364	n	1300
3365	m	1300
3366	k	1300
3367	n	1301
3368	m	1301
3369	k	1301
3370	x	1302
3371	y	1302
3372	n	1303
3373	m	1303
3374	k	1303
3375	x	1304
3376	y	1304
3377	n	1305
3378	m	1305
3379	k	1305
3380	x	1306
3381	y	1306
3382	n	1307
3383	m	1307
3384	k	1307
3385	n	1308
3386	m	1308
3387	k	1308
3388	n	1309
3389	m	1309
3390	k	1309
3391	n	1310
3392	m	1310
3393	k	1310
3394	x	1311
3395	y	1311
3396	n	1312
3397	m	1312
3398	k	1312
3399	x	1313
3400	y	1313
3401	n	1314
3402	m	1314
3403	k	1314
3404	x	1315
3405	y	1315
3406	n	1316
3407	m	1316
3408	k	1316
3409	x	1317
3410	y	1317
3411	n	1318
3412	m	1318
3413	k	1318
3414	x	1319
3415	y	1319
3416	n	1320
3417	m	1320
3418	k	1320
3419	x	1321
3420	y	1321
3421	n	1322
3422	m	1322
3423	k	1322
3424	x	1323
3425	y	1323
3426	n	1324
3427	m	1324
3428	k	1324
3429	x	1325
3430	y	1325
3431	n	1326
3432	m	1326
3433	k	1326
3434	x	1327
3435	y	1327
3436	n	1328
3437	m	1328
3438	k	1328
3439	n	1329
3440	m	1329
3441	k	1329
3442	x	1330
3443	y	1330
3444	n	1331
3445	m	1331
3446	k	1331
3447	n	1332
3448	m	1332
3449	k	1332
3450	x	1333
3451	y	1333
3452	n	1334
3453	m	1334
3454	k	1334
3455	n	1335
3456	m	1335
3457	k	1335
3458	x	1336
3459	y	1336
3460	n	1337
3461	m	1337
3462	k	1337
3463	n	1338
3464	m	1338
3465	k	1338
3466	x	1339
3467	y	1339
3468	n	1340
3469	m	1340
3470	k	1340
3471	x	1341
3472	y	1341
3473	n	1342
3474	m	1342
3475	k	1342
3476	x	1343
3477	y	1343
3478	n	1344
3479	m	1344
3480	k	1344
3481	x	1345
3482	y	1345
3483	n	1346
3484	m	1346
3485	k	1346
3486	x	1347
3487	y	1347
3488	n	1348
3489	m	1348
3490	k	1348
3491	x	1349
3492	y	1349
3493	n	1350
3494	m	1350
3495	k	1350
3496	x	1351
3497	y	1351
3498	n	1352
3499	m	1352
3500	k	1352
3501	n	1353
3502	m	1353
3503	k	1353
3504	x	1354
3505	y	1354
3506	n	1355
3507	m	1355
3508	k	1355
3509	n	1356
3510	m	1356
3511	k	1356
3512	x	1357
3513	y	1357
3514	n	1358
3515	m	1358
3516	k	1358
3517	x	1359
3518	y	1359
3519	n	1360
3520	m	1360
3521	k	1360
3522	x	1361
3523	y	1361
3524	n	1362
3525	m	1362
3526	k	1362
3527	x	1363
3528	y	1363
3529	n	1364
3530	m	1364
3531	k	1364
3532	x	1365
3533	y	1365
3534	n	1366
3535	m	1366
3536	k	1366
3537	n	1367
3538	m	1367
3539	k	1367
3540	x	1368
3541	y	1368
3542	n	1369
3543	m	1369
3544	k	1369
3545	x	1370
3546	y	1370
3547	n	1371
3548	m	1371
3549	k	1371
3550	x	1372
3551	y	1372
3552	n	1373
3553	m	1373
3554	k	1373
3555	x	1374
3556	y	1374
3557	n	1375
3558	m	1375
3559	k	1375
3560	x	1376
3561	y	1376
3562	n	1377
3563	m	1377
3564	k	1377
3565	x	1378
3566	y	1378
3567	n	1379
3568	m	1379
3569	k	1379
3570	n	1380
3571	m	1380
3572	k	1380
3573	x	1381
3574	y	1381
3575	n	1382
3576	m	1382
3577	k	1382
3578	n	1383
3579	m	1383
3580	k	1383
3581	x	1384
3582	y	1384
3583	n	1385
3584	m	1385
3585	k	1385
3586	x	1386
3587	y	1386
3588	n	1387
3589	m	1387
3590	k	1387
3591	x	1388
3592	y	1388
3593	n	1389
3594	m	1389
3595	k	1389
3596	x	1390
3597	y	1390
3598	n	1391
3599	m	1391
3600	k	1391
3601	n	1392
3602	m	1392
3603	k	1392
3604	x	1393
3605	y	1393
3606	n	1394
3607	m	1394
3608	k	1394
3609	n	1395
3610	m	1395
3611	k	1395
3612	x	1396
3613	y	1396
3614	n	1397
3615	m	1397
3616	k	1397
3617	x	1398
3618	y	1398
3619	n	1399
3620	m	1399
3621	k	1399
3622	n	1400
3623	m	1400
3624	k	1400
3625	x	1401
3626	y	1401
3627	n	1402
3628	m	1402
3629	k	1402
3630	n	1403
3631	m	1403
3632	k	1403
3633	x	1404
3634	y	1404
3635	n	1405
3636	m	1405
3637	k	1405
3638	n	1406
3639	m	1406
3640	k	1406
3641	x	1407
3642	y	1407
3643	n	1408
3644	m	1408
3645	k	1408
3646	x	1409
3647	y	1409
3648	n	1410
3649	m	1410
3650	k	1410
3651	n	1411
3652	m	1411
3653	k	1411
3654	x	1412
3655	y	1412
3656	n	1413
3657	m	1413
3658	k	1413
3659	n	1414
3660	m	1414
3661	k	1414
3662	x	1415
3663	y	1415
3664	n	1416
3665	m	1416
3666	k	1416
3667	n	1417
3668	m	1417
3669	k	1417
3670	n	1418
3671	m	1418
3672	k	1418
3673	n	1419
3674	m	1419
3675	k	1419
3676	n	1420
3677	m	1420
3678	k	1420
3679	x	1421
3680	y	1421
3681	n	1422
3682	m	1422
3683	k	1422
3684	x	1423
3685	y	1423
3686	n	1424
3687	m	1424
3688	k	1424
3689	x	1425
3690	y	1425
3691	n	1426
3692	m	1426
3693	k	1426
3694	n	1427
3695	m	1427
3696	k	1427
3697	x	1428
3698	y	1428
3699	n	1429
3700	m	1429
3701	k	1429
3702	n	1430
3703	m	1430
3704	k	1430
3705	x	1431
3706	y	1431
3707	n	1432
3708	m	1432
3709	k	1432
3710	n	1433
3711	m	1433
3712	k	1433
3713	n	1434
3714	m	1434
3715	k	1434
3716	n	1435
3717	m	1435
3718	k	1435
3719	n	1436
3720	m	1436
3721	k	1436
3722	x	1437
3723	y	1437
3724	n	1438
3725	m	1438
3726	k	1438
3727	n	1439
3728	m	1439
3729	k	1439
3730	x	1440
3731	y	1440
3732	n	1441
3733	m	1441
3734	k	1441
3735	n	1442
3736	m	1442
3737	k	1442
3738	x	1443
3739	y	1443
3740	n	1444
3741	m	1444
3742	k	1444
3743	x	1445
3744	y	1445
3745	n	1446
3746	m	1446
3747	k	1446
3748	x	1447
3749	y	1447
3750	n	1448
3751	m	1448
3752	k	1448
3753	n	1449
3754	m	1449
3755	k	1449
3756	x	1450
3757	y	1450
3758	n	1451
3759	m	1451
3760	k	1451
3761	x	1452
3762	y	1452
3763	n	1453
3764	m	1453
3765	k	1453
3766	x	1454
3767	y	1454
3768	n	1455
3769	m	1455
3770	k	1455
3771	x	1456
3772	y	1456
3773	n	1457
3774	m	1457
3775	k	1457
3776	n	1458
3777	m	1458
3778	k	1458
3779	x	1459
3780	y	1459
3781	n	1460
3782	m	1460
3783	k	1460
3784	x	1461
3785	y	1461
3786	n	1462
3787	m	1462
3788	k	1462
3789	x	1463
3790	y	1463
3791	n	1464
3792	m	1464
3793	k	1464
3794	x	1465
3795	y	1465
3796	n	1466
3797	m	1466
3798	k	1466
3799	n	1467
3800	m	1467
3801	k	1467
3802	x	1468
3803	y	1468
3804	n	1469
3805	m	1469
3806	k	1469
3807	x	1470
3808	y	1470
3809	n	1471
3810	m	1471
3811	k	1471
3812	x	1472
3813	y	1472
3814	n	1473
3815	m	1473
3816	k	1473
3817	x	1474
3818	y	1474
3819	n	1475
3820	m	1475
3821	k	1475
3822	n	1476
3823	m	1476
3824	k	1476
3825	x	1477
3826	y	1477
3827	n	1478
3828	m	1478
3829	k	1478
3830	x	1479
3831	y	1479
3832	n	1480
3833	m	1480
3834	k	1480
3835	x	1481
3836	y	1481
3837	n	1482
3838	m	1482
3839	k	1482
3840	x	1483
3841	y	1483
3842	n	1484
3843	m	1484
3844	k	1484
3845	n	1485
3846	m	1485
3847	k	1485
3848	x	1486
3849	y	1486
3850	n	1487
3851	m	1487
3852	k	1487
3853	x	1488
3854	y	1488
3855	n	1489
3856	m	1489
3857	k	1489
3858	x	1490
3859	y	1490
3860	n	1491
3861	m	1491
3862	k	1491
3863	x	1492
3864	y	1492
3865	n	1493
3866	m	1493
3867	k	1493
3868	x	1494
3869	y	1494
3870	n	1495
3871	m	1495
3872	k	1495
3873	x	1496
3874	y	1496
3875	n	1497
3876	m	1497
3877	k	1497
3878	x	1498
3879	y	1498
3880	n	1499
3881	m	1499
3882	k	1499
3883	n	1500
3884	m	1500
3885	k	1500
3886	x	1501
3887	y	1501
3888	n	1502
3889	m	1502
3890	k	1502
3891	x	1503
3892	y	1503
3893	n	1504
3894	m	1504
3895	k	1504
3896	x	1505
3897	y	1505
3898	n	1506
3899	m	1506
3900	k	1506
3901	x	1507
3902	y	1507
3903	n	1508
3904	m	1508
3905	k	1508
3906	n	1509
3907	m	1509
3908	k	1509
3909	x	1510
3910	y	1510
3911	n	1511
3912	m	1511
3913	k	1511
3914	n	1512
3915	m	1512
3916	k	1512
3917	x	1513
3918	y	1513
3919	n	1514
3920	m	1514
3921	k	1514
3922	n	1515
3923	m	1515
3924	k	1515
3925	x	1516
3926	y	1516
3927	n	1517
3928	m	1517
3929	k	1517
3930	n	1518
3931	m	1518
3932	k	1518
3933	n	1519
3934	m	1519
3935	k	1519
3936	n	1520
3937	m	1520
3938	k	1520
3939	n	1521
3940	m	1521
3941	k	1521
3942	x	1522
3943	y	1522
3944	n	1523
3945	m	1523
3946	k	1523
3947	x	1524
3948	y	1524
3949	n	1525
3950	m	1525
3951	k	1525
3952	x	1526
3953	y	1526
3954	n	1527
3955	m	1527
3956	k	1527
3957	x	1528
3958	y	1528
3959	n	1529
3960	m	1529
3961	k	1529
3962	x	1530
3963	y	1530
3964	n	1531
3965	m	1531
3966	k	1531
3967	n	1532
3968	m	1532
3969	k	1532
3970	x	1533
3971	y	1533
3972	n	1534
3973	m	1534
3974	k	1534
3975	n	1535
3976	m	1535
3977	k	1535
3978	n	1536
3979	m	1536
3980	k	1536
3981	n	1537
3982	m	1537
3983	k	1537
3984	n	1538
3985	m	1538
3986	k	1538
3987	x	1539
3988	y	1539
3989	n	1540
3990	m	1540
3991	k	1540
3992	n	1541
3993	m	1541
3994	k	1541
3995	n	1542
3996	m	1542
3997	k	1542
3998	x	1543
3999	y	1543
4000	n	1544
4001	m	1544
4002	k	1544
4003	n	1545
4004	m	1545
4005	k	1545
4006	x	1546
4007	y	1546
4008	n	1547
4009	m	1547
4010	k	1547
4011	n	1548
4012	m	1548
4013	k	1548
4014	x	1549
4015	y	1549
4016	n	1550
4017	m	1550
4018	k	1550
4019	n	1551
4020	m	1551
4021	k	1551
4022	x	1552
4023	y	1552
4024	n	1553
4025	m	1553
4026	k	1553
4027	n	1554
4028	m	1554
4029	k	1554
4030	x	1555
4031	y	1555
4032	n	1556
4033	m	1556
4034	k	1556
4035	n	1557
4036	m	1557
4037	k	1557
4038	x	1558
4039	y	1558
4040	n	1559
4041	m	1559
4042	k	1559
4043	x	1560
4044	y	1560
4045	n	1561
4046	m	1561
4047	k	1561
4048	n	1562
4049	m	1562
4050	k	1562
4051	n	1563
4052	m	1563
4053	k	1563
4054	n	1564
4055	m	1564
4056	k	1564
4057	x	1565
4058	y	1565
4059	n	1566
4060	m	1566
4061	k	1566
4062	n	1567
4063	m	1567
4064	k	1567
4065	n	1568
4066	m	1568
4067	k	1568
4068	n	1569
4069	m	1569
4070	k	1569
4071	x	1570
4072	y	1570
4073	n	1571
4074	m	1571
4075	k	1571
4076	x	1572
4077	y	1572
4078	n	1573
4079	m	1573
4080	k	1573
4081	n	1574
4082	m	1574
4083	k	1574
4084	n	1575
4085	m	1575
4086	k	1575
4087	n	1576
4088	m	1576
4089	k	1576
4090	x	1577
4091	y	1577
4092	n	1578
4093	m	1578
4094	k	1578
4095	n	1579
4096	m	1579
4097	k	1579
4098	n	1580
4099	m	1580
4100	k	1580
4101	n	1581
4102	m	1581
4103	k	1581
4104	x	1582
4105	y	1582
4106	n	1583
4107	m	1583
4108	k	1583
4109	x	1584
4110	y	1584
4111	n	1585
4112	m	1585
4113	k	1585
4114	n	1586
4115	m	1586
4116	k	1586
4117	n	1587
4118	m	1587
4119	k	1587
4120	n	1588
4121	m	1588
4122	k	1588
4123	x	1589
4124	y	1589
4125	n	1590
4126	m	1590
4127	k	1590
4128	n	1591
4129	m	1591
4130	k	1591
4131	n	1592
4132	m	1592
4133	k	1592
4134	n	1593
4135	m	1593
4136	k	1593
4137	x	1594
4138	y	1594
4139	n	1595
4140	m	1595
4141	k	1595
4142	n	1596
4143	m	1596
4144	k	1596
4145	x	1597
4146	y	1597
4147	n	1598
4148	m	1598
4149	k	1598
4150	n	1599
4151	m	1599
4152	k	1599
4153	n	1600
4154	m	1600
4155	k	1600
4156	n	1601
4157	m	1601
4158	k	1601
4159	x	1602
4160	y	1602
4161	n	1603
4162	m	1603
4163	k	1603
4164	n	1604
4165	m	1604
4166	k	1604
4167	x	1605
4168	y	1605
4169	n	1606
4170	m	1606
4171	k	1606
4172	n	1607
4173	m	1607
4174	k	1607
4175	x	1608
4176	y	1608
4177	n	1609
4178	m	1609
4179	k	1609
4180	n	1610
4181	m	1610
4182	k	1610
4183	n	1611
4184	m	1611
4185	k	1611
4186	n	1612
4187	m	1612
4188	k	1612
4189	x	1613
4190	y	1613
4191	n	1614
4192	m	1614
4193	k	1614
4194	n	1615
4195	m	1615
4196	k	1615
4197	n	1616
4198	m	1616
4199	k	1616
4200	n	1617
4201	m	1617
4202	k	1617
4203	x	1618
4204	y	1618
4205	n	1619
4206	m	1619
4207	k	1619
4208	n	1620
4209	m	1620
4210	k	1620
4211	n	1621
4212	m	1621
4213	k	1621
4214	n	1622
4215	m	1622
4216	k	1622
4217	x	1623
4218	y	1623
4219	n	1624
4220	m	1624
4221	k	1624
4222	n	1625
4223	m	1625
4224	k	1625
4225	n	1626
4226	m	1626
4227	k	1626
4228	n	1627
4229	m	1627
4230	k	1627
4231	x	1628
4232	y	1628
4233	n	1629
4234	m	1629
4235	k	1629
4236	n	1630
4237	m	1630
4238	k	1630
4239	x	1631
4240	y	1631
4241	n	1632
4242	m	1632
4243	k	1632
4244	x	1633
4245	y	1633
4246	n	1634
4247	m	1634
4248	k	1634
4249	x	1635
4250	y	1635
4251	n	1636
4252	m	1636
4253	k	1636
4254	x	1637
4255	y	1637
4256	n	1638
4257	m	1638
4258	k	1638
4259	n	1639
4260	m	1639
4261	k	1639
4262	n	1640
4263	m	1640
4264	k	1640
4265	n	1641
4266	m	1641
4267	k	1641
4268	n	1642
4269	m	1642
4270	k	1642
4271	x	1643
4272	y	1643
4273	n	1644
4274	m	1644
4275	k	1644
4276	x	1645
4277	y	1645
4278	n	1646
4279	m	1646
4280	k	1646
4281	x	1647
4282	y	1647
4283	n	1648
4284	m	1648
4285	k	1648
4286	x	1649
4287	y	1649
4288	n	1650
4289	m	1650
4290	k	1650
4291	n	1651
4292	m	1651
4293	k	1651
4294	x	1652
4295	y	1652
4296	n	1653
4297	m	1653
4298	k	1653
4299	x	1654
4300	y	1654
4301	n	1655
4302	m	1655
4303	k	1655
4304	x	1656
4305	y	1656
4306	n	1657
4307	m	1657
4308	k	1657
4309	x	1658
4310	y	1658
4311	n	1659
4312	m	1659
4313	k	1659
4314	x	1660
4315	y	1660
4316	n	1661
4317	m	1661
4318	k	1661
4319	x	1662
4320	y	1662
4321	n	1663
4322	m	1663
4323	k	1663
4324	x	1664
4325	y	1664
4326	n	1665
4327	m	1665
4328	k	1665
4329	x	1666
4330	y	1666
4331	n	1667
4332	m	1667
4333	k	1667
4334	x	1668
4335	y	1668
4336	n	1669
4337	m	1669
4338	k	1669
4339	n	1670
4340	m	1670
4341	k	1670
4342	x	1671
4343	y	1671
4344	n	1672
4345	m	1672
4346	k	1672
4347	x	1673
4348	y	1673
4349	n	1674
4350	m	1674
4351	k	1674
4352	x	1675
4353	y	1675
4354	n	1676
4355	m	1676
4356	k	1676
4357	n	1677
4358	m	1677
4359	k	1677
4360	x	1678
4361	y	1678
4362	n	1679
4363	m	1679
4364	k	1679
4365	x	1680
4366	y	1680
4367	n	1681
4368	m	1681
4369	k	1681
4370	x	1682
4371	y	1682
4372	n	1683
4373	m	1683
4374	k	1683
4375	x	1684
4376	y	1684
4377	n	1685
4378	m	1685
4379	k	1685
4380	x	1686
4381	y	1686
4382	n	1687
4383	m	1687
4384	k	1687
4385	n	1688
4386	m	1688
4387	k	1688
4388	x	1689
4389	y	1689
4390	n	1690
4391	m	1690
4392	k	1690
4393	n	1691
4394	m	1691
4395	k	1691
4396	n	1692
4397	m	1692
4398	k	1692
4399	n	1693
4400	m	1693
4401	k	1693
4402	x	1694
4403	y	1694
4404	n	1695
4405	m	1695
4406	k	1695
4407	n	1696
4408	m	1696
4409	k	1696
4410	x	1697
4411	y	1697
4412	n	1698
4413	m	1698
4414	k	1698
4415	x	1699
4416	y	1699
4417	n	1700
4418	m	1700
4419	k	1700
4420	x	1701
4421	y	1701
4422	n	1702
4423	m	1702
4424	k	1702
4425	n	1703
4426	m	1703
4427	k	1703
4428	x	1704
4429	y	1704
4430	n	1705
4431	m	1705
4432	k	1705
4433	n	1706
4434	m	1706
4435	k	1706
4436	x	1707
4437	y	1707
4438	n	1708
4439	m	1708
4440	k	1708
4441	n	1709
4442	m	1709
4443	k	1709
4444	n	1710
4445	m	1710
4446	k	1710
4447	n	1711
4448	m	1711
4449	k	1711
4450	x	1712
4451	y	1712
4452	n	1713
4453	m	1713
4454	k	1713
4455	x	1714
4456	y	1714
4457	n	1715
4458	m	1715
4459	k	1715
4460	x	1716
4461	y	1716
4462	n	1717
4463	m	1717
4464	k	1717
4465	x	1718
4466	y	1718
4467	n	1719
4468	m	1719
4469	k	1719
4470	x	1720
4471	y	1720
4472	n	1721
4473	m	1721
4474	k	1721
4475	x	1722
4476	y	1722
4477	n	1723
4478	m	1723
4479	k	1723
4480	x	1724
4481	y	1724
4482	n	1725
4483	m	1725
4484	k	1725
4485	x	1726
4486	y	1726
4487	n	1727
4488	m	1727
4489	k	1727
4490	x	1728
4491	y	1728
4492	n	1729
4493	m	1729
4494	k	1729
4495	x	1730
4496	y	1730
4497	n	1731
4498	m	1731
4499	k	1731
4500	x	1732
4501	y	1732
4502	n	1733
4503	m	1733
4504	k	1733
4505	x	1734
4506	y	1734
4507	n	1735
4508	m	1735
4509	k	1735
4510	x	1736
4511	y	1736
4512	n	1737
4513	m	1737
4514	k	1737
4518	x	1739
4519	y	1739
4520	n	1740
4521	m	1740
4522	k	1740
4523	x	1741
4524	y	1741
4525	n	1742
4526	m	1742
4527	k	1742
4531	x	1744
4532	y	1744
4533	n	1745
4534	m	1745
4535	k	1745
4536	x	1746
4537	y	1746
4544	x	1749
4545	y	1749
4546	n	1750
4547	m	1750
4548	k	1750
4549	x	1751
4550	y	1751
4551	n	1752
4552	m	1752
4553	k	1752
4557	x	1754
4558	y	1754
4559	n	1755
4560	m	1755
4561	k	1755
4562	x	1756
4563	y	1756
4564	n	1757
4565	m	1757
4566	k	1757
4567	x	1758
4568	y	1758
4569	n	1759
4570	m	1759
4571	k	1759
4575	x	1761
4576	y	1761
4577	n	1762
4578	m	1762
4579	k	1762
4583	x	1764
4584	y	1764
4585	n	1765
4586	m	1765
4587	k	1765
4588	x	1766
4589	y	1766
4590	n	1767
4591	m	1767
4592	k	1767
4593	x	1768
4594	y	1768
4595	n	1769
4596	m	1769
4597	k	1769
4598	x	1770
4599	y	1770
4600	n	1771
4601	m	1771
4602	k	1771
4603	x	1772
4604	y	1772
4605	n	1773
4606	m	1773
4607	k	1773
4608	x	1774
4609	y	1774
4610	n	1775
4611	m	1775
4612	k	1775
4613	x	1776
4614	y	1776
4615	n	1777
4616	m	1777
4617	k	1777
4618	x	1778
4619	y	1778
4620	n	1779
4621	m	1779
4622	k	1779
4623	x	1780
4624	y	1780
4625	n	1781
4626	m	1781
4627	k	1781
4628	x	1782
4629	y	1782
4630	n	1783
4631	m	1783
4632	k	1783
4633	x	1784
4634	y	1784
4635	n	1785
4636	m	1785
4637	k	1785
4638	x	1786
4639	y	1786
4640	n	1787
4641	m	1787
4642	k	1787
4643	x	1788
4644	y	1788
4645	n	1789
4646	m	1789
4647	k	1789
4648	x	1790
4649	y	1790
4650	n	1791
4651	m	1791
4652	k	1791
4653	x	1792
4654	y	1792
4655	n	1793
4656	m	1793
4657	k	1793
4658	x	1794
4659	y	1794
4660	n	1795
4661	m	1795
4662	k	1795
4663	x	1796
4664	y	1796
4665	n	1797
4666	m	1797
4667	k	1797
4668	x	1798
4669	y	1798
4670	n	1799
4671	m	1799
4672	k	1799
4673	x	1800
4674	y	1800
4675	n	1801
4676	m	1801
4677	k	1801
4678	x	1802
4679	y	1802
4680	n	1803
4681	m	1803
4682	k	1803
4683	x	1804
4684	y	1804
4685	n	1805
4686	m	1805
4687	k	1805
4688	x	1806
4689	y	1806
4690	n	1807
4691	m	1807
4692	k	1807
4693	x	1808
4694	y	1808
4695	n	1809
4696	m	1809
4697	k	1809
4698	x	1810
4699	y	1810
4700	n	1811
4701	m	1811
4702	k	1811
4703	x	1812
4704	y	1812
4705	n	1813
4706	m	1813
4707	k	1813
4708	x	1814
4709	y	1814
4710	n	1815
4711	m	1815
4712	k	1815
4713	x	1816
4714	y	1816
4715	n	1817
4716	m	1817
4717	k	1817
4718	x	1818
4719	y	1818
4720	n	1819
4721	m	1819
4722	k	1819
4723	x	1820
4724	y	1820
4725	n	1821
4726	m	1821
4727	k	1821
4728	x	1822
4729	y	1822
4730	n	1823
4731	m	1823
4732	k	1823
4733	x	1824
4734	y	1824
4735	n	1825
4736	m	1825
4737	k	1825
4738	x	1826
4739	y	1826
4740	n	1827
4741	m	1827
4742	k	1827
4743	x	1828
4744	y	1828
4745	n	1829
4746	m	1829
4747	k	1829
4748	x	1830
4749	y	1830
4750	n	1831
4751	m	1831
4752	k	1831
4753	x	1832
4754	y	1832
4755	n	1833
4756	m	1833
4757	k	1833
4758	x	1834
4759	y	1834
4760	n	1835
4761	m	1835
4762	k	1835
4763	x	1836
4764	y	1836
4765	n	1837
4766	m	1837
4767	k	1837
4768	x	1838
4769	y	1838
4770	n	1839
4771	m	1839
4772	k	1839
4773	x	1840
4774	y	1840
4775	n	1841
4776	m	1841
4777	k	1841
4778	x	1842
4779	y	1842
4780	n	1843
4781	m	1843
4782	k	1843
4783	x	1844
4784	y	1844
4785	n	1845
4786	m	1845
4787	k	1845
4788	x	1846
4789	y	1846
4790	n	1847
4791	m	1847
4792	k	1847
4793	x	1848
4794	y	1848
4795	n	1849
4796	m	1849
4797	k	1849
4798	x	1850
4799	y	1850
4800	n	1851
4801	m	1851
4802	k	1851
4803	x	1852
4804	y	1852
4805	n	1853
4806	m	1853
4807	k	1853
4808	x	1854
4809	y	1854
4810	n	1855
4811	m	1855
4812	k	1855
4813	x	1856
4814	y	1856
4815	n	1857
4816	m	1857
4817	k	1857
4818	x	1858
4819	y	1858
4820	n	1859
4821	m	1859
4822	k	1859
4823	x	1860
4824	y	1860
4825	n	1861
4826	m	1861
4827	k	1861
4828	x	1862
4829	y	1862
4830	n	1863
4831	m	1863
4832	k	1863
4833	x	1864
4834	y	1864
4835	n	1865
4836	m	1865
4837	k	1865
4838	x	1866
4839	y	1866
4840	n	1867
4841	m	1867
4842	k	1867
4843	x	1868
4844	y	1868
4845	n	1869
4846	m	1869
4847	k	1869
4848	x	1870
4849	y	1870
4850	n	1871
4851	m	1871
4852	k	1871
4853	x	1872
4854	y	1872
4855	n	1873
4856	m	1873
4857	k	1873
4858	x	1874
4859	y	1874
4860	n	1875
4861	m	1875
4862	k	1875
4863	x	1876
4864	y	1876
4865	n	1877
4866	m	1877
4867	k	1877
4868	x	1878
4869	y	1878
4870	n	1879
4871	m	1879
4872	k	1879
4873	x	1880
4874	y	1880
4875	n	1881
4876	m	1881
4877	k	1881
4878	x	1882
4879	y	1882
4880	n	1883
4881	m	1883
4882	k	1883
4883	x	1884
4884	y	1884
4885	n	1885
4886	m	1885
4887	k	1885
4888	x	1886
4889	y	1886
4890	n	1887
4891	m	1887
4892	k	1887
4893	x	1888
4894	y	1888
4895	n	1889
4896	m	1889
4897	k	1889
4898	x	1890
4899	y	1890
4900	n	1891
4901	m	1891
4902	k	1891
4903	x	1892
4904	y	1892
4905	n	1893
4906	m	1893
4907	k	1893
4908	x	1894
4909	y	1894
4910	n	1895
4911	m	1895
4912	k	1895
4913	x	1896
4914	y	1896
4915	n	1897
4916	m	1897
4917	k	1897
4918	x	1898
4919	y	1898
4920	n	1899
4921	m	1899
4922	k	1899
4923	x	1900
4924	y	1900
4925	n	1901
4926	m	1901
4927	k	1901
4928	x	1902
4929	y	1902
4930	n	1903
4931	m	1903
4932	k	1903
4933	x	1904
4934	y	1904
4935	n	1905
4936	m	1905
4937	k	1905
4938	x	1906
4939	y	1906
4940	n	1907
4941	m	1907
4942	k	1907
4943	x	1908
4944	y	1908
4945	n	1909
4946	m	1909
4947	k	1909
4948	x	1910
4949	y	1910
4950	n	1911
4951	m	1911
4952	k	1911
4953	x	1912
4954	y	1912
4955	n	1913
4956	m	1913
4957	k	1913
4958	x	1914
4959	y	1914
4960	n	1915
4961	m	1915
4962	k	1915
4963	x	1916
4964	y	1916
4965	n	1917
4966	m	1917
4967	k	1917
4968	x	1918
4969	y	1918
4970	n	1919
4971	m	1919
4972	k	1919
4973	x	1920
4974	y	1920
4975	n	1921
4976	m	1921
4977	k	1921
4978	x	1922
4979	y	1922
4980	n	1923
4981	m	1923
4982	k	1923
4983	x	1924
4984	y	1924
4985	n	1925
4986	m	1925
4987	k	1925
4988	x	1926
4989	y	1926
4990	n	1927
4991	m	1927
4992	k	1927
4993	x	1928
4994	y	1928
4995	n	1929
4996	m	1929
4997	k	1929
4998	x	1930
4999	y	1930
5000	n	1931
5001	m	1931
5002	k	1931
5003	x	1932
5004	y	1932
5005	n	1933
5006	m	1933
5007	k	1933
5008	x	1934
5009	y	1934
5010	n	1935
5011	m	1935
5012	k	1935
5013	x	1936
5014	y	1936
5015	n	1937
5016	m	1937
5017	k	1937
5018	n	1938
5019	m	1938
5020	k	1938
5021	n	1939
5022	m	1939
5023	k	1939
5024	n	1940
5025	m	1940
5026	k	1940
5027	x	1941
5028	y	1941
5029	n	1942
5030	m	1942
5031	k	1942
5032	x	1943
5033	y	1943
5034	n	1944
5035	m	1944
5036	k	1944
5037	n	1945
5038	m	1945
5039	k	1945
5040	x	1946
5041	y	1946
5042	n	1947
5043	m	1947
5044	k	1947
5045	x	1948
5046	y	1948
5047	n	1949
5048	m	1949
5049	k	1949
5050	x	1950
5051	y	1950
5052	n	1951
5053	m	1951
5054	k	1951
5055	x	1952
5056	y	1952
5057	n	1953
5058	m	1953
5059	k	1953
5060	x	1954
5061	y	1954
5062	n	1955
5063	m	1955
5064	k	1955
5065	n	1956
5066	m	1956
5067	k	1956
5068	x	1957
5069	y	1957
5070	n	1958
5071	m	1958
5072	k	1958
5073	x	1959
5074	y	1959
5075	n	1960
5076	m	1960
5077	k	1960
5078	n	1961
5079	m	1961
5080	k	1961
5081	x	1962
5082	y	1962
5083	n	1963
5084	m	1963
5085	k	1963
5086	x	1964
5087	y	1964
5088	n	1965
5089	m	1965
5090	k	1965
5091	x	1966
5092	y	1966
5093	n	1967
5094	m	1967
5095	k	1967
5096	x	1968
5097	y	1968
5098	n	1969
5099	m	1969
5100	k	1969
5101	n	1970
5102	m	1970
5103	k	1970
5104	n	1971
5105	m	1971
5106	k	1971
5107	x	1972
5108	y	1972
5109	n	1973
5110	m	1973
5111	k	1973
5112	n	1974
5113	m	1974
5114	k	1974
5115	x	1975
5116	y	1975
5117	n	1976
5118	m	1976
5119	k	1976
5120	n	1977
5121	m	1977
5122	k	1977
5123	x	1978
5124	y	1978
5125	n	1979
5126	m	1979
5127	k	1979
5128	n	1980
5129	m	1980
5130	k	1980
5131	x	1981
5132	y	1981
5133	n	1982
5134	m	1982
5135	k	1982
5136	x	1983
5137	y	1983
5138	n	1984
5139	m	1984
5140	k	1984
5141	x	1985
5142	y	1985
5143	n	1986
5144	m	1986
5145	k	1986
5146	x	1987
5147	y	1987
5148	n	1988
5149	m	1988
5150	k	1988
5151	n	1989
5152	m	1989
5153	k	1989
5154	x	1990
5155	y	1990
5156	n	1991
5157	m	1991
5158	k	1991
5159	n	1992
5160	m	1992
5161	k	1992
5162	x	1993
5163	y	1993
5164	n	1994
5165	m	1994
5166	k	1994
5167	n	1995
5168	m	1995
5169	k	1995
5170	x	1996
5171	y	1996
5172	n	1997
5173	m	1997
5174	k	1997
5175	x	1998
5176	y	1998
5177	n	1999
5178	m	1999
5179	k	1999
5180	x	2000
5181	y	2000
5182	n	2001
5183	m	2001
5184	k	2001
5185	x	2002
5186	y	2002
5187	n	2003
5188	m	2003
5189	k	2003
5190	x	2004
5191	y	2004
5192	n	2005
5193	m	2005
5194	k	2005
5195	x	2006
5196	y	2006
5197	n	2007
5198	m	2007
5199	k	2007
5200	x	2008
5201	y	2008
5202	n	2009
5203	m	2009
5204	k	2009
5205	x	2010
5206	y	2010
5207	n	2011
5208	m	2011
5209	k	2011
5210	x	2012
5211	y	2012
5212	n	2013
5213	m	2013
5214	k	2013
5215	n	2014
5216	m	2014
5217	k	2014
5218	n	2015
5219	m	2015
5220	k	2015
5221	x	2016
5222	y	2016
5223	n	2017
5224	m	2017
5225	k	2017
5226	n	2018
5227	m	2018
5228	k	2018
5229	x	2019
5230	y	2019
5231	n	2020
5232	m	2020
5233	k	2020
5234	n	2021
5235	m	2021
5236	k	2021
5237	x	2022
5238	y	2022
5239	n	2023
5240	m	2023
5241	k	2023
5242	n	2024
5243	m	2024
5244	k	2024
5245	x	2025
5246	y	2025
5247	n	2026
5248	m	2026
5249	k	2026
5250	n	2027
5251	m	2027
5252	k	2027
5253	x	2028
5254	y	2028
5255	n	2029
5256	m	2029
5257	k	2029
5258	x	2030
5259	y	2030
5260	n	2031
5261	m	2031
5262	k	2031
5263	x	2032
5264	y	2032
5265	n	2033
5266	m	2033
5267	k	2033
5268	x	2034
5269	y	2034
5270	n	2035
5271	m	2035
5272	k	2035
5273	x	2036
5274	y	2036
5275	n	2037
5276	m	2037
5277	k	2037
5278	x	2038
5279	y	2038
5280	n	2039
5281	m	2039
5282	k	2039
5283	x	2040
5284	y	2040
5285	n	2041
5286	m	2041
5287	k	2041
5288	x	2042
5289	y	2042
5290	n	2043
5291	m	2043
5292	k	2043
5293	x	2044
5294	y	2044
5295	n	2045
5296	m	2045
5297	k	2045
5298	x	2046
5299	y	2046
5300	n	2047
5301	m	2047
5302	k	2047
5303	x	2048
5304	y	2048
5305	n	2049
5306	m	2049
5307	k	2049
5308	n	2050
5309	m	2050
5310	k	2050
5311	x	2051
5312	y	2051
5313	n	2052
5314	m	2052
5315	k	2052
5316	n	2053
5317	m	2053
5318	k	2053
5319	x	2054
5320	y	2054
5321	n	2055
5322	m	2055
5323	k	2055
5324	x	2056
5325	y	2056
5326	n	2057
5327	m	2057
5328	k	2057
5329	x	2058
5330	y	2058
5331	n	2059
5332	m	2059
5333	k	2059
5334	x	2060
5335	y	2060
5336	n	2061
5337	m	2061
5338	k	2061
5339	x	2062
5340	y	2062
5341	n	2063
5342	m	2063
5343	k	2063
5344	x	2064
5345	y	2064
5346	n	2065
5347	m	2065
5348	k	2065
5349	x	2066
5350	y	2066
5351	n	2067
5352	m	2067
5353	k	2067
5354	x	2068
5355	y	2068
5356	n	2069
5357	m	2069
5358	k	2069
5359	x	2070
5360	y	2070
5361	n	2071
5362	m	2071
5363	k	2071
5364	x	2072
5365	y	2072
5366	n	2073
5367	m	2073
5368	k	2073
5369	x	2074
5370	y	2074
5371	n	2075
5372	m	2075
5373	k	2075
5374	x	2076
5375	y	2076
5376	n	2077
5377	m	2077
5378	k	2077
5379	x	2078
5380	y	2078
5381	n	2079
5382	m	2079
5383	k	2079
5384	x	2080
5385	y	2080
5386	n	2081
5387	m	2081
5388	k	2081
5389	x	2082
5390	y	2082
5391	n	2083
5392	m	2083
5393	k	2083
5394	x	2084
5395	y	2084
5396	n	2085
5397	m	2085
5398	k	2085
5399	x	2086
5400	y	2086
5401	n	2087
5402	m	2087
5403	k	2087
5404	x	2088
5405	y	2088
5406	n	2089
5407	m	2089
5408	k	2089
5409	x	2090
5410	y	2090
5411	n	2091
5412	m	2091
5413	k	2091
5414	x	2092
5415	y	2092
5416	n	2093
5417	m	2093
5418	k	2093
5419	x	2094
5420	y	2094
5421	n	2095
5422	m	2095
5423	k	2095
5424	x	2096
5425	y	2096
5426	n	2097
5427	m	2097
5428	k	2097
5429	x	2098
5430	y	2098
5431	n	2099
5432	m	2099
5433	k	2099
5434	x	2100
5435	y	2100
5436	n	2101
5437	m	2101
5438	k	2101
5439	x	2102
5440	y	2102
5441	n	2103
5442	m	2103
5443	k	2103
5444	x	2104
5445	y	2104
5446	n	2105
5447	m	2105
5448	k	2105
5449	x	2106
5450	y	2106
5451	n	2107
5452	m	2107
5453	k	2107
5454	x	2108
5455	y	2108
5456	n	2109
5457	m	2109
5458	k	2109
5459	x	2110
5460	y	2110
5461	n	2111
5462	m	2111
5463	k	2111
5464	x	2112
5465	y	2112
5466	n	2113
5467	m	2113
5468	k	2113
5469	x	2114
5470	y	2114
5471	n	2115
5472	m	2115
5473	k	2115
5474	x	2116
5475	y	2116
5476	n	2117
5477	m	2117
5478	k	2117
5479	x	2118
5480	y	2118
5481	n	2119
5482	m	2119
5483	k	2119
5484	x	2120
5485	y	2120
5486	n	2121
5487	m	2121
5488	k	2121
5489	x	2122
5490	y	2122
5491	n	2123
5492	m	2123
5493	k	2123
5494	x	2124
5495	y	2124
5496	n	2125
5497	m	2125
5498	k	2125
5499	x	2126
5500	y	2126
5501	n	2127
5502	m	2127
5503	k	2127
5504	x	2128
5505	y	2128
5506	n	2129
5507	m	2129
5508	k	2129
5509	x	2130
5510	y	2130
5511	n	2131
5512	m	2131
5513	k	2131
5514	x	2132
5515	y	2132
5516	n	2133
5517	m	2133
5518	k	2133
5519	x	2134
5520	y	2134
5521	n	2135
5522	m	2135
5523	k	2135
5524	x	2136
5525	y	2136
5526	n	2137
5527	m	2137
5528	k	2137
5529	x	2138
5530	y	2138
5531	n	2139
5532	m	2139
5533	k	2139
5534	x	2140
5535	y	2140
5536	n	2141
5537	m	2141
5538	k	2141
5539	x	2142
5540	y	2142
5541	n	2143
5542	m	2143
5543	k	2143
5544	x	2144
5545	y	2144
5546	n	2145
5547	m	2145
5548	k	2145
5549	x	2146
5550	y	2146
5551	n	2147
5552	m	2147
5553	k	2147
5554	x	2148
5555	y	2148
5556	n	2149
5557	m	2149
5558	k	2149
5559	x	2150
5560	y	2150
5561	n	2151
5562	m	2151
5563	k	2151
5564	x	2152
5565	y	2152
5566	n	2153
5567	m	2153
5568	k	2153
5569	x	2154
5570	y	2154
5571	n	2155
5572	m	2155
5573	k	2155
5574	x	2156
5575	y	2156
5576	n	2157
5577	m	2157
5578	k	2157
5579	x	2158
5580	y	2158
5581	n	2159
5582	m	2159
5583	k	2159
5584	x	2160
5585	y	2160
5586	n	2161
5587	m	2161
5588	k	2161
5589	x	2162
5590	y	2162
5591	n	2163
5592	m	2163
5593	k	2163
5594	x	2164
5595	y	2164
5596	n	2165
5597	m	2165
5598	k	2165
5599	x	2166
5600	y	2166
5601	n	2167
5602	m	2167
5603	k	2167
5604	x	2168
5605	y	2168
5606	n	2169
5607	m	2169
5608	k	2169
5609	x	2170
5610	y	2170
5611	n	2171
5612	m	2171
5613	k	2171
5614	x	2172
5615	y	2172
5616	n	2173
5617	m	2173
5618	k	2173
5619	x	2174
5620	y	2174
5621	n	2175
5622	m	2175
5623	k	2175
5624	x	2176
5625	y	2176
5626	n	2177
5627	m	2177
5628	k	2177
5629	x	2178
5630	y	2178
5631	n	2179
5632	m	2179
5633	k	2179
5634	x	2180
5635	y	2180
5636	n	2181
5637	m	2181
5638	k	2181
5639	x	2182
5640	y	2182
5641	n	2183
5642	m	2183
5643	k	2183
5644	x	2184
5645	y	2184
5646	n	2185
5647	m	2185
5648	k	2185
5649	x	2186
5650	y	2186
5651	n	2187
5652	m	2187
5653	k	2187
5654	x	2188
5655	y	2188
5656	n	2189
5657	m	2189
5658	k	2189
5659	x	2190
5660	y	2190
5661	n	2191
5662	m	2191
5663	k	2191
5664	x	2192
5665	y	2192
5666	n	2193
5667	m	2193
5668	k	2193
5669	x	2194
5670	y	2194
5671	n	2195
5672	m	2195
5673	k	2195
5674	x	2196
5675	y	2196
5676	n	2197
5677	m	2197
5678	k	2197
5679	x	2198
5680	y	2198
5681	n	2199
5682	m	2199
5683	k	2199
5684	x	2200
5685	y	2200
5686	n	2201
5687	m	2201
5688	k	2201
5689	x	2202
5690	y	2202
5691	n	2203
5692	m	2203
5693	k	2203
5694	x	2204
5695	y	2204
5696	n	2205
5697	m	2205
5698	k	2205
5699	x	2206
5700	y	2206
5701	n	2207
5702	m	2207
5703	k	2207
5704	x	2208
5705	y	2208
5706	n	2209
5707	m	2209
5708	k	2209
5709	x	2210
5710	y	2210
5711	n	2211
5712	m	2211
5713	k	2211
5714	x	2212
5715	y	2212
5716	n	2213
5717	m	2213
5718	k	2213
5719	x	2214
5720	y	2214
5721	n	2215
5722	m	2215
5723	k	2215
5724	x	2216
5725	y	2216
5726	n	2217
5727	m	2217
5728	k	2217
5729	x	2218
5730	y	2218
5731	n	2219
5732	m	2219
5733	k	2219
5734	x	2220
5735	y	2220
5736	n	2221
5737	m	2221
5738	k	2221
5739	x	2222
5740	y	2222
5741	n	2223
5742	m	2223
5743	k	2223
5744	x	2224
5745	y	2224
5746	n	2225
5747	m	2225
5748	k	2225
5749	x	2226
5750	y	2226
5751	n	2227
5752	m	2227
5753	k	2227
5754	x	2228
5755	y	2228
5756	n	2229
5757	m	2229
5758	k	2229
5759	x	2230
5760	y	2230
5761	n	2231
5762	m	2231
5763	k	2231
5764	x	2232
5765	y	2232
5766	n	2233
5767	m	2233
5768	k	2233
5769	x	2234
5770	y	2234
5771	n	2235
5772	m	2235
5773	k	2235
5774	x	2236
5775	y	2236
5776	n	2237
5777	m	2237
5778	k	2237
5779	x	2238
5780	y	2238
5781	n	2239
5782	m	2239
5783	k	2239
5784	x	2240
5785	y	2240
5786	n	2241
5787	m	2241
5788	k	2241
5789	x	2242
5790	y	2242
5791	n	2243
5792	m	2243
5793	k	2243
5794	x	2244
5795	y	2244
5796	n	2245
5797	m	2245
5798	k	2245
5799	x	2246
5800	y	2246
5801	n	2247
5802	m	2247
5803	k	2247
5804	x	2248
5805	y	2248
5806	n	2249
5807	m	2249
5808	k	2249
5809	x	2250
5810	y	2250
5811	n	2251
5812	m	2251
5813	k	2251
5814	x	2252
5815	y	2252
5816	n	2253
5817	m	2253
5818	k	2253
5819	x	2254
5820	y	2254
5821	n	2255
5822	m	2255
5823	k	2255
5824	x	2256
5825	y	2256
5826	n	2257
5827	m	2257
5828	k	2257
5829	x	2258
5830	y	2258
5831	n	2259
5832	m	2259
5833	k	2259
5834	x	2260
5835	y	2260
5836	n	2261
5837	m	2261
5838	k	2261
5839	x	2262
5840	y	2262
5841	n	2263
5842	m	2263
5843	k	2263
5844	x	2264
5845	y	2264
5846	n	2265
5847	m	2265
5848	k	2265
5849	x	2266
5850	y	2266
5851	n	2267
5852	m	2267
5853	k	2267
5854	x	2268
5855	y	2268
5856	n	2269
5857	m	2269
5858	k	2269
5859	x	2270
5860	y	2270
5861	n	2271
5862	m	2271
5863	k	2271
5864	x	2272
5865	y	2272
5866	n	2273
5867	m	2273
5868	k	2273
5869	x	2274
5870	y	2274
5871	n	2275
5872	m	2275
5873	k	2275
5874	x	2276
5875	y	2276
5876	n	2277
5877	m	2277
5878	k	2277
5879	x	2278
5880	y	2278
5881	n	2279
5882	m	2279
5883	k	2279
5884	x	2280
5885	y	2280
5886	n	2281
5887	m	2281
5888	k	2281
5889	x	2282
5890	y	2282
5891	n	2283
5892	m	2283
5893	k	2283
5894	x	2284
5895	y	2284
5896	n	2285
5897	m	2285
5898	k	2285
5899	x	2286
5900	y	2286
5901	n	2287
5902	m	2287
5903	k	2287
5904	x	2288
5905	y	2288
5906	n	2289
5907	m	2289
5908	k	2289
5909	x	2290
5910	y	2290
5911	n	2291
5912	m	2291
5913	k	2291
5914	x	2292
5915	y	2292
5916	n	2293
5917	m	2293
5918	k	2293
5919	x	2294
5920	y	2294
5921	n	2295
5922	m	2295
5923	k	2295
5924	x	2296
5925	y	2296
5926	n	2297
5927	m	2297
5928	k	2297
5929	x	2298
5930	y	2298
5931	n	2299
5932	m	2299
5933	k	2299
5934	x	2300
5935	y	2300
5936	n	2301
5937	m	2301
5938	k	2301
5939	x	2302
5940	y	2302
5941	n	2303
5942	m	2303
5943	k	2303
5944	x	2304
5945	y	2304
5946	n	2305
5947	m	2305
5948	k	2305
5949	x	2306
5950	y	2306
5951	n	2307
5952	m	2307
5953	k	2307
5954	x	2308
5955	y	2308
5956	n	2309
5957	m	2309
5958	k	2309
5959	x	2310
5960	y	2310
5961	n	2311
5962	m	2311
5963	k	2311
5964	x	2312
5965	y	2312
5966	n	2313
5967	m	2313
5968	k	2313
5969	x	2314
5970	y	2314
5971	n	2315
5972	m	2315
5973	k	2315
5974	x	2316
5975	y	2316
5976	n	2317
5977	m	2317
5978	k	2317
5979	x	2318
5980	y	2318
5981	n	2319
5982	m	2319
5983	k	2319
5984	x	2320
5985	y	2320
5986	n	2321
5987	m	2321
5988	k	2321
5989	x	2322
5990	y	2322
5991	n	2323
5992	m	2323
5993	k	2323
5994	x	2324
5995	y	2324
5996	n	2325
5997	m	2325
5998	k	2325
5999	x	2326
6000	y	2326
6001	n	2327
6002	m	2327
6003	k	2327
6004	x	2328
6005	y	2328
6006	n	2329
6007	m	2329
6008	k	2329
6009	x	2330
6010	y	2330
6011	n	2331
6012	m	2331
6013	k	2331
6014	x	2332
6015	y	2332
6016	n	2333
6017	m	2333
6018	k	2333
6019	x	2334
6020	y	2334
6021	n	2335
6022	m	2335
6023	k	2335
6024	x	2336
6025	y	2336
6026	n	2337
6027	m	2337
6028	k	2337
6029	x	2338
6030	y	2338
6031	n	2339
6032	m	2339
6033	k	2339
6034	x	2340
6035	y	2340
6036	n	2341
6037	m	2341
6038	k	2341
6039	x	2342
6040	y	2342
6041	n	2343
6042	m	2343
6043	k	2343
6044	x	2344
6045	y	2344
6046	n	2345
6047	m	2345
6048	k	2345
6049	x	2346
6050	y	2346
6051	n	2347
6052	m	2347
6053	k	2347
6054	x	2348
6055	y	2348
6056	n	2349
6057	m	2349
6058	k	2349
6059	x	2350
6060	y	2350
6061	n	2351
6062	m	2351
6063	k	2351
6064	x	2352
6065	y	2352
6066	n	2353
6067	m	2353
6068	k	2353
6069	x	2354
6070	y	2354
6071	n	2355
6072	m	2355
6073	k	2355
6074	x	2356
6075	y	2356
6076	n	2357
6077	m	2357
6078	k	2357
6079	x	2358
6080	y	2358
6081	n	2359
6082	m	2359
6083	k	2359
6084	x	2360
6085	y	2360
6086	n	2361
6087	m	2361
6088	k	2361
6089	x	2362
6090	y	2362
6091	n	2363
6092	m	2363
6093	k	2363
6094	x	2364
6095	y	2364
6096	n	2365
6097	m	2365
6098	k	2365
6099	x	2366
6100	y	2366
6101	n	2367
6102	m	2367
6103	k	2367
6104	x	2368
6105	y	2368
6106	n	2369
6107	m	2369
6108	k	2369
6109	x	2370
6110	y	2370
6111	n	2371
6112	m	2371
6113	k	2371
6114	x	2372
6115	y	2372
6116	n	2373
6117	m	2373
6118	k	2373
6119	x	2374
6120	y	2374
6121	n	2375
6122	m	2375
6123	k	2375
6124	x	2376
6125	y	2376
6126	n	2377
6127	m	2377
6128	k	2377
6129	x	2378
6130	y	2378
6131	n	2379
6132	m	2379
6133	k	2379
6134	x	2380
6135	y	2380
6136	n	2381
6137	m	2381
6138	k	2381
6139	x	2382
6140	y	2382
6141	n	2383
6142	m	2383
6143	k	2383
6144	x	2384
6145	y	2384
6146	n	2385
6147	m	2385
6148	k	2385
6149	x	2386
6150	y	2386
6151	n	2387
6152	m	2387
6153	k	2387
6154	x	2388
6155	y	2388
6156	n	2389
6157	m	2389
6158	k	2389
6159	x	2390
6160	y	2390
6161	n	2391
6162	m	2391
6163	k	2391
6164	x	2392
6165	y	2392
6166	n	2393
6167	m	2393
6168	k	2393
6169	x	2394
6170	y	2394
6171	n	2395
6172	m	2395
6173	k	2395
6174	x	2396
6175	y	2396
6176	n	2397
6177	m	2397
6178	k	2397
6179	x	2398
6180	y	2398
6181	n	2399
6182	m	2399
6183	k	2399
6184	x	2400
6185	y	2400
6186	n	2401
6187	m	2401
6188	k	2401
6189	x	2402
6190	y	2402
6191	n	2403
6192	m	2403
6193	k	2403
6194	x	2404
6195	y	2404
6196	n	2405
6197	m	2405
6198	k	2405
6199	x	2406
6200	y	2406
6201	n	2407
6202	m	2407
6203	k	2407
6204	x	2408
6205	y	2408
6206	n	2409
6207	m	2409
6208	k	2409
6209	x	2410
6210	y	2410
6211	n	2411
6212	m	2411
6213	k	2411
6214	x	2412
6215	y	2412
6216	n	2413
6217	m	2413
6218	k	2413
6219	x	2414
6220	y	2414
6221	n	2415
6222	m	2415
6223	k	2415
6224	x	2416
6225	y	2416
6226	n	2417
6227	m	2417
6228	k	2417
6229	x	2418
6230	y	2418
6231	n	2419
6232	m	2419
6233	k	2419
6234	x	2420
6235	y	2420
6236	n	2421
6237	m	2421
6238	k	2421
6239	x	2422
6240	y	2422
6241	n	2423
6242	m	2423
6243	k	2423
6244	x	2424
6245	y	2424
6246	n	2425
6247	m	2425
6248	k	2425
6249	x	2426
6250	y	2426
6251	n	2427
6252	m	2427
6253	k	2427
6254	x	2428
6255	y	2428
6256	n	2429
6257	m	2429
6258	k	2429
6259	x	2430
6260	y	2430
6261	n	2431
6262	m	2431
6263	k	2431
6264	x	2432
6265	y	2432
6266	n	2433
6267	m	2433
6268	k	2433
6269	x	2434
6270	y	2434
6271	n	2435
6272	m	2435
6273	k	2435
6274	x	2436
6275	y	2436
6276	n	2437
6277	m	2437
6278	k	2437
6279	x	2438
6280	y	2438
6281	n	2439
6282	m	2439
6283	k	2439
6284	x	2440
6285	y	2440
6286	n	2441
6287	m	2441
6288	k	2441
6289	x	2442
6290	y	2442
6291	n	2443
6292	m	2443
6293	k	2443
6294	x	2444
6295	y	2444
6296	n	2445
6297	m	2445
6298	k	2445
6299	x	2446
6300	y	2446
6301	n	2447
6302	m	2447
6303	k	2447
6304	x	2448
6305	y	2448
6306	n	2449
6307	m	2449
6308	k	2449
6309	x	2450
6310	y	2450
6311	n	2451
6312	m	2451
6313	k	2451
6314	x	2452
6315	y	2452
6316	n	2453
6317	m	2453
6318	k	2453
6319	x	2454
6320	y	2454
6321	n	2455
6322	m	2455
6323	k	2455
6324	x	2456
6325	y	2456
6326	n	2457
6327	m	2457
6328	k	2457
6329	x	2458
6330	y	2458
6331	n	2459
6332	m	2459
6333	k	2459
6334	x	2460
6335	y	2460
6336	n	2461
6337	m	2461
6338	k	2461
6339	x	2462
6340	y	2462
6341	n	2463
6342	m	2463
6343	k	2463
6344	x	2464
6345	y	2464
6346	n	2465
6347	m	2465
6348	k	2465
6349	x	2466
6350	y	2466
6351	n	2467
6352	m	2467
6353	k	2467
6354	x	2468
6355	y	2468
6356	n	2469
6357	m	2469
6358	k	2469
6359	x	2470
6360	y	2470
6361	n	2471
6362	m	2471
6363	k	2471
6364	x	2472
6365	y	2472
6366	n	2473
6367	m	2473
6368	k	2473
6369	x	2474
6370	y	2474
6371	n	2475
6372	m	2475
6373	k	2475
6374	x	2476
6375	y	2476
6376	n	2477
6377	m	2477
6378	k	2477
6379	x	2478
6380	y	2478
6381	n	2479
6382	m	2479
6383	k	2479
6384	x	2480
6385	y	2480
6386	n	2481
6387	m	2481
6388	k	2481
6389	x	2482
6390	y	2482
6391	n	2483
6392	m	2483
6393	k	2483
6394	x	2484
6395	y	2484
6396	n	2485
6397	m	2485
6398	k	2485
6399	x	2486
6400	y	2486
6401	n	2487
6402	m	2487
6403	k	2487
6404	x	2488
6405	y	2488
6406	n	2489
6407	m	2489
6408	k	2489
6409	x	2490
6410	y	2490
6411	n	2491
6412	m	2491
6413	k	2491
6414	x	2492
6415	y	2492
6416	n	2493
6417	m	2493
6418	k	2493
6419	x	2494
6420	y	2494
6421	n	2495
6422	m	2495
6423	k	2495
6424	x	2496
6425	y	2496
6426	n	2497
6427	m	2497
6428	k	2497
6429	x	2498
6430	y	2498
6431	n	2499
6432	m	2499
6433	k	2499
6434	x	2500
6435	y	2500
6436	n	2501
6437	m	2501
6438	k	2501
6439	x	2502
6440	y	2502
6441	n	2503
6442	m	2503
6443	k	2503
6444	x	2504
6445	y	2504
6446	n	2505
6447	m	2505
6448	k	2505
6449	x	2506
6450	y	2506
6451	n	2507
6452	m	2507
6453	k	2507
6454	x	2508
6455	y	2508
6456	n	2509
6457	m	2509
6458	k	2509
6459	x	2510
6460	y	2510
6461	n	2511
6462	m	2511
6463	k	2511
6464	x	2512
6465	y	2512
6466	n	2513
6467	m	2513
6468	k	2513
6469	n	2514
6470	m	2514
6471	k	2514
6472	n	2515
6473	m	2515
6474	k	2515
6475	x	2516
6476	y	2516
6477	n	2517
6478	m	2517
6479	k	2517
6486	x	2520
6487	y	2520
6488	n	2521
6489	m	2521
6490	k	2521
6491	n	2522
6492	m	2522
6493	k	2522
6494	n	2523
6495	m	2523
6496	k	2523
6497	x	2524
6498	y	2524
6499	n	2525
6500	m	2525
6501	k	2525
6502	n	2526
6503	m	2526
6504	k	2526
6505	n	2527
6506	m	2527
6507	k	2527
6508	x	2528
6509	y	2528
6510	n	2529
6511	m	2529
6512	k	2529
6513	x	2530
6514	y	2530
6515	n	2531
6516	m	2531
6517	k	2531
6518	n	2532
6519	m	2532
6520	k	2532
6521	n	2533
6522	m	2533
6523	k	2533
6524	x	2534
6525	y	2534
6526	n	2535
6527	m	2535
6528	k	2535
6529	n	2536
6530	m	2536
6531	k	2536
6532	n	2537
6533	m	2537
6534	k	2537
6535	x	2538
6536	y	2538
6537	n	2539
6538	m	2539
6539	k	2539
6540	n	2540
6541	m	2540
6542	k	2540
6543	x	2541
6544	y	2541
6545	n	2542
6546	m	2542
6547	k	2542
6548	n	2543
6549	m	2543
6550	k	2543
6551	x	2544
6552	y	2544
6553	n	2545
6554	m	2545
6555	k	2545
6556	n	2546
6557	m	2546
6558	k	2546
6559	x	2547
6560	y	2547
6561	n	2548
6562	m	2548
6563	k	2548
6564	n	2549
6565	m	2549
6566	k	2549
6567	x	2550
6568	y	2550
6569	n	2551
6570	m	2551
6571	k	2551
6572	x	2552
6573	y	2552
6574	n	2553
6575	m	2553
6576	k	2553
6577	n	2554
6578	m	2554
6579	k	2554
6580	x	2555
6581	y	2555
6582	n	2556
6583	m	2556
6584	k	2556
6585	x	2557
6586	y	2557
6587	n	2558
6588	m	2558
6589	k	2558
6590	x	2559
6591	y	2559
6592	n	2560
6593	m	2560
6594	k	2560
6595	n	2561
6596	m	2561
6597	k	2561
6598	x	2562
6599	y	2562
6600	n	2563
6601	m	2563
6602	k	2563
6603	n	2564
6604	m	2564
6605	k	2564
6606	x	2565
6607	y	2565
6608	n	2566
6609	m	2566
6610	k	2566
6611	x	2567
6612	y	2567
6613	n	2568
6614	m	2568
6615	k	2568
6616	x	2569
6617	y	2569
6618	n	2570
6619	m	2570
6620	k	2570
6621	n	2571
6622	m	2571
6623	k	2571
6624	x	2572
6625	y	2572
6626	n	2573
6627	m	2573
6628	k	2573
6644	x	2580
6645	y	2580
6646	n	2581
6647	m	2581
6648	k	2581
6649	x	2582
6650	y	2582
6651	n	2583
6652	m	2583
6653	k	2583
6654	x	2584
6655	y	2584
6656	n	2585
6657	m	2585
6658	k	2585
6659	n	2586
6660	m	2586
6661	k	2586
6662	x	2587
6663	y	2587
6664	n	2588
6665	m	2588
6666	k	2588
6667	x	2589
6668	y	2589
6669	n	2590
6670	m	2590
6671	k	2590
6672	x	2591
6673	y	2591
6674	n	2592
6675	m	2592
6676	k	2592
6677	x	2593
6678	y	2593
6679	n	2594
6680	m	2594
6681	k	2594
6682	x	2595
6683	y	2595
6684	n	2596
6685	m	2596
6686	k	2596
6687	x	2597
6688	y	2597
6689	n	2598
6690	m	2598
6691	k	2598
6692	x	2599
6693	y	2599
6694	n	2600
6695	m	2600
6696	k	2600
6697	x	2601
6698	y	2601
6699	n	2602
6700	m	2602
6701	k	2602
6702	x	2603
6703	y	2603
6704	n	2604
6705	m	2604
6706	k	2604
6707	x	2605
6708	y	2605
6709	n	2606
6710	m	2606
6711	k	2606
6712	x	2607
6713	y	2607
6714	n	2608
6715	m	2608
6716	k	2608
6717	x	2609
6718	y	2609
6719	n	2610
6720	m	2610
6721	k	2610
6722	x	2611
6723	y	2611
6724	n	2612
6725	m	2612
6726	k	2612
6727	x	2613
6728	y	2613
6729	n	2614
6730	m	2614
6731	k	2614
6732	x	2615
6733	y	2615
6734	n	2616
6735	m	2616
6736	k	2616
6737	x	2617
6738	y	2617
6739	n	2618
6740	m	2618
6741	k	2618
6742	x	2619
6743	y	2619
6744	n	2620
6745	m	2620
6746	k	2620
6747	x	2621
6748	y	2621
6749	n	2622
6750	m	2622
6751	k	2622
6752	x	2623
6753	y	2623
6754	n	2624
6755	m	2624
6756	k	2624
6757	x	2625
6758	y	2625
6759	n	2626
6760	m	2626
6761	k	2626
6762	x	2627
6763	y	2627
6764	n	2628
6765	m	2628
6766	k	2628
6767	x	2629
6768	y	2629
6769	n	2630
6770	m	2630
6771	k	2630
6772	x	2631
6773	y	2631
6774	n	2632
6775	m	2632
6776	k	2632
6777	x	2633
6778	y	2633
6779	n	2634
6780	m	2634
6781	k	2634
6782	x	2635
6783	y	2635
6784	n	2636
6785	m	2636
6786	k	2636
6787	x	2637
6788	y	2637
6789	n	2638
6790	m	2638
6791	k	2638
6792	x	2639
6793	y	2639
6794	n	2640
6795	m	2640
6796	k	2640
6797	x	2641
6798	y	2641
6799	n	2642
6800	m	2642
6801	k	2642
6802	x	2643
6803	y	2643
6804	n	2644
6805	m	2644
6806	k	2644
6807	x	2645
6808	y	2645
6809	n	2646
6810	m	2646
6811	k	2646
6812	x	2647
6813	y	2647
6814	n	2648
6815	m	2648
6816	k	2648
6817	x	2649
6818	y	2649
6819	n	2650
6820	m	2650
6821	k	2650
6822	x	2651
6823	y	2651
6824	n	2652
6825	m	2652
6826	k	2652
6827	x	2653
6828	y	2653
6829	n	2654
6830	m	2654
6831	k	2654
6832	x	2655
6833	y	2655
6834	n	2656
6835	m	2656
6836	k	2656
6837	x	2657
6838	y	2657
6839	n	2658
6840	m	2658
6841	k	2658
6842	x	2659
6843	y	2659
6844	n	2660
6845	m	2660
6846	k	2660
6847	x	2661
6848	y	2661
6849	n	2662
6850	m	2662
6851	k	2662
6852	x	2663
6853	y	2663
6854	n	2664
6855	m	2664
6856	k	2664
6857	x	2665
6858	y	2665
6859	n	2666
6860	m	2666
6861	k	2666
6862	x	2667
6863	y	2667
6864	n	2668
6865	m	2668
6866	k	2668
6867	x	2669
6868	y	2669
6869	n	2670
6870	m	2670
6871	k	2670
6872	x	2671
6873	y	2671
6874	n	2672
6875	m	2672
6876	k	2672
6877	x	2673
6878	y	2673
6879	n	2674
6880	m	2674
6881	k	2674
6882	x	2675
6883	y	2675
6884	n	2676
6885	m	2676
6886	k	2676
6887	x	2677
6888	y	2677
6889	n	2678
6890	m	2678
6891	k	2678
6892	x	2679
6893	y	2679
6894	n	2680
6895	m	2680
6896	k	2680
6897	x	2681
6898	y	2681
6899	n	2682
6900	m	2682
6901	k	2682
6902	x	2683
6903	y	2683
6904	n	2684
6905	m	2684
6906	k	2684
6907	x	2685
6908	y	2685
6909	n	2686
6910	m	2686
6911	k	2686
6912	x	2687
6913	y	2687
6914	n	2688
6915	m	2688
6916	k	2688
6917	x	2689
6918	y	2689
6919	n	2690
6920	m	2690
6921	k	2690
6922	x	2691
6923	y	2691
6924	n	2692
6925	m	2692
6926	k	2692
6927	x	2693
6928	y	2693
6929	n	2694
6930	m	2694
6931	k	2694
6932	n	2695
6933	m	2695
6934	k	2695
6935	x	2696
6936	y	2696
6937	n	2697
6938	m	2697
6939	k	2697
6940	n	2698
6941	m	2698
6942	k	2698
6943	n	2699
6944	m	2699
6945	k	2699
6946	x	2700
6947	y	2700
6948	n	2701
6949	m	2701
6950	k	2701
6951	n	2702
6952	m	2702
6953	k	2702
6979	n	2713
6980	m	2713
6981	k	2713
6982	x	2714
6983	y	2714
6984	n	2715
6985	m	2715
6986	k	2715
6987	n	2716
6988	m	2716
6989	k	2716
6990	n	2717
6991	m	2717
6992	k	2717
6993	x	2718
6994	y	2718
6995	n	2719
6996	m	2719
6997	k	2719
6998	x	2720
6999	y	2720
7000	n	2721
7001	m	2721
7002	k	2721
7003	x	2722
7004	y	2722
7005	n	2723
7006	m	2723
7007	k	2723
7008	x	2724
7009	y	2724
7010	n	2725
7011	m	2725
7012	k	2725
7013	x	2726
7014	y	2726
7015	n	2727
7016	m	2727
7017	k	2727
7018	x	2728
7019	y	2728
7020	n	2729
7021	m	2729
7022	k	2729
7023	x	2730
7024	y	2730
7025	n	2731
7026	m	2731
7027	k	2731
7028	x	2732
7029	y	2732
7030	n	2733
7031	m	2733
7032	k	2733
7033	x	2734
7034	y	2734
7035	n	2735
7036	m	2735
7037	k	2735
7038	n	2736
7039	m	2736
7040	k	2736
7041	n	2737
7042	m	2737
7043	k	2737
7044	x	2738
7045	y	2738
7046	n	2739
7047	m	2739
7048	k	2739
7049	x	2740
7050	y	2740
7051	n	2741
7052	m	2741
7053	k	2741
7054	x	2742
7055	y	2742
7056	n	2743
7057	m	2743
7058	k	2743
7059	x	2744
7060	y	2744
7061	n	2745
7062	m	2745
7063	k	2745
7064	x	2746
7065	y	2746
7066	n	2747
7067	m	2747
7068	k	2747
7069	x	2748
7070	y	2748
7071	n	2749
7072	m	2749
7073	k	2749
7074	x	2750
7075	y	2750
7076	n	2751
7077	m	2751
7078	k	2751
7079	x	2752
7080	y	2752
7081	n	2753
7082	m	2753
7083	k	2753
7084	n	2754
7085	m	2754
7086	k	2754
7087	x	2755
7088	y	2755
7089	n	2756
7090	m	2756
7091	k	2756
7092	x	2757
7093	y	2757
7094	n	2758
7095	m	2758
7096	k	2758
7097	n	2759
7098	m	2759
7099	k	2759
7100	n	2760
7101	m	2760
7102	k	2760
7103	x	2761
7104	y	2761
7105	n	2762
7106	m	2762
7107	k	2762
7108	n	2763
7109	m	2763
7110	k	2763
7111	x	2764
7112	y	2764
7113	n	2765
7114	m	2765
7115	k	2765
7116	x	2766
7117	y	2766
7118	n	2767
7119	m	2767
7120	k	2767
7121	x	2768
7122	y	2768
7123	n	2769
7124	m	2769
7125	k	2769
7126	x	2770
7127	y	2770
7128	n	2771
7129	m	2771
7130	k	2771
7131	x	2772
7132	y	2772
7133	n	2773
7134	m	2773
7135	k	2773
7136	x	2774
7137	y	2774
7138	n	2775
7139	m	2775
7140	k	2775
7141	x	2776
7142	y	2776
7143	n	2777
7144	m	2777
7145	k	2777
7151	x	2780
7152	y	2780
7153	n	2781
7154	m	2781
7155	k	2781
7166	n	2786
7167	m	2786
7168	k	2786
7169	n	2787
7170	m	2787
7171	k	2787
7172	n	2788
7173	m	2788
7174	k	2788
7175	n	2789
7176	m	2789
7177	k	2789
7178	n	2790
7179	m	2790
7180	k	2790
7181	n	2791
7182	m	2791
7183	k	2791
7184	n	2792
7185	m	2792
7186	k	2792
7187	n	2793
7188	m	2793
7189	k	2793
7190	n	2794
7191	m	2794
7192	k	2794
7193	n	2795
7194	m	2795
7195	k	2795
7196	n	2796
7197	m	2796
7198	k	2796
7199	n	2797
7200	m	2797
7201	k	2797
7202	n	2798
7203	m	2798
7204	k	2798
7205	n	2799
7206	m	2799
7207	k	2799
7208	n	2800
7209	m	2800
7210	k	2800
7211	n	2801
7212	m	2801
7213	k	2801
7214	n	2802
7215	m	2802
7216	k	2802
7223	n	2805
7224	m	2805
7225	k	2805
7229	n	2807
7230	m	2807
7231	k	2807
7235	n	2809
7236	m	2809
7237	k	2809
7241	n	2811
7242	m	2811
7243	k	2811
7217	n	2803
7218	m	2803
7219	k	2803
7220	n	2804
7221	m	2804
7222	k	2804
7226	n	2806
7227	m	2806
7228	k	2806
7232	n	2808
7233	m	2808
7234	k	2808
7238	n	2810
7239	m	2810
7240	k	2810
7244	n	2812
7245	m	2812
7246	k	2812
7247	x	2813
7248	y	2813
7249	n	2814
7250	m	2814
7251	k	2814
7252	n	2815
7253	m	2815
7254	k	2815
7255	x	2816
7256	y	2816
7257	n	2817
7258	m	2817
7259	k	2817
7260	n	2818
7261	m	2818
7262	k	2818
7263	n	2819
7264	m	2819
7265	k	2819
7266	n	2820
7267	m	2820
7268	k	2820
7269	n	2821
7270	m	2821
7271	k	2821
7272	n	2822
7273	m	2822
7274	k	2822
7275	n	2823
7276	m	2823
7277	k	2823
7278	n	2824
7279	m	2824
7280	k	2824
7281	n	2825
7282	m	2825
7283	k	2825
7284	n	2826
7285	m	2826
7286	k	2826
7287	n	2827
7288	m	2827
7289	k	2827
7290	n	2828
7291	m	2828
7292	k	2828
7293	n	2829
7294	m	2829
7295	k	2829
7296	n	2830
7297	m	2830
7298	k	2830
7299	n	2831
7300	m	2831
7301	k	2831
7302	x	2832
7303	y	2832
7304	n	2833
7305	m	2833
7306	k	2833
7307	n	2834
7308	m	2834
7309	k	2834
7310	n	2835
7311	m	2835
7312	k	2835
7313	x	2836
7314	y	2836
7315	n	2837
7316	m	2837
7317	k	2837
7318	x	2838
7319	y	2838
7320	n	2839
7321	m	2839
7322	k	2839
7323	n	2840
7324	m	2840
7325	k	2840
7326	n	2841
7327	m	2841
7328	k	2841
7329	n	2842
7330	m	2842
7331	k	2842
7332	n	2843
7333	m	2843
7334	k	2843
7335	n	2844
7336	m	2844
7337	k	2844
7338	n	2845
7339	m	2845
7340	k	2845
7341	n	2846
7342	m	2846
7343	k	2846
7344	n	2847
7345	m	2847
7346	k	2847
7347	n	2848
7348	m	2848
7349	k	2848
7350	n	2849
7351	m	2849
7352	k	2849
7353	n	2850
7354	m	2850
7355	k	2850
7356	n	2851
7357	m	2851
7358	k	2851
7359	n	2852
7360	m	2852
7361	k	2852
7362	n	2853
7363	m	2853
7364	k	2853
7365	n	2854
7366	m	2854
7367	k	2854
7368	n	2855
7369	m	2855
7370	k	2855
7371	n	2856
7372	m	2856
7373	k	2856
7374	x	2857
7375	y	2857
7376	n	2858
7377	m	2858
7378	k	2858
7379	n	2859
7380	m	2859
7381	k	2859
7382	n	2860
7383	m	2860
7384	k	2860
7385	x	2861
7386	y	2861
7387	n	2862
7388	m	2862
7389	k	2862
7390	n	2863
7391	m	2863
7392	k	2863
7393	n	2864
7394	m	2864
7395	k	2864
7396	x	2865
7397	y	2865
7398	n	2866
7399	m	2866
7400	k	2866
7401	n	2867
7402	m	2867
7403	k	2867
7404	n	2868
7405	m	2868
7406	k	2868
7407	x	2869
7408	y	2869
7409	n	2870
7410	m	2870
7411	k	2870
7412	n	2871
7413	m	2871
7414	k	2871
7415	n	2872
7416	m	2872
7417	k	2872
7430	n	2877
7431	m	2877
7432	k	2877
7433	n	2878
7434	m	2878
7435	k	2878
7436	n	2879
7437	m	2879
7438	k	2879
7439	n	2880
7440	m	2880
7441	k	2880
7442	n	2881
7443	m	2881
7444	k	2881
7445	n	2882
7446	m	2882
7447	k	2882
7454	n	2885
7455	m	2885
7456	k	2885
7457	n	2886
7458	m	2886
7459	k	2886
7460	n	2887
7461	m	2887
7462	k	2887
7463	n	2888
7464	m	2888
7465	k	2888
7475	n	2892
7476	m	2892
7477	k	2892
7478	n	2893
7479	m	2893
7480	k	2893
7481	n	2894
7482	m	2894
7483	k	2894
7484	n	2895
7485	m	2895
7486	k	2895
7498	n	2900
7499	m	2900
7500	k	2900
7501	n	2901
7502	m	2901
7503	k	2901
7509	n	2904
7510	m	2904
7511	k	2904
7512	n	2905
7513	m	2905
7514	k	2905
7418	n	2873
7419	m	2873
7420	k	2873
7421	n	2874
7422	m	2874
7423	k	2874
7424	n	2875
7425	m	2875
7426	k	2875
7427	n	2876
7428	m	2876
7429	k	2876
7448	n	2883
7449	m	2883
7450	k	2883
7451	n	2884
7452	m	2884
7453	k	2884
7466	n	2889
7467	m	2889
7468	k	2889
7469	n	2890
7470	m	2890
7471	k	2890
7472	n	2891
7473	m	2891
7474	k	2891
7487	n	2896
7488	m	2896
7489	k	2896
7490	x	2897
7491	y	2897
7492	n	2898
7493	m	2898
7494	k	2898
7495	n	2899
7496	m	2899
7497	k	2899
7504	x	2902
7505	y	2902
7506	n	2903
7507	m	2903
7508	k	2903
7515	x	2906
7516	y	2906
7517	n	2907
7518	m	2907
7519	k	2907
7520	x	2908
7521	y	2908
7522	n	2909
7523	m	2909
7524	k	2909
7525	x	2910
7526	y	2910
7527	n	2911
7528	m	2911
7529	k	2911
7530	x	2912
7531	y	2912
7532	n	2913
7533	m	2913
7534	k	2913
7535	x	2914
7536	y	2914
7537	n	2915
7538	m	2915
7539	k	2915
7540	x	2916
7541	y	2916
7542	n	2917
7543	m	2917
7544	k	2917
7545	x	2918
7546	y	2918
7547	n	2919
7548	m	2919
7549	k	2919
7550	x	2920
7551	y	2920
7552	n	2921
7553	m	2921
7554	k	2921
7555	x	2922
7556	y	2922
7557	n	2923
7558	m	2923
7559	k	2923
7560	x	2924
7561	y	2924
7562	n	2925
7563	m	2925
7564	k	2925
7565	x	2926
7566	y	2926
7567	n	2927
7568	m	2927
7569	k	2927
7570	n	2928
7571	m	2928
7572	k	2928
7573	x	2929
7574	y	2929
7575	n	2930
7576	m	2930
7577	k	2930
7578	x	2931
7579	y	2931
7580	n	2932
7581	m	2932
7582	k	2932
7583	n	2933
7584	m	2933
7585	k	2933
7586	n	2934
7587	m	2934
7588	k	2934
7589	n	2935
7590	m	2935
7591	k	2935
7592	n	2936
7593	m	2936
7594	k	2936
7595	n	2937
7596	m	2937
7597	k	2937
7598	n	2938
7599	m	2938
7600	k	2938
7601	n	2939
7602	m	2939
7603	k	2939
7604	x	2940
7605	y	2940
7606	n	2941
7607	m	2941
7608	k	2941
7609	x	2942
7610	y	2942
7611	n	2943
7612	m	2943
7613	k	2943
7614	n	2944
7615	m	2944
7616	k	2944
7617	n	2945
7618	m	2945
7619	k	2945
7620	x	2946
7621	y	2946
7622	n	2947
7623	m	2947
7624	k	2947
7625	n	2948
7626	m	2948
7627	k	2948
7628	n	2949
7629	m	2949
7630	k	2949
7631	n	2950
7632	m	2950
7633	k	2950
7634	n	2951
7635	m	2951
7636	k	2951
7637	n	2952
7638	m	2952
7639	k	2952
7640	n	2953
7641	m	2953
7642	k	2953
7643	x	2954
7644	y	2954
7645	n	2955
7646	m	2955
7647	k	2955
7648	n	2956
7649	m	2956
7650	k	2956
7651	x	2957
7652	y	2957
7653	n	2958
7654	m	2958
7655	k	2958
7656	n	2959
7657	m	2959
7658	k	2959
7659	n	2960
7660	m	2960
7661	k	2960
7662	x	2961
7663	y	2961
7664	n	2962
7665	m	2962
7666	k	2962
7667	x	2963
7668	y	2963
7669	n	2964
7670	m	2964
7671	k	2964
7672	n	2965
7673	m	2965
7674	k	2965
7675	n	2966
7676	m	2966
7677	k	2966
7678	n	2967
7679	m	2967
7680	k	2967
7681	n	2968
7682	m	2968
7683	k	2968
7684	n	2969
7685	m	2969
7686	k	2969
7687	n	2970
7688	m	2970
7689	k	2970
7690	n	2971
7691	m	2971
7692	k	2971
7693	n	2972
7694	m	2972
7695	k	2972
7696	n	2973
7697	m	2973
7698	k	2973
7699	n	2974
7700	m	2974
7701	k	2974
7702	n	2975
7703	m	2975
7704	k	2975
7705	n	2976
7706	m	2976
7707	k	2976
7708	x	2977
7709	y	2977
7710	n	2978
7711	m	2978
7712	k	2978
7713	n	2979
7714	m	2979
7715	k	2979
7716	x	2980
7717	y	2980
7718	n	2981
7719	m	2981
7720	k	2981
7721	n	2982
7722	m	2982
7723	k	2982
7724	x	2983
7725	y	2983
7726	n	2984
7727	m	2984
7728	k	2984
7729	n	2985
7730	m	2985
7731	k	2985
7732	x	2986
7733	y	2986
7734	n	2987
7735	m	2987
7736	k	2987
7737	n	2988
7738	m	2988
7739	k	2988
7740	x	2989
7741	y	2989
7742	n	2990
7743	m	2990
7744	k	2990
7745	n	2991
7746	m	2991
7747	k	2991
7748	x	2992
7749	y	2992
7750	n	2993
7751	m	2993
7752	k	2993
7753	x	2994
7754	y	2994
7755	n	2995
7756	m	2995
7757	k	2995
7758	x	2996
7759	y	2996
7760	n	2997
7761	m	2997
7762	k	2997
7763	n	2998
7764	m	2998
7765	k	2998
7766	x	2999
7767	y	2999
7768	n	3000
7769	m	3000
7770	k	3000
7771	x	3001
7772	y	3001
7773	n	3002
7774	m	3002
7775	k	3002
7776	x	3003
7777	y	3003
7778	n	3004
7779	m	3004
7780	k	3004
7781	x	3005
7782	y	3005
7783	n	3006
7784	m	3006
7785	k	3006
7786	x	3007
7787	y	3007
7788	n	3008
7789	m	3008
7790	k	3008
7791	x	3009
7792	y	3009
7793	n	3010
7794	m	3010
7795	k	3010
7796	x	3011
7797	y	3011
7798	n	3012
7799	m	3012
7800	k	3012
7801	x	3013
7802	y	3013
7803	n	3014
7804	m	3014
7805	k	3014
7806	x	3015
7807	y	3015
7808	n	3016
7809	m	3016
7810	k	3016
7811	x	3017
7812	y	3017
7813	n	3018
7814	m	3018
7815	k	3018
7816	x	3019
7817	y	3019
7818	n	3020
7819	m	3020
7820	k	3020
7821	x	3021
7822	y	3021
7823	n	3022
7824	m	3022
7825	k	3022
7826	x	3023
7827	y	3023
7828	n	3024
7829	m	3024
7830	k	3024
7831	x	3025
7832	y	3025
7833	n	3026
7834	m	3026
7835	k	3026
7836	x	3027
7837	y	3027
7838	n	3028
7839	m	3028
7840	k	3028
7841	x	3029
7842	y	3029
7843	n	3030
7844	m	3030
7845	k	3030
7846	x	3031
7847	y	3031
7848	n	3032
7849	m	3032
7850	k	3032
7851	x	3033
7852	y	3033
7853	n	3034
7854	m	3034
7855	k	3034
7856	x	3035
7857	y	3035
7858	n	3036
7859	m	3036
7860	k	3036
7861	x	3037
7862	y	3037
7863	n	3038
7864	m	3038
7865	k	3038
7866	x	3039
7867	y	3039
7868	n	3040
7869	m	3040
7870	k	3040
7871	x	3041
7872	y	3041
7873	n	3042
7874	m	3042
7875	k	3042
7876	x	3043
7877	y	3043
7878	n	3044
7879	m	3044
7880	k	3044
7881	x	3045
7882	y	3045
7883	n	3046
7884	m	3046
7885	k	3046
7886	x	3047
7887	y	3047
7888	n	3048
7889	m	3048
7890	k	3048
7891	x	3049
7892	y	3049
7893	n	3050
7894	m	3050
7895	k	3050
7896	x	3051
7897	y	3051
7898	n	3052
7899	m	3052
7900	k	3052
7901	x	3053
7902	y	3053
7903	n	3054
7904	m	3054
7905	k	3054
7906	x	3055
7907	y	3055
7908	n	3056
7909	m	3056
7910	k	3056
7911	x	3057
7912	y	3057
7913	n	3058
7914	m	3058
7915	k	3058
7916	x	3059
7917	y	3059
7918	n	3060
7919	m	3060
7920	k	3060
7921	x	3061
7922	y	3061
7923	n	3062
7924	m	3062
7925	k	3062
7926	n	3063
7927	m	3063
7928	k	3063
7929	x	3064
7930	y	3064
7931	n	3065
7932	m	3065
7933	k	3065
7934	n	3066
7935	m	3066
7936	k	3066
7937	n	3067
7938	m	3067
7939	k	3067
7940	n	3068
7941	m	3068
7942	k	3068
7943	n	3069
7944	m	3069
7945	k	3069
7946	n	3070
7947	m	3070
7948	k	3070
7949	n	3071
7950	m	3071
7951	k	3071
7952	x	3072
7953	y	3072
7954	n	3073
7955	m	3073
7956	k	3073
7957	n	3074
7958	m	3074
7959	k	3074
7960	n	3075
7961	m	3075
7962	k	3075
7963	n	3076
7964	m	3076
7965	k	3076
7966	n	3077
7967	m	3077
7968	k	3077
7969	x	3078
7970	y	3078
7971	n	3079
7972	m	3079
7973	k	3079
7974	n	3080
7975	m	3080
7976	k	3080
7977	x	3081
7978	y	3081
7979	n	3082
7980	m	3082
7981	k	3082
7982	n	3083
7983	m	3083
7984	k	3083
7985	x	3084
7986	y	3084
7987	n	3085
7988	m	3085
7989	k	3085
7990	n	3086
7991	m	3086
7992	k	3086
7993	x	3087
7994	y	3087
7995	n	3088
7996	m	3088
7997	k	3088
7998	n	3089
7999	m	3089
8000	k	3089
8001	x	3090
8002	y	3090
8003	n	3091
8004	m	3091
8005	k	3091
8006	n	3092
8007	m	3092
8008	k	3092
8009	n	3093
8010	m	3093
8011	k	3093
8012	n	3094
8013	m	3094
8014	k	3094
8015	n	3095
8016	m	3095
8017	k	3095
8018	n	3096
8019	m	3096
8020	k	3096
8021	n	3097
8022	m	3097
8023	k	3097
8024	n	3098
8025	m	3098
8026	k	3098
8027	n	3099
8028	m	3099
8029	k	3099
8030	x	3100
8031	y	3100
8032	n	3101
8033	m	3101
8034	k	3101
8035	x	3102
8036	y	3102
8037	n	3103
8038	m	3103
8039	k	3103
8040	x	3104
8041	y	3104
8042	n	3105
8043	m	3105
8044	k	3105
8045	x	3106
8046	y	3106
8047	n	3107
8048	m	3107
8049	k	3107
8050	x	3108
8051	y	3108
8052	n	3109
8053	m	3109
8054	k	3109
8055	x	3110
8056	y	3110
8057	n	3111
8058	m	3111
8059	k	3111
8060	x	3112
8061	y	3112
8062	n	3113
8063	m	3113
8064	k	3113
8065	x	3114
8066	y	3114
8067	n	3115
8068	m	3115
8069	k	3115
8070	x	3116
8071	y	3116
8072	n	3117
8073	m	3117
8074	k	3117
8075	x	3118
8076	y	3118
8077	n	3119
8078	m	3119
8079	k	3119
8080	x	3120
8081	y	3120
8082	n	3121
8083	m	3121
8084	k	3121
8085	x	3122
8086	y	3122
8087	n	3123
8088	m	3123
8089	k	3123
8090	x	3124
8091	y	3124
8092	n	3125
8093	m	3125
8094	k	3125
8095	x	3126
8096	y	3126
8097	n	3127
8098	m	3127
8099	k	3127
8100	n	3128
8101	m	3128
8102	k	3128
8103	n	3129
8104	m	3129
8105	k	3129
8106	x	3130
8107	y	3130
8108	n	3131
8109	m	3131
8110	k	3131
8111	n	3132
8112	m	3132
8113	k	3132
8114	x	3133
8115	y	3133
8116	n	3134
8117	m	3134
8118	k	3134
8119	n	3135
8120	m	3135
8121	k	3135
8122	n	3136
8123	m	3136
8124	k	3136
8125	x	3137
8126	y	3137
8127	n	3138
8128	m	3138
8129	k	3138
8130	n	3139
8131	m	3139
8132	k	3139
8133	n	3140
8134	m	3140
8135	k	3140
8136	x	3141
8137	y	3141
8138	n	3142
8139	m	3142
8140	k	3142
8141	x	3143
8142	y	3143
8143	n	3144
8144	m	3144
8145	k	3144
8146	n	3145
8147	m	3145
8148	k	3145
8149	x	3146
8150	y	3146
8151	n	3147
8152	m	3147
8153	k	3147
8154	n	3148
8155	m	3148
8156	k	3148
8157	n	3149
8158	m	3149
8159	k	3149
8160	x	3150
8161	y	3150
8162	n	3151
8163	m	3151
8164	k	3151
8165	n	3152
8166	m	3152
8167	k	3152
8168	n	3153
8169	m	3153
8170	k	3153
8171	x	3154
8172	y	3154
8173	n	3155
8174	m	3155
8175	k	3155
8176	n	3156
8177	m	3156
8178	k	3156
8179	n	3157
8180	m	3157
8181	k	3157
8182	x	3158
8183	y	3158
8184	n	3159
8185	m	3159
8186	k	3159
8187	x	3160
8188	y	3160
8189	n	3161
8190	m	3161
8191	k	3161
8192	x	3162
8193	y	3162
8194	n	3163
8195	m	3163
8196	k	3163
8197	x	3164
8198	y	3164
8199	n	3165
8200	m	3165
8201	k	3165
8202	x	3166
8203	y	3166
8204	n	3167
8205	m	3167
8206	k	3167
8207	x	3168
8208	y	3168
8209	n	3169
8210	m	3169
8211	k	3169
8212	x	3170
8213	y	3170
8214	n	3171
8215	m	3171
8216	k	3171
8217	x	3172
8218	y	3172
8219	n	3173
8220	m	3173
8221	k	3173
8227	x	3176
8228	y	3176
8229	n	3177
8230	m	3177
8231	k	3177
8232	x	3178
8233	y	3178
8234	n	3179
8235	m	3179
8236	k	3179
8237	n	3180
8238	m	3180
8239	k	3180
8256	n	3187
8257	m	3187
8258	k	3187
8259	x	3188
8260	y	3188
8261	n	3189
8262	m	3189
8263	k	3189
8269	x	3192
8270	y	3192
8271	n	3193
8272	m	3193
8273	k	3193
8279	x	3196
8280	y	3196
8281	n	3197
8282	m	3197
8283	k	3197
8284	n	3198
8285	m	3198
8286	k	3198
8303	n	3205
8304	m	3205
8305	k	3205
8306	x	3206
8307	y	3206
8308	n	3207
8309	m	3207
8310	k	3207
8311	x	3208
8312	y	3208
8313	n	3209
8314	m	3209
8315	k	3209
8326	x	3214
8327	y	3214
8328	n	3215
8329	m	3215
8330	k	3215
8331	n	3216
8332	m	3216
8333	k	3216
8339	n	3219
8340	m	3219
8341	k	3219
8342	x	3220
8343	y	3220
8344	n	3221
8345	m	3221
8346	k	3221
8353	n	3224
8354	m	3224
8355	k	3224
8356	n	3225
8357	m	3225
8358	k	3225
8359	n	3226
8360	m	3226
8361	k	3226
8362	n	3227
8363	m	3227
8364	k	3227
8368	n	3229
8369	m	3229
8370	k	3229
8381	n	3234
8382	m	3234
8383	k	3234
8389	n	3237
8390	m	3237
8391	k	3237
8398	n	3240
8399	m	3240
8400	k	3240
8401	n	3241
8402	m	3241
8403	k	3241
8404	n	3242
8405	m	3242
8406	k	3242
8407	n	3243
8408	m	3243
8409	k	3243
8413	n	3245
8414	m	3245
8415	k	3245
8222	x	3174
8223	y	3174
8224	n	3175
8225	m	3175
8226	k	3175
8240	x	3181
8241	y	3181
8242	n	3182
8243	m	3182
8244	k	3182
8245	n	3183
8246	m	3183
8247	k	3183
8248	x	3184
8249	y	3184
8250	n	3185
8251	m	3185
8252	k	3185
8253	n	3186
8254	m	3186
8255	k	3186
8264	x	3190
8265	y	3190
8266	n	3191
8267	m	3191
8268	k	3191
8287	x	3199
8288	y	3199
8289	n	3200
8290	m	3200
8291	k	3200
8292	x	3201
8293	y	3201
8294	n	3202
8295	m	3202
8296	k	3202
8297	n	3203
8298	m	3203
8299	k	3203
8300	n	3204
8301	m	3204
8302	k	3204
8316	x	3210
8317	y	3210
8318	n	3211
8319	m	3211
8320	k	3211
8321	x	3212
8322	y	3212
8323	n	3213
8324	m	3213
8325	k	3213
8334	x	3217
8335	y	3217
8336	n	3218
8337	m	3218
8338	k	3218
8347	n	3222
8348	m	3222
8349	k	3222
8350	n	3223
8351	m	3223
8352	k	3223
8365	n	3228
8366	m	3228
8367	k	3228
8371	x	3230
8372	y	3230
8373	n	3231
8374	m	3231
8375	k	3231
8376	x	3232
8377	y	3232
8378	n	3233
8379	m	3233
8380	k	3233
8384	x	3235
8385	y	3235
8386	n	3236
8387	m	3236
8388	k	3236
8392	n	3238
8393	m	3238
8394	k	3238
8395	n	3239
8396	m	3239
8397	k	3239
8410	n	3244
8411	m	3244
8412	k	3244
8416	n	3246
8417	m	3246
8418	k	3246
8419	n	3247
8420	m	3247
8421	k	3247
8422	n	3248
8423	m	3248
8424	k	3248
8425	n	3249
8426	m	3249
8427	k	3249
8428	n	3250
8429	m	3250
8430	k	3250
8431	n	3251
8432	m	3251
8433	k	3251
8434	n	3252
8435	m	3252
8436	k	3252
8442	x	3255
8443	y	3255
8444	n	3256
8445	m	3256
8446	k	3256
8447	n	3257
8448	m	3257
8449	k	3257
8450	n	3258
8451	m	3258
8452	k	3258
8453	n	3259
8454	m	3259
8455	k	3259
8456	n	3260
8457	m	3260
8458	k	3260
8459	n	3261
8460	m	3261
8461	k	3261
8462	n	3262
8463	m	3262
8464	k	3262
8465	n	3263
8466	m	3263
8467	k	3263
8468	n	3264
8469	m	3264
8470	k	3264
8476	n	3267
8477	m	3267
8478	k	3267
\.


--
-- Name: explicitformula_id_seq; Type: SEQUENCE SET; Schema: public; Owner: prog
--

SELECT pg_catalog.setval('public.explicitformula_id_seq', 2778, false);


--
-- Name: formula_id_seq; Type: SEQUENCE SET; Schema: public; Owner: prog
--

SELECT pg_catalog.setval('public.formula_id_seq', 3267, true);


--
-- Name: generatingfunction_id_seq; Type: SEQUENCE SET; Schema: public; Owner: prog
--

SELECT pg_catalog.setval('public.generatingfunction_id_seq', 2778, false);


--
-- Name: pyramid_id_seq; Type: SEQUENCE SET; Schema: public; Owner: prog
--

SELECT pg_catalog.setval('public.pyramid_id_seq', 1319, true);


--
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: prog
--

SELECT pg_catalog.setval('public.user_id_seq', 12, true);


--
-- Name: variable_id_seq; Type: SEQUENCE SET; Schema: public; Owner: prog
--

SELECT pg_catalog.setval('public.variable_id_seq', 8478, true);


--
-- Name: alembic_version alembic_version_pkc; Type: CONSTRAINT; Schema: public; Owner: prog
--

ALTER TABLE ONLY public.alembic_version
    ADD CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num);


--
-- Name: explicitformula explicitformula_pkey; Type: CONSTRAINT; Schema: public; Owner: prog
--

ALTER TABLE ONLY public.explicitformula
    ADD CONSTRAINT explicitformula_pkey PRIMARY KEY (id);


--
-- Name: formula formula_pkey; Type: CONSTRAINT; Schema: public; Owner: prog
--

ALTER TABLE ONLY public.formula
    ADD CONSTRAINT formula_pkey PRIMARY KEY (id);


--
-- Name: generatingfunction generatingfunction_pkey; Type: CONSTRAINT; Schema: public; Owner: prog
--

ALTER TABLE ONLY public.generatingfunction
    ADD CONSTRAINT generatingfunction_pkey PRIMARY KEY (id);


--
-- Name: pyramid pyramid_pkey; Type: CONSTRAINT; Schema: public; Owner: prog
--

ALTER TABLE ONLY public.pyramid
    ADD CONSTRAINT pyramid_pkey PRIMARY KEY (id);


--
-- Name: pyramid pyramid_sequence_number_key; Type: CONSTRAINT; Schema: public; Owner: prog
--

ALTER TABLE ONLY public.pyramid
    ADD CONSTRAINT pyramid_sequence_number_key UNIQUE (sequence_number);


--
-- Name: user user_email_key; Type: CONSTRAINT; Schema: public; Owner: prog
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key UNIQUE (email);


--
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: prog
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- Name: user user_username_key; Type: CONSTRAINT; Schema: public; Owner: prog
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key UNIQUE (username);


--
-- Name: variable variable_pkey; Type: CONSTRAINT; Schema: public; Owner: prog
--

ALTER TABLE ONLY public.variable
    ADD CONSTRAINT variable_pkey PRIMARY KEY (id);


--
-- Name: idx_gin_data; Type: INDEX; Schema: public; Owner: prog
--

CREATE INDEX idx_gin_data ON public.pyramid USING gin (data);


--
-- Name: explicitformula explicitformula_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: prog
--

ALTER TABLE ONLY public.explicitformula
    ADD CONSTRAINT explicitformula_id_fkey FOREIGN KEY (id) REFERENCES public.formula(id) ON DELETE CASCADE;


--
-- Name: formula formula_pyramid_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: prog
--

ALTER TABLE ONLY public.formula
    ADD CONSTRAINT formula_pyramid_id_fkey FOREIGN KEY (pyramid_id) REFERENCES public.pyramid(id) ON DELETE CASCADE;


--
-- Name: generatingfunction generatingfunction_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: prog
--

ALTER TABLE ONLY public.generatingfunction
    ADD CONSTRAINT generatingfunction_id_fkey FOREIGN KEY (id) REFERENCES public.formula(id) ON DELETE CASCADE;


--
-- Name: pyramid pyramid_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: prog
--

ALTER TABLE ONLY public.pyramid
    ADD CONSTRAINT pyramid_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id);


--
-- Name: relations relations_linked_pyramid_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: prog
--

ALTER TABLE ONLY public.relations
    ADD CONSTRAINT relations_linked_pyramid_id_fkey FOREIGN KEY (linked_pyramid_id) REFERENCES public.pyramid(id);


--
-- Name: relations relations_relatedto_pyramid_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: prog
--

ALTER TABLE ONLY public.relations
    ADD CONSTRAINT relations_relatedto_pyramid_id_fkey FOREIGN KEY (relatedto_pyramid_id) REFERENCES public.pyramid(id);


--
-- Name: variable variable_formula_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: prog
--

ALTER TABLE ONLY public.variable
    ADD CONSTRAINT variable_formula_id_fkey FOREIGN KEY (formula_id) REFERENCES public.formula(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

