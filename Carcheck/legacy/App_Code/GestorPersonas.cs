using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Collections;

namespace CarCheck.Gestores
{

  /// <summary>
  /// Summary description for GestorPersonas
  /// </summary>
  public class DatosPersona
  {
    public string persona = "";
    public string personaId = "";
    public string tfijo = "";
    public string tfax = "";
    public string direccion = "";
    public string ubigeoId = "";
    public string ubigeo = "";
    public string tdoidId = "-1";
    public string docid = "";
    public string email = "";
    public string otroTelefono = "";
    public string personaFlag = "usuario no encontrado";
    public string personaJuridicaFlag = "0";
    public DatosPersona()
    {
    }
  }

  public class Contacto
  {
    public string persona = "";
    public string telefono1 = "";
    public string telefono2 = "";
    public string cargo = "";
    public string oficina = "";
    public string email = "";
    public string personaFlag = "usuario no encontrado";
    public Contacto()
    {
    }
  }

  public class Asegurado
  {
      public string personaId = "";
      public string persona = "";
      public string direccionTrabajo = "";
      public string distritoTrabajo = "";
      public string ubigeoIdTrabajo = "";
      public string email = "";
      public string TDocumentoIdentidad = "-1";
      public string DocumentoIdentidad = "";
      public string TelefonoFijo1 = "";
      public string TelefonoFijo2 = "";
      public string Fax = "";
      public string brevete = "";
      public string brevetefExpedicion = "";
      public string brevetefVencimiento = "";
      public string ocupacionGiro = "";
  }

