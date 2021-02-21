package com.xxharutoxx.modulos;

import com.xxharutoxx.conexion.Conexion;
import com.xxharutoxx.intefaces.IModels;

import java.util.ArrayList;
import java.util.List;

public class Producto extends Conexion implements IModels {
    private int id_producto;
    private String nombre;
    private String descripcion;
    private float precio;
    private int stock;
    private char esNuevo;
    private List<Proveedor> proveedores;

    public int getId_producto() {
        return id_producto;
    }

    public void setId_producto(int id_producto) {
        this.id_producto = id_producto;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public float getPrecio() {
        return precio;
    }

    public void setPrecio(float precio) {
        this.precio = precio;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public char isEsNuevo() {
        return esNuevo;
    }

    public void setEsNuevo(char esNuevo) {
        this.esNuevo = esNuevo;
    }
    public Producto(){
        this.id_producto=0;
        this.nombre="";
        this.descripcion="";
        this.precio=0F;
        this.stock=0;
        this.esNuevo='c';
        proveedores=new ArrayList<Proveedor>();

    }

    public Producto(String nombre, String descripcion, float precio, int stock) {
        this.id_producto = 0;
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.precio = precio;
        this.stock = stock;
        this.esNuevo='c';
        proveedores=new ArrayList<Proveedor>();
    }
    @Override
    public boolean save() throws Exception{
        try{
            openConexion();
            consulta=conexion.prepareStatement("call spGestionarProducto1(?,?,?,?,?,?)");
            consulta.setString(1,String.valueOf(isEsNuevo()));
            consulta.setInt(2,getId_producto());
            consulta.setString(3,getNombre());
            consulta.setString(4,getDescripcion());
            consulta.setFloat(5,getPrecio());
            consulta.setInt(6,getStock());
            return consulta.execute();

        }catch (Exception ex){
            ex.printStackTrace();
        }finally {
            closeConexion();
        }return true;
    }
    public static Producto getProducto(int id){
        Producto producto=null;
        try{
            openConexion();
            consulta=conexion.prepareStatement("select id_producto, nombre,descripcion,precio,stock from producto where id_producto=?");
            consulta.setInt(1,id);
            resultado=consulta.executeQuery();
            if(resultado.next()){
                producto=new Producto();
                producto.setId_producto(resultado.getInt(1));
                producto.setNombre(resultado.getString(2));
                producto.setDescripcion(resultado.getString(3));
                producto.setPrecio(resultado.getFloat(4));
                producto.setStock(resultado.getInt(5));
            }

        }catch (Exception ex){
            ex.printStackTrace();
        }finally {
            closeConexion();
        }
        return producto;
    }
    public static List<Producto> getProductos(){
        List<Producto> producto=new ArrayList<Producto>();
        try {
            openConexion();
            consulta=conexion.prepareStatement("select id_producto,nombre,descripcion,precio,stock from producto");
            resultado=consulta.executeQuery();
            while(resultado.next()){
                Producto produ=new Producto();
                produ.setId_producto(resultado.getInt(1));
                produ.setNombre(resultado.getString(2));
                produ.setDescripcion(resultado.getString(3));
                produ.setPrecio(resultado.getFloat(4));
                produ.setStock(resultado.getInt(5));
                producto.add(produ);
            }
        }catch (Exception ex){
            ex.printStackTrace();
        }finally {
            closeConexion();
        }
        return producto;
    }
    @Override
    public String toString(){
        return "ID: "+id_producto+" "+
                "Nombre: "+nombre+" "+
                "Descripcion: "+descripcion+" "+
                "Precio: "+precio+" "+
                "Stock: "+stock+" \n";

    }
    public List<Proveedor> listarProveedores(){
        try{
            openConexion();
            consulta=conexion.prepareStatement("call spGestionarProvProd(?)");
            consulta.setInt(1,getId_producto());
            resultado=consulta.executeQuery();
            if(resultado.next()){
                Proveedor prove=new Proveedor();
                prove.setId_proveedor(resultado.getInt(1));
                prove.setNombre_p(resultado.getString(2));
                prove.setDireccion(resultado.getString(3));
                prove.setTelefono(resultado.getString(4));
                prove.setRuc(resultado.getString(5));
                proveedores.add(prove);

            }

        }catch (Exception ex){
            ex.printStackTrace();
        }finally {
            closeConexion();
        }
        return proveedores;
    }




}
