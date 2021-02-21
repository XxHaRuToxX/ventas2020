package com.xxharutoxx.controladores;

import com.xxharutoxx.modulos.Producto;

import java.util.List;

public class CProducto {
    public static Producto nuevoproducto(String nombre, String descripcion, float precio, int stock){
        Producto producto=new Producto(nombre,descripcion,precio,stock);
        return producto;
    }
    public static Producto tarerProducto(int id_producto){
        return Producto.getProducto(id_producto);
    }
    public static List<Producto> obtenerProductos(){
        return Producto.getProductos();
    }
}
