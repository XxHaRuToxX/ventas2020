package com.xxharutoxx.modulos;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import com.xxharutoxx.conexion.Conexion;
import com.xxharutoxx.intefaces.IModels;

public class Proveedor extends Conexion implements IModels {
    private int id_proveedor;
    private String nombre_p;
    private String direccion;
    private String telefono;
    private String ruc;
    private char esNueno;
    private List<Producto> productos;

    public void setId_proveedor(int id_proveedor){
        this.id_proveedor=id_proveedor;
    }
    public int getId_proveedor(){
        return id_proveedor;
    }
    public void setNombre_p(String nombre_p){
        this.nombre_p=nombre_p;
    }
    public String getNombre_p(){
        return nombre_p;
    }
    public  void setDireccion(String direccion){
        this.direccion=direccion;
    }
    public String getDireccion(){
        return direccion;
    }
    public void setTelefono(String telefono){
        this.telefono=telefono;
    }
    public String getTelefono(){
        return telefono;
    }
    public void setRuc(String ruc){
        this.ruc=ruc;
    }
    public String getRuc(){
        return ruc;
    }
    public char isEsNueno(){
        return esNueno;
    }
    public void setEsNueno(char esNueno){
        this.esNueno=esNueno;
    }
    public Proveedor(){
        id_proveedor=0;
        nombre_p="";
        direccion="";
        telefono="";
        ruc="";
        this.esNueno='c';
        productos=new ArrayList<Producto>();

    }
    public Proveedor(String nombre_p,String direccion,String telefono,String ruc){
        this.id_proveedor=0;
        this.nombre_p=nombre_p;
        this.direccion=direccion;
        this.telefono=telefono;
        this.ruc=ruc;
        this.esNueno='c';
        productos=new ArrayList<Producto>();

    }
    @Override
    public boolean save() throws Exception{
        try {
            openConexion();
            consulta=conexion.prepareStatement(" call spGestionarProveedor1(?,?,?,?,?,?)");
            consulta.setString(1,String.valueOf(isEsNueno()));
            consulta.setInt(2,getId_proveedor());
            consulta.setString(3,getNombre_p());
            consulta.setString(4,getDireccion());
            consulta.setString(5,getTelefono());
            consulta.setString(6,getRuc());
            return  consulta.execute();


        }catch (Exception ex){
            ex.printStackTrace();
        }finally {
            closeConexion();
        }
        return true;
    }
    public boolean agregarProducto(String nombre, String descripcion, float precio, int stock, int cantidad){
        try {
            Producto p = new Producto(nombre, descripcion, precio, stock);
            p.save();

            openConexion();
            consulta=conexion.prepareStatement("call spObtenerIdProducto()");
            resultado=consulta.executeQuery();
            int id_ = 0;
            if(resultado.next()){
                id_ = resultado.getInt(1);
            }
            double preciof=precio+(precio*0.18);
            consulta=conexion.prepareStatement("insert into proveedorproducto values (?,?,?,?,?)");
            consulta.setInt(1, id_);
            consulta.setInt(2, getId_proveedor());
            consulta.setDate(3, Date.valueOf(new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date())));
            consulta.setInt(4,cantidad);
            consulta.setDouble(5,preciof);
            return consulta.execute();

        } catch (Exception ex) {
            ex.printStackTrace();
        }finally {
            closeConexion();
        }
        return true;
    }
    public static Proveedor getProveedor(int id){
        Proveedor proveedor=null;
        try{
            openConexion();
            consulta=conexion.prepareStatement("select id_proveedor,nombre_p,direccion,telefono,ruc from proveedor where id_proveedor=?");
            consulta.setInt(1,id);
            resultado=consulta.executeQuery();
            if(resultado.next()){
                proveedor=new Proveedor();
                proveedor.setId_proveedor(resultado.getInt(1));
                proveedor.setNombre_p(resultado.getString(2));
                proveedor.setDireccion(resultado.getString(3));
                proveedor.setTelefono(resultado.getString(4));
                proveedor.setRuc(resultado.getString(5));
            }
        }catch (Exception ex){
            ex.printStackTrace();
        }finally {
            closeConexion();
        }
    return proveedor;
    }
    public static List<Proveedor> getProveedores(){
        List<Proveedor> provee=new ArrayList<>();
        try {
            openConexion();
            consulta=conexion.prepareStatement("select id_proveedor,nombre_p,direccion,telefono,ruc from proveedor");
            resultado=consulta.executeQuery();
            while (resultado.next()){
                Proveedor proveedor=new Proveedor();
                proveedor.setId_proveedor(resultado.getInt(1));
                proveedor.setNombre_p(resultado.getString(2));
                proveedor.setDireccion(resultado.getString(3));
                proveedor.setTelefono(resultado.getString(4));
                proveedor.setRuc(resultado.getString(5));
                provee.add(proveedor);
            }

        }catch (Exception ex){
            ex.printStackTrace();
        }finally {
            closeConexion();
        }
        return provee;
    }
    @Override
    public String toString(){
        return "id_proveedor: " + id_proveedor+" "+
                "nombre_p: " + nombre_p +" "+
                "Direccion: "+ direccion+" "+
                "Telefono: "+ telefono+" "+
                "RUC: "+ ruc+"\n ";
    }
    public List<Producto> listarProductos(){

        try{
            openConexion();
            consulta=conexion.prepareStatement("call spGestionarProPro(?)");
            consulta.setInt(1,getId_proveedor());
            resultado=consulta.executeQuery();
            while(resultado.next()){
                System.out.println("ookokokok");
                Producto produ=new Producto();
                produ.setId_producto(resultado.getInt(1));
                produ.setNombre(resultado.getString(2));
                produ.setDescripcion(resultado.getString(3));
                produ.setPrecio(resultado.getFloat(4));
                produ.setStock(resultado.getInt(5));
                productos.add(produ);
            }

        }catch (Exception ex){
            ex.printStackTrace();
        }finally {
            closeConexion();
        }
        return productos;
    }


}
