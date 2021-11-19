-- Una aplicación frecuente de Ciencia de Datos aplicada a la industria del microlending es el de calificaciones crediticias (credit scoring). 
--Puede interpretarse de muchas formas: propensión a pago, probabilidad de default, etc. 
--La intuición nos dice que las variables más importantes son el saldo o monto del crédito, y la puntualidad del pago; sin embargo, otra variable que frecuentemente escapa a los analistas es el tiempo entre cada pago. 
--La puntualidad es una pésima variable para anticipar default o inferir capacidad de pago de micropréstamos, por su misma naturaleza. Si deseamos examinar la viabilidad de un producto de crédito para nuestras videorental stores:

--Cuál es el promedio, en formato human-readable, de tiempo entre cada pago por cliente de la BD Sakila?
--Sigue una distribución normal?
--Qué tanto difiere ese promedio del tiempo entre rentas por cliente?

with t as(
	select p.customer_id ,p.payment_date::timestamp - lag(p.payment_date , 1 )over (partition by p.customer_id order by p.payment_id asc) as diferencia
	from payment p 
	)
	select t.customer_id ,avg(t.diferencia) as "promedio por cliente"
	from t
	group by t.customer_id 
	order by t.customer_id asc
