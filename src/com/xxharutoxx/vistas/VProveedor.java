package com.xxharutoxx.vistas;

import com.xxharutoxx.modulos.Proveedor;
import com.xxharutoxx.controladores.CProveedor;


import javax.swing.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class VProveedor extends JFrame {
    private JPanel panel1;
    private JTextField txtRazonSocial;
    private JTextField txtDireccion;
    private JTextField txtTelefono;
    private JTextField txtRuc;
    private JButton btnAgregrarProveedor;
    private JCheckBox checkProveedor;
    private JPanel JPnIDProve;
    private JLabel JlbIdPove;
    private JTextField txtIDProve;
    private JButton btnBuscarId;
    private JLabel JLbRuc;
    private Proveedor provee;

    public VProveedor() {
        btnAgregrarProveedor.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                agregarProveedor();
            }
        });
        checkProveedor.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {

                if(!checkProveedor.isSelected()){
                    JPnIDProve.setVisible(false);

                }else{
                    JPnIDProve.setVisible(true);
                }
            }
        });
    }

    public JPanel getPanelP(){
        return panel1;
    }
    public void agregarProveedor(){

        String razonSocial=txtRazonSocial.getText();
        String direccion=txtDireccion.getText();
        String telefono=txtTelefono.getText();
        String ruc=txtRuc.getText();

        provee=CProveedor.crearProveedor(razonSocial,direccion,telefono,ruc);
        try {
            if (!provee.save()){
                JOptionPane.showMessageDialog(null,"Guardado");
                limpiarControlesp();
            }else{
                JOptionPane.showMessageDialog(null,"No guradado");
            }
        }catch (Exception ex){
            ex.printStackTrace();
        }
    }
    private void limpiarControlesp(){
        txtRazonSocial.setText(null);
        txtDireccion.setText(null);
        txtTelefono.setText(null);
        txtRuc.setText(null);
    }



}
