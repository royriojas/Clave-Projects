using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Collections.Generic;

/// <summary>
/// Summary description for GInspeccion_temp
/// </summary>
/// 

namespace CarCheck.Gestores
{
    public class GInspeccion_temp
    {
        [System.ComponentModel.DataObjectMethod(System.ComponentModel.DataObjectMethodType.Select)]
        public static List<Inspeccion> getInspecciones()
        {
            List<Inspeccion> inspeccionesTemp = new List<Inspeccion>();

            for (int i = 0; i < 6; i++)
            {

                Inspeccion ins = new Inspeccion();
                ins.CodigoInspeccion = i.ToString();
                ins.Placa = "RQ-000" + i;
                ins.Estado = (i % 3 == 0) ? "Pendiente" : (i % 2) == 0 ? "Frustrado" : "Agendado";
                ins.FInspeccion = DateTime.Now.AddDays(i + 2);
                ins.HInicio = DateTime.Now.AddHours(i + 1);
                ins.HFin = DateTime.Now.AddHours(i + 2);
                ins.Inspector = "Inspector " + i;
                ins.Direccion = "Direccion " + i;
                ins.UbigeoText = "Ubigeo " + i;
                ins.CodigoInspeccion = i.ToString();

                inspeccionesTemp.Add(ins);


            }
            return inspeccionesTemp;
        }
    }
    public class Inspeccion
    {
        private String placa;

        public String Placa
        {
            get { return placa; }
            set { placa = value; }
        }
        private String estado;

        public String Estado
        {
            get { return estado; }
            set { estado = value; }
        }
        private DateTime fInspeccion;

        public DateTime FInspeccion
        {
            get { return fInspeccion; }
            set { fInspeccion = value; }
        }
        private DateTime hInicio;

        public DateTime HInicio
        {
            get { return hInicio; }
            set { hInicio = value; }
        }
        private DateTime hFin;

        public DateTime HFin
        {
            get { return hFin; }
            set { hFin = value; }
        }
        private String inspector;

        public String Inspector
        {
            get { return inspector; }
            set { inspector = value; }
        }
        private String direccion;

        public String Direccion
        {
            get { return direccion; }
            set { direccion = value; }
        }
        private String ubigeoText;

        public String UbigeoText
        {
            get { return ubigeoText; }
            set { ubigeoText = value; }
        }
        private String codigoInspeccion;

        public String CodigoInspeccion
        {
            get { return codigoInspeccion; }
            set { codigoInspeccion = value; }
        }





    }
}