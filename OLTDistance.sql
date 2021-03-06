with a as ( 
  select h.host, h.name, i.hostid, i.itemid, i.name 
    from items i LEFT JOIN hosts h ON h.hostid = i.hostid 
   WHERE i.name = 'OLT Distance'
), b as (
   select itemid, AVG(value_avg) MEDIA_DISTANCIA 
     from trends 
    where clock > extract('epoch' from now())::int - 86400 
      AND itemid IN (SELECT itemid FROM items WHERE name = 'OLT Distance') 
    GROUP BY itemid ORDER BY MEDIA_DISTANCIA
) SELECT * FROM a LEFT JOIN b ON a.itemid = b.itemid ORDER BY b.MEDIA_DISTANCIA DESC;
