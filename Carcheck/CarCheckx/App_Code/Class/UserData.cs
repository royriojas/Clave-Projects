using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

namespace CarCheck.Gestores
{
  /// <summary>
  /// Summary description for atribucionesUsuario
  /// </summary>
  public class UserData
  {
    #region members

    private decimal _personaId;
    public decimal PersonaId
    {
      get
      {
        return _personaId;
      }
      set
      {
        _personaId = value;
      }
    }

    private string _userRolName;
    public string UserRolName
    {
      get
      {
        return _userRolName;
      }
      set
      {
        _userRolName = value;
      }
    }

    private string _persona;
    public string Persona
    {
      get
      {
        return _persona;
      }
      set
      {
        _persona = value;
      }
    }

    private string _userName;
    public string UserName
    {
      get
      {
        return _userName;
      }
      set
      {
        _userName = value;
      }
    }
    private decimal _userId;
    public decimal UserId
    {
      get
      {
        return _userId;
      }
      set
      {
        _userId = value;
      }
    }

    private decimal _ciaId;
    public decimal CiaId
    {
      get
      {
        return _ciaId;
      }
      set
      {
        _ciaId = value;
      }
    }

    private string _userRolNameId;
    public string UserRolNameId
    {
      get
      {
        return _userRolNameId;
      }
      set
      {
        _userRolNameId = value;
      }
    }

    private string  _ciaName;
    public string  CiaName
    {
      get
      {
        return _ciaName;
      }
      set
      {
        _ciaName = value;
      }
    }
    #endregion

    /// <summary>
    /// Initializes a new instance of the UserData class.
    /// </summary>
    public UserData()
    {
    }
        
    /// <summary>
    /// Initializes a new instance of the UserData class.
    /// </summary>
    /// <param name="personaId"></param>
    /// <param name="userRolName"></param>
    /// <param name="persona"></param>
    /// <param name="userName"></param>
    /// <param name="userId"></param>
    /// <param name="ciaId"></param>
    public UserData(decimal personaId, string userRolName, string persona, string userName, decimal userId, decimal ciaId)
    {
      _personaId = personaId;
      _userRolName = userRolName;
      _persona = persona;
      _userName = userName;
      _userId = userId;
      _ciaId = ciaId;
    }


  }        
}