# Entrega Final – Francisco Llambias – Comisión 57190 – 30/08/2024 

 

Base de datos para manejo de repuestos en empresa de maquinaria.  

 

## Introduccion & Problematica: 

 
Tenemos una empresa que presta servicios con maquinaria, por lo tanto, tiene una flota de diferentes equipos para poder atender a variados clientes. 

Actualmente algunos repuestos llegan tarde a las bodegas, tambien presentan un alto nivel de mermas y no se tiene claro en que equipo terminan instalados. Por otro lado, no todos los equipos tienen sus mantenimientos al dia. Todo esto genera desorden y perdidas de tiempo, lo que finalmente termina afectando el servicio que se le presta al cliente. 

Necesitamos generar una base de datos que pueda manejar eficientemente los repuestos que utiliza esta empresa, partiendo por las compras a los proveedores, entendierndo el stock disponible, hasta tener el conocimiento de en cual equipo se instalan los repuestos para que las maquinas funcionen de manera optima.

 ## Objetivo: 


Diseñar e implementar una base de datos relacional que permita a la empresa llevar un control eficiente y detallado de los repuestos que compra a diferentes proveedores. Los cuales luego se instalan en diferentes máquinas para realizar su mantenimiento. Buscamos que la base sea simple de entender, fácil de manejar para sus usuarios, que facilite el acceso a la información, que mejore el control, que finalmente pueda mejoara la toma de decisiones y la eficiencia operacional de la empresa.


## Modelo de Negocios: 


**Gestión de pedidos a proveedores:**  Permite tener el control y registro de los pedidos realizados a los proveedores y el detalle de cada uno. Esto permite tener el conocimiento de cuales son los proveedores mas relevante y mas confiables para nuestra empresa.

**Gestión de Repuestos:** Esta base permite conocer el stock de repuestos en algún momento determinado del tiempo. Para este negocio es muy relevante tener respuesdtos siempre disponibles ya que su ausencia afecta la disponibilidad de las maquinas en el trabajo. 

**Relación Maquina- Repuesto** La base permite ver en que maquina se uso cada repuesto comprado. Esto permitira conocer a donde han terminado los repuestos que salen de bodega.

**Gestion de Mantenimiento:** En general la base nos permite realizar un seguimiento eficiente del mantenimiento de los equipos. Es relevante conocer el historiar de mantenimientos y llevar los mantenimientos al dia para asi minimizar la probailidad de las fallas.


 

## Descripción de la Base de Datos - Gestión Maquinaria: 


### Tablas, columnas & Claves: 


- Proveedor:

Permite tener un registro de cada proveedor. 

Atributos: ID de Proveedor (PK), Nombre, Dirección, Teléfono, Email 

 

- Pedido:

Permite registrar los pedidos realizados a los diferentes proveedores.  

Atributos: ID de Pedido (PK), Fecha de Pedido, Fecha de recepción; ID de Proveedor (FK) 


- Repuesto: 

Registra todos los repuestos que se tienen disponibles.  

Atributos: ID de Repuesto (PK), Nombre, Descripción, Precio, Stock 



- DetallePedido:

Permite registrar los datos de cada pedido especifico como la cantidad y su precio. 

Atributos: ID de Detalle (PK), ID de Pedido (FK), ID de Repuesto (FK), Cantidad, Precio Unitario 

 

- Maquina: 

Permite almacenar información acerca de las máquinas de la empresa. 

Atributos: ID de Maquina (PK), Nombre, Modelo, Fabricante 



- Repuesto Maquina:

Es el puente entre los repuestos y las maquinas que los utilizan. 

Atributos: ID de Repuesto(FK), ID Maquina(FK); Cantidad necesaria  

 
- Mantenimiento: 

Permite registrar las actividades de mantenimiento realizadas a las maquinas. 

Atributos: ID de Mantenimiento (PK), Fecha de mantenimiento, Descripción, ID Maquina (FK) 

 
- DetalleMantenimiento: 

Permite registrar el detalle de cada mantenimiento y la cantidad usada en cada mantenimiento. 

Atributos: ID de Detalle (PK), ID de Mantenimiento (FK), ID Repuesto (FK), Cantidad Usada  


## Diagrama de Entidad - Relacion:

![alt text](<Diagrama Entidad-Relacion.jpg>)



# Objetos del Modelo:

## Documentacion de Vistas:

### Vista Mantenimiento ultimo mes:

Esta vista permite ver un listado de todos los mantenimientos que se han realizado el ultimo mes. Indica a que maquina se le realizo el mantenimiento con ID_Maquina.
  
Columnas: ID_ Mantenimieno; Fecha_Mantenimiento; Descripcion; Id_Maquina

Ejemplo Consulta:

```
SELECT * FROM Mantenientos_ultimo_mes;
```
  
### Vista Mantenimientos costosos:

Esta Vista muestra los mantenimientos mas caros que se han realizado en la empresa.
  
Columnas: ID_ Mantenimieno; Fecha_Mantenimiento; Maquina; Costo_Total

Ejemplo Consulta:

```
SELECT * FROM mantenimientos_Costosos;
```

  
### Vista Stock_Repuestos:

Esta vista muestra el stock disponible para cada repuesto. La tabla se muestra por Id_Repuesto, nombre y Stock. Vista muy relevante para conocer que repuestos presentan un bajo nivel en bodega.

Stock_Repuestos resulta ser un KPI muy relevante 
 
Columnas: Id_ Repuesto; Nombre; Stock

Ejemplo Consulta:

```
SELECT * FROM Stock_Repuestos
ORDER BY stock DESC;
```


### Vista Proveedores_Mayor_Volumen:

Esta vista permite ver los provedores a los cuales les compramos mas repuestos.

La intencion de esta vista es que la administracion pueda visualizar los provedores mas relevantes para la empresa y puredan saber rapidamente cuales son los mas estrategicos para la empresa. Al correr la vista se puede ver que los provedores a los que se les han comprado mas repuestos son: Komatsu, Liebherr y Bobcat.

Ejemplo de Consulta:

```
SELECT * FROM Proveedores_Mayor_Volumen;
```


### Vista Costo_de_Mantenimiento_x_Maquina

Permite ver las maquinas en las cuales mas se ha gastado por mantenimiento

Esta vista es relevante porque le permite a los encargados de maquinaria visualizar cuales son las maquinas en las que se ha gastado mas, lo que puede ayudar 
 a decidir en decisiones de renovacion o a evitar los equipos de determinadas marcas.   

```
SELECT * FROM Costo_de_Mantenimiento_x_Maquina;
```

### Vista Pedidos_Pendientes

Permite ver los pedidos que etan pendientes de recepcion

Esta vista conocer los pedidos que estan pendientes de entrega lo cual ayuda a hacer seguiomiento y gestionar con los provvesdores en caso que sea necesario.

```
SELECT * FROM Pedidos_Pendientes;
```

## Documentacion de Funciones

### Funcion Dias de Pedido: 

Esta funcion entrega la diferencia, en dias, entre la Fecha de Recepcion y la Fecha de Pedido. Con la finalidad se poder tener control sobre cuanto se estan demorando en llegar los pedidos realizados.

De esta funcion podemos obtener una idea de cuanto se estan demosrando en ralidad los pedidos en llegar. 

Retorno: Dias desde que solicito un pedido hasta que fue entregado 

Ejemplo de uso:

```
SELECT 
    ID_Pedido,
    Fecha_Pedido,
    Fecha_Recepcion,
    Fn_Fecha_Recepcion(Fecha_Pedido, Fecha_Recepcion) AS Dias_Entrega
FROM 
    Pedido;
```

### Funcion Valor por repuesto:

En esta funcion puedo revisar cuanto dinero hay en cada tipo de repuesto. Indica el nombre del repuesto el precio al cual se compro, la cantidad de stock y el Valor del stock en bodega. Nos permite conocer un desgloce rapido de la bodega.
  
Retorno: Valor total de cada tipo de repuesto.

Ejemplo de uso:
```
SELECT
Id_Repuesto,
Nombre,
Precio,
stock,
Valor_Stock (Precio , Stock) AS Valor_Stock
FROM Repuesto
ORDER BY Valor_Stock DESC;
```


### Funcion Tota Repuestos por Mantenimiento:

Esta funcion entrega la cantidad total de repuestos que han sido usados, en todos los mantenimientos, que se han registrado en la tabla Mantenimientos.

Retorno: Total de repuestos que han sido usados en los mantenimientos que estan registrados en este modelo, es decir cuantos repuestos hemos usado historicamnete.

Ejemplo de uso:

```
SELECT Total_Repuestos() AS Repuestos_Usados_en_Mantenimientos;
```


## Documentacion de Stored Procedures 

### Procedimiento Valor Total del Stock

Entrega el valor total del stock de todos los repuestos que hay en la empresa. Este procedimiento permite conocer rapidamente el valor de los inventarios.

Retorno: Valor del Stock Total.

Ejemplo de uso:
```
CALL SP_Valor_Total_Stock()
```

### Procedimiento Mantenimientos por Maquina 

Entrega los mantenimientos que se le han realizado a cada maquina y contiene informacion de cada uno de ellos. Este es es uno de los indicadores mas relevantes porque nos muestra el historial de mantenimiento de las maquinas que tenemos.

Retorno: Entrega informacion varia acerca de los mantenimientos que se le ahan realizado a una maquina en particular.

Ejemplo de uso:
```
CALL Mantenimientos_Por_Maquina(4);
```


### Procedimiento Repuestos con Poco Stock

Este procedimiento permite revisar rapidamente que repuestos tienen stock bajo un numero determinado. Permite visualizar rapidamente los repuestos con stock critico.

Retorno: Muestra tabla con todos los respuestos que estan bajo un monto selecionado. Por ejemplo, podemos ver todos los repuestos que tienen stock menor que 30.

Ejemplo de uso:
```
CALL Repuestos_Poco_Stock(30);
```

## Documentacion de Triggers 

### Trigger Actualizar_Stock_X_DetalleMantenimiento

Descripcion: Actualiza el stock de un repuesto cuando se inserta un nuevo detalle de mantenimiento.

- Detalle:
  
-Tabla afectada: Repuesto

-Accion: Update 

-Info Actualizada: Stock 

Ejemplo: Se realiza un mantenimiento en donde se usa un filtro de aceite, luego el stock de filtros de aceite se reduce en una unidad.

### Trigger Validar_Stock_Mantenimiento

Descripcion: Este Trigger permite dar un aviso si no hay repuestos para hacer un mantenimiento.

- Detalle:
  
-Tabla afectada: Repuesto

-Accion: Set Message

En este caso se genera el mensaje: 'No hay repuesto para realizar este mantenimiento. Favor geenerar orden de compra' en caso que la cantidad a usar sea menor que el stock disponible.

### Trigger Verificadr_Fechas

Envia un mensaje en caso de que la Fecha de recepcion sea anterior a la fecha del pedido. Esto busca evitar posibles errores en la insersion de las fechas.

- Detalle:
  
-Tabla afectada: Pedido

-Accion: Set Message

En este caso se genera el mensaje: 'La fecha de reposición no puede ser anterior a la fecha de pedido' en caso que las fechas sean mal ingresadas.


## Back Up Schemas & Data 

Se genero un back up siguiendo la siguente ruta Administration -> Data Export. Ahi se respaldo la base **pentrega2** en un self-Conteined File con la estructura del modelo, los datos y todos los objetos disponibles. Se cargo el archivo .SQL generado a Git Hub (Back Up - Dump20240829.sql). este documento se puede descargar y posteriormente importar a Workbench.

## Pasos para Levantar el Modelo:

En primer lugar se debe correr la estructura de la base disponible en **Database_Structure**. Luego se debe popular la base, esta informacion se encuentra en el archivo **population**. Luego se deben ir corriendo los diferentes objetos de la base de datos, los cuales se encuentran en la carpeta **DatabaseObjects**

Realizamos todo el trabajo en MySql Workbench.


## Adicional 
Como complemento a este texto se ha subido una presentacion cargada en PDF.
