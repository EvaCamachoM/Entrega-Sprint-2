#Exercici 2.1 - Nivell 1
#Llistat dels països que estan fent compres:
select distinct country
from company
inner join transaction on company.id = transaction.company_id
where declined = 0;


#Exercici 2.2 - Nivell 1
#Des de quants països es realitzen les compres:
select COUNT(distinct country) 
from company
inner join transaction on company.id = transaction.company_id
where declined = 0;



#Exercici 2.3 - Nivell 1
#Identifica la companyia amb la mitjana més gran de vendes:
select company_name, round(avg(amount),2)
from company
inner join transaction on company.id = transaction.company_id
where declined = 0
group by company_name order by avg(amount) desc limit 1;

#Exercici 3.1 - Nivell 1
#Mostra totes les transaccions realitzades per empreses d'Alemanya
#Utilitzant només subconsultes (sense utilitzar JOIN):
select * from transaction
where company_id in 
	(select id
	from company
	where country = 'Germany');
 
#Exercici 3.2 - Nivell 1
#Llista les empreses que han realitzat transaccions per un amount superior a la mitjana de totes les transaccions:
#Utilitzant només subconsultes (sense utilitzar JOIN):	
select company_name
from company
where id in
	(select company_id
	from transaction
    where amount > 
    (select avg(amount)
	from transaction));
    
#Exercici 3.3 - Nivell 1
#Eliminaran del sistema les empreses que no tenen transaccions registrades, entrega el llistat d'aquestes empreses:
#Utilitzant només subconsultes (sense utilitzar JOIN):
select company_name
from company
where not exists 
	(select *
    from transaction
    where transaction.company_id = company.id);
    
#Exercici 1 - Nivell 2
#Identifica els cinc dies que es va generar la quantitat més gran d'ingressos a l'empresa per vendes. 
#Mostra la data de cada transacció juntament amb el total de les vendes.
select DATE(timestamp), sum(amount) as TotalAmount
from transaction
where declined = 0
group by timestamp
order by TotalAmount desc limit 5;

#Exercici 2 - Nivell 2
#Quina és la mitjana de vendes per país? Presenta els resultats ordenats de major a menor mitjà.
select country, round(avg(amount),2) as PromedioVentas
from company
inner join transaction on company.id = transaction.company_id
where declined = 0
group by country 
order by PromedioVentas desc;

#Exercici 3 - Nivell 2
#En la teva empresa, es planteja un nou projecte per a llançar algunes campanyes publicitàries 
#per a fer competència a la companyia "Non Institute". Per a això, et demanen la llista de totes 
#les transaccions realitzades per empreses que estan situades en el mateix país que aquesta companyia.

#Exercici 3.1 - Nivell 2
#Mostra el llistat aplicant JOIN i subconsultes.
select *
from transaction
inner join company on company.id = transaction.company_id
where country =
	(select country from company
	where company_name = 'Non Institute')
 and company_name <> 'Non Institute';

    

#Exercici 3.2 - Nivell 2	
#Mostra el llistat aplicant solament subconsultes.
select *
from transaction
where company_id in 
	(select id
	from company
    where country = 
		(select country from company
		where company_name = 'Non Institute'))
and company_id <> 'b-2618';
		

#Exercici 1 - Nivell 3
#Presenta el nom, telèfon, país, data i amount, d'aquelles empreses que van realitzar transaccions amb un valor comprès 
#entre 100 i 200 euros i en alguna d'aquestes dates: 29 d'abril del 2021, 20 de juliol del 2021 i 13 de març del 2022. 
#Ordena els resultats de major a menor quantitat.
select company_name, phone, country, DATE(timestamp), amount
from company
inner join transaction on company.id=transaction.company_id
where amount between 100 and 200
and DATE(timestamp) in ('2021-04-29','2021-07-20','2022-03-13')
order by amount desc;


#Exercici 2 - Nivell 3
#Necessitem optimitzar l'assignació dels recursos i dependrà de la capacitat operativa que es requereixi, 
#per la qual cosa et demanen la informació sobre la quantitat de transaccions que realitzen les empreses, 
#però el departament de recursos humans és exigent i vol un llistat de les empreses on especifiquis si tenen més de 4 transaccions o menys.		
select company_id, QtyTransacc,
case 
	when QtyTransacc > 4 then 'Més de 4 transaccions'
	else '4 transaccions o menys'
	end as Tipo
from 
	(select company_id, count(id) as QtyTransacc
	from transaction
	group by company_id) as Transacciones;
    
    











