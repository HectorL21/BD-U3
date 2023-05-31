DELIMITER //
create procedure insertarRFC()
begin
	declare clave int;
    declare nombre varchar(50);
    declare apellidoPat varchar(50);
    declare apellidoMat varchar(50);
    declare fecha_nac date;
    declare rfc varchar(50);
    declare terminar int default false;
    declare lista_clientes cursor for    
		select id, nombre, apellido_pat, apellido_mat, fecha_nac from personas;	
	declare continue handler for NOT FOUND set terminar = true;
    
    open lista_clientes;
    datos: loop
		fetch lista_clientes into clave, nombre, apellidoPat, apellidoMat, fecha_nac;
        select generar_rfc(nombre, apellidoPat, apellidoMat, fecha_nac) into rfc;
        update personas
        set clave_rfc = rfc
        where id = clave;
        if terminar = true then
			leave datos;
		end if;
	end loop datos;
    close lista_clientes;    
END //
DELIMITER ;