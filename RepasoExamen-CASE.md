# CASE

> El CASE es como un IF

```sql
SELECT num_empl, nom,
       CASE
       WHEN edat < 26 THEN 'Zoomer'
       WHEN edat < 42 THEN 'Millenial'
       WHEN edat < 58 THEN 'Generació X'
       ELSE 'Boomer' END AS generacio
  FROM rep_vendes;
```

# Sintaxis en un SELECT

```
CASE 
WHEN <condicio_1> THEN <resultat_2>
WHEN <condicio_2> THEN <resultat_2>
ELSE END AS
```