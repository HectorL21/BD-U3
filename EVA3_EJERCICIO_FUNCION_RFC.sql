DELIMITER //
create function generar_rfc(nombre varchar(50), apellido_pat varchar(50), apellido_mat varchar(50), fecha_nac date)
returns varchar(50) deterministic

BEGIN
	declare letraNombre varchar(1);
    declare letrasPat varchar(2);
    declare letraMat varchar(1);
    declare año varchar(4);
    declare mes varchar(2);
    declare día varchar(2);
    declare rfc varchar(15);
    
    select substring(nombre,1,1) into letraNombre from personas where nombre = nombre;
    select substring(apellido_pat,1,2) into letrasPat from personas where nombre = nombre;
    if apellido_mat = NULL then
		set letraMat = 'x';
	else
		select substring(apellido_mat,1,1) into letraMat from personas where nombre = nombre;
    end if;
    select year(fecha_nac) into año;
    select month(fecha_nac) into mes;
    select day(fecha_nac) into dia;
    
    set rfc = concat(letrasPat, letraMat,letraNombre,año,mes,dia);
    
    return rfc;
END //
DELIMITER ;
/*
insert into personas(nombre, apellido_pat, apellido_mat, fecha_nac) values('Gabriel','Morales','Ochoa','2002-11-27');
insert into personas(nombre, apellido_pat, fecha_nac) values('Gabriel','Morales','2002-11-27');
*/