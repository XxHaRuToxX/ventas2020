package com.xxharutoxx.controladores;

import com.xxharutoxx.modulos.Proveedor;

import java.util.List;

public class CProveedor {
    public static Proveedor crearProveedor(String nombre_p,String direccion,String telefono,String ruc){
        Proveedor proveedor=new Proveedor(nombre_p,direccion,telefono,ruc);
        return proveedor;
    }
    public static Proveedor traerProveedor(int id_proveedor){
//        if (false){
            return Proveedor.getProveedor(id_proveedor);
//        } else {
//            return null;
//        }
    }
    public static List<Proveedor> obtenerProveedores(){
        return Proveedor.getProveedores();
    }
}
