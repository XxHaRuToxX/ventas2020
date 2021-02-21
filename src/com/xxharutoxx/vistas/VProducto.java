package com.xxharutoxx.vistas;

import com.xxharutoxx.controladores.CProducto;
import com.xxharutoxx.controladores.CProveedor;
import com.xxharutoxx.modulos.Producto;
import com.xxharutoxx.modulos.Proveedor;


import javax.swing.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class VProducto {
    private JPanel panel1;
    private JTextField txtNombre;
    private JTextField txtDescripcion;
    private JTextField txtPrecio;
    private JTextField txtStock;
    private JButton btnGuardarProducto;
    private JTextField txtId;
    private JButton btnBuscar;
    private JLabel lbID;
    private JTextField txtCantidad;
    private JCheckBox checkProducto;
    private JLabel JIdPro;
    private Proveedor prove;
    private Producto produ;


    public VProducto() {

            btnBuscar.addActionListener(new ActionListener() {
                @Override
                public void actionPerformed(ActionEvent e) {
                    if(checkProducto.isSelected()){
                        consultarProducto(Integer.parseInt(txtId.getText()));
                    }else {
                        consultarProveedor(Integer.parseInt(txtId.getText()));
                    }
                }
            });
            btnGuardarProducto.addActionListener(new ActionListener() {
                @Override
                public void actionPerformed(ActionEvent e) {
                    if(checkProducto.isSelected()){
                        actualizarProducto();
                    }else {
                        agregarProducto();
                    }

                }
            });

        checkProducto.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                if(checkProducto.isSelected()){
                    checkProducto.setText("Actualizar");
                    JIdPro.setText("ID PRODUCTO");
                    btnGuardarProducto.setText("ACTUALIZAR");
                }else{
                    checkProducto.setText("Agregar");
                    JIdPro.setText("ID PROVEEDOR");
                    btnGuardarProducto.setText("AGREGAR");
                }
            }
        });
    }

    public JPanel getPanel(){
        return panel1;
    }
    private void consultarProveedor(int _id){
        prove=CProveedor.traerProveedor(_id);
        if(prove==null){
            JOptionPane.showMessageDialog(null,"No existe");
        }else{
            lbID.setText(prove.getRuc());
        }
    }
    private void agregarProducto(){
        String nombre = txtNombre.getText();
        String descripcion=txtDescripcion.getText();
        float precio=Float.parseFloat(txtPrecio.getText());
        int stock=Integer.parseInt(txtStock.getText());
        int cantidad=Integer.parseInt(txtCantidad.getText());

        if(!prove.agregarProducto(nombre,descripcion,precio,stock,cantidad)){
            JOptionPane.showMessageDialog(null, "Producto agregado correctamente :)");
            limpiarControles();
        } else {
            JOptionPane.showMessageDialog(null, "Producto no agregado correctamente :(");
        }
    }
    private void limpiarControles(){
        txtNombre.setText(null);
        txtDescripcion.setText(null);
        txtPrecio.setText(null);
        txtStock.setText(null);
        txtCantidad.setText(null);
    }
    public void consultarProducto(int _id){
        produ=CProducto.tarerProducto(_id);
        if(produ==null){
            JOptionPane.showMessageDialog(null,"No Existe producto");
        }else{
            lbID.setText(produ.getNombre());
        }
    }
    private void actualizarProducto(){
        produ=CProducto.nuevoproducto(txtNombre.getText(),txtDescripcion.getText(),Float.parseFloat(txtPrecio.getText()),Integer.parseInt(txtStock.getText()));
        produ.setEsNuevo('a');
        produ.setId_producto(Integer.parseInt(txtId.getText()));
        try{
            if(!produ.save()){
                JOptionPane.showMessageDialog(null,"Actualizado correctamente");
            }else{
                JOptionPane.showMessageDialog(null,"No se actualizo");
            }
        }catch (Exception ex){
            ex.printStackTrace();
        }

    }

}