  public class GestorPersonas
  {
    public GestorPersonas()
    {
      //
      // TODO: Add constructor logic here
      //
    }
    public static DatosPersona performDataSearch(decimal personaId_decimal)
    {
      dsContratanteTableAdapters.ContratanteTableAdapter ta = new dsContratanteTableAdapters.ContratanteTableAdapter();
      dsContratante.ContratanteDataTable dt = ta.GetDataByPersonaId(personaId_decimal);

      DatosPersona p = new DatosPersona();

      if (dt.Rows.Count > 0)
      {
        dsContratante.ContratanteRow row = (dsContratante.ContratanteRow)dt.Rows[0];
        p.personaFlag = "usuario encontrado";
        try
        {
            p.email = row.email;
        }
        catch (Exception ex)
        { }
        try
        {
            p.otroTelefono = row.TelefonoFijo2;
        }
        catch (Exception ex)
        { }
        try
        {
            p.personaId = "" + row.personaid;
        }
        catch (Exception ex)
        { }
        try
        {
          p.persona = row.persona;
        }
        catch (Exception ex)
        { }
        try
        {
          p.tfijo = row.TelefonoFijo1;
        }
        catch (Exception ex)
        { }
        try
        {
          p.tfax = row.Fax;
        }
        catch (Exception ex)
        {
        }
        try
        {
          p.direccion = row.direccionTrabajo;
        }
        catch (Exception ex)
        {
        }
        try
        {
          p.ubigeoId = row.ubigeoIdTrabajo;
        }
        catch (Exception ex)
        {
        }
        try
        {
          p.ubigeo = row.distritoTrabajo;
        }
        catch (Exception ex)
        {
        }
        try
        {
          p.tdoidId = row.TDocumentoIdentidad;
          // p.tdoidId = d.ToString();
        }
        catch (Exception ex)
        {
          p.tdoidId = "-1";
        }
        try
        {
          p.docid = row.DocumentoIdentidad.ToString();
        }
        catch (Exception ex)
        {
          p.docid = "";
        }
        //try
        //{
        //    p.personaJuridicaFlag = row.chkPersonaJuridica.ToString();
        //}
        //catch (Exception ex)
        //{
        //    p.personaJuridicaFlag = "0";
        //}
      }
      return p;

    }
    public static Asegurado performDataSearchAsegurado(decimal personaId_decimal)
    {
      dsContratanteTableAdapters.ContratanteTableAdapter ta = new dsContratanteTableAdapters.ContratanteTableAdapter();
      dsContratante.ContratanteDataTable dt = ta.GetDataByPersonaId(personaId_decimal);
      dsAseguradoTableAdapters.AseguradoTableAdapter aseguradota = new dsAseguradoTableAdapters.AseguradoTableAdapter();
      dsAsegurado.AseguradoDataTable aseguradodt = aseguradota.GetDataById(Convert.ToInt32(personaId_decimal));

      Asegurado p = new Asegurado();

      if (dt.Rows.Count > 0)
      {
        dsContratante.ContratanteRow row = (dsContratante.ContratanteRow)dt.Rows[0];
        
      
        try
        {
            dsAsegurado.AseguradoRow aseguradoRow = (dsAsegurado.AseguradoRow)aseguradodt.Rows[0];
            p.ocupacionGiro = aseguradoRow.ocupacionGiro;
        }
        catch (Exception ex)
        { }
        try
        {
            dsAsegurado.AseguradoRow aseguradoRow = (dsAsegurado.AseguradoRow)aseguradodt.Rows[0];
            p.brevete = aseguradoRow.brevete;
        }
        catch (Exception ex)
        { }
        try
        {
            dsAsegurado.AseguradoRow aseguradoRow = (dsAsegurado.AseguradoRow)aseguradodt.Rows[0];
            p.brevetefExpedicion = ""+aseguradoRow.brevetefExpedicion;
        }
        catch (Exception ex)
        { }
        try
        {
            dsAsegurado.AseguradoRow aseguradoRow = (dsAsegurado.AseguradoRow)aseguradodt.Rows[0];
            p.brevetefVencimiento = ""+aseguradoRow.brevetefVencimiento;
        }
        catch (Exception ex)
        { }

        try
        {
            p.email = row.email;
        }
        catch (Exception ex)
        { }
        try
        {
            p.TelefonoFijo2 = row.TelefonoFijo2;
        }
        catch (Exception ex)
        { }
        try
        {
            p.personaId = "" + row.personaid;
        }
        catch (Exception ex)
        { }
        try
        {
          p.persona = row.persona;
        }
        catch (Exception ex)
        { }
        try
        {
            p.TelefonoFijo1 = row.TelefonoFijo1;
        }
        catch (Exception ex)
        { }
        try
        {
            p.Fax = row.Fax;
        }
        catch (Exception ex)
        {
        }
        try
        {
            p.direccionTrabajo = row.direccionTrabajo;
        }
        catch (Exception ex)
        {
        }
        try
        {
            p.ubigeoIdTrabajo = row.ubigeoIdTrabajo;
        }
        catch (Exception ex)
        {
        }
        try
        {
            p.distritoTrabajo = row.distritoTrabajo;
        }
        catch (Exception ex)
        {
        }
        try
        {
            p.TDocumentoIdentidad = row.TDocumentoIdentidad;
          // p.tdoidId = d.ToString();
        }
        catch (Exception ex)
        {
            p.TDocumentoIdentidad = "-1";
        }
        try
        {
            p.DocumentoIdentidad = row.DocumentoIdentidad.ToString();
        }
        catch (Exception ex)
        {
            p.DocumentoIdentidad = "";
        }
      }
      return p;

    }
    public static Contacto performDataContacto(decimal contactoId)
    {
      dsContactoTableAdapters.ContactoSolicitudTableAdapter ta= new dsContactoTableAdapters.ContactoSolicitudTableAdapter();
      dsContacto.ContactoSolicitudDataTable dt = ta.GetData(contactoId);

      Contacto p = new Contacto();

      if (dt.Rows.Count > 0)
      {
        dsContacto.ContactoSolicitudRow row = (dsContacto.ContactoSolicitudRow)dt.Rows[0];
        p.personaFlag = "usuario encontrado";
        try
        {
          p.email = row.email;
          p.telefono1 = row.telefono1;
          p.telefono2 = row.telefono2;
          
        }
        catch (Exception ex)
        { }
                      
               
      }
      return p;

    }
  }

}