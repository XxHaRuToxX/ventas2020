package com.xxharutoxx.ventas2020v;

import com.xxharutoxx.controladores.CProveedor;
import com.xxharutoxx.modulos.Proveedor;

import com.xxharutoxx.vistas.VPrincipal;

public class Ventas2020v {
    public static void main(String [] args){
////        try {
//////            Proveedor obj = new Proveedor();
//////            obj.setEsNueno('e');
//////            obj.setId_proveedor(8);
////////        obj.setNombre_p("Babas SAC");
////////        obj.setDireccion("Jr. Tambopata");
////////        obj.setTelefono("974556172");
////////        obj.setRuc("12845666621");
//////            obj.save();
//////            Proveedor obj= Proveedor.getProveedor(1);
//////            System.out.println(obj.getTelefono());
//////            System.out.print(Proveedor.getProveedores());
////        }catch (Exception ex){
////            ex.printStackTrace();
////        }
//        try{
////            Producto obj=new Producto();
////            obj.setEsNuevo('a');
////            obj.setId_producto(12);
////            obj.setNombre("BASELINA");
////            obj.setDescripcion("GALONES");
////            obj.setPrecio(300);
////            obj.setStock(50);
////            obj.save();
////            Producto obj= Producto.getProducto(1);
//            Proveedor p= CProveedor.traerProveedor(2);
//
////            Producto p=Producto.getProducto(2);
//            System.out.println(p);
//
//        }catch (Exception ex){
//            ex.printStackTrace();
//        }
        VPrincipal formularioPri=new VPrincipal();

        formularioPri.setVisible(true);



    }
}
