package model;

public class Direccion {
    private Integer id;
    private Usuario usuario;
    private String direccion;
    private Integer cp;
    private String ciudad;
    private String estado;
    private String pais;

    public Direccion(String direccion) {
        this.direccion = direccion;
    }

    public Direccion(int id, Usuario usuario, String direccion, int cp, String ciudad, String estado, String pais) {
        this.id = id;
        this.usuario = usuario;
        this.direccion = direccion;
        this.cp = cp;
        this.ciudad = ciudad;
        this.estado = estado;
        this.pais = pais;
    }

    public Direccion() {

    }

    public Direccion(Integer id) {
        this.id = id;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Usuario getUsuario() {
        return usuario;
    }

    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public int getCp() {
        return cp;
    }

    public void setCp(int cp) {
        this.cp = cp;
    }

    public String getCiudad() {
        return ciudad;
    }

    public void setCiudad(String ciudad) {
        this.ciudad = ciudad;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public String getPais() {
        return pais;
    }

    public void setPais(String pais) {
        this.pais = pais;
    }

    @Override
    public String toString() {
        return "Direccion [id=" + id + ", usuario=" + usuario.toString() + ", direccion=" + direccion + ", cp=" + cp
                + ", ciudad="
                + ciudad + ", estado=" + estado + ", pais=" + pais + "]";
    }

}
