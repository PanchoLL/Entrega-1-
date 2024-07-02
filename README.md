Entrega 1 – Francisco Llambias – Comisión 57190 – 02/07/2024 

 

Base de datos sistema para manejo de repuestos en empresa de maquinaria  

 

Problema: 

 
Para el ejercicio tenemos una empresa que presta servicios con maquinaria, por lo tanto, tiene una flota de diferentes tipos de equipos para poder atender a sus diferentes clientes. 

Necesitamos generar una base de datos que pueda manejar eficientemente los repuestos que utiliza esta empresa, desde las compras a los proveedores hasta tener el conocimiento de en cual equipo se instalan los repuestos. 

Los repuestos deben controlarse de manera eficiente, ya que son bastante caros, por lo que las pérdidas y mermas resultan muy costosas para la empresa. 

 

Descripción del Problema: 


Gestión de pedidos a proveedores:  Permite tener el control y registro de los pedidos realizados a los proveedores y el detalle de cada uno. 

Gestión de Repuestos: Esta base permite conocer el stock de repuestos en algún momento determinado del tiempo. 

Relación Maquina- Repuesto: La base permite ver en que maquina se uso cada repuesto comprado.  

Gestion de Mantenimiento: En general la base nos permite realizar un seguimiento eficiente del mantenimiento de los equipos. 


 

Objetivo: 


Diseñar e implementar una base de datos relacional que permita a la empresa llevar un control eficiente y detallado de los repuestos que compra a diferentes proveedores. Y que luego se instalan en diferentes máquinas para realizar su mantenimiento. Buscamos que la base sea simple de entender, fácil de manejar para sus usuarios, facilita el acceso a la información para poder mejorar el control y la toma de decisiones.  

 

Descripción de la Base de Datos - Gestión Maquinaria 


Tablas: 


Proveedor 

Permite tener un registro de cada proveedor. 

Atributos: ID de Proveedor (pk), Nombre, Dirección, Teléfono, Email 

 

Pedido 

Permite registrar los pedidos realizados a los diferentes proveedores  

Atributos: ID de Pedido (pk), Fecha de Pedido, Fecha de recepción; ID de Proveedor (fk) 


Repuesto 

Registra los repuestos que se tienen disponibles  

Atributos: ID de Repuesto (pk), Nombre, Descripción, Precio, Stock 



DetallePedido 

Permite registrar los datos de cada pedido especifico como la cantidad y su precio. 

Atributos: ID de Detalle (pk), ID de Pedido (fk), ID de Repuesto (fk), Cantidad, Precio Unitario 

 

Maquina  

Permite almacenar información acerca de las máquinas de la empresa. 

Atributos: ID de Maquina (pk), Nombre, Modelo, Fabricante 



Repuesto Maquina 

Es el puente entre los repuestos y las maquinas que los utilizan. 

Atributos: ID de Repuesto(fk), ID Maquina(fk); Cantidad necesaria  

 
Mantenimiento 

Permite registrar las actividades de mantenimiento realizadas a las maquinas. 

Atributos: ID de Mantenimiento (pk), Fecha de mantenimiento, Descripción, ID Maquina (fk) 

 
DetalleMantenimiento 

Permite registrar el detalle de cada mantenimiento y los repuestos utilizados. 

Atributos: ID de Detalle (pk), ID de Mantenimiento (fk), ID Repuesto (fk), Cantidad Usada  
