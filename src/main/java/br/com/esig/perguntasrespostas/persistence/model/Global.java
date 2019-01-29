package br.com.esig.perguntasrespostas.persistence.model;

public class Global {

    private static Global instance;

    private String email = null;
    private String nomeUser = null;
    private boolean logado = false;

    public Global(){}

    // Método público estático de acesso único ao objeto!
    public static Global getInstance() {
        if (instance == null)
            instance = new Global();
        return instance;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getNomeUser() {
        return nomeUser;
    }

    public void setNomeUser(String nomeUser) {
        this.nomeUser = nomeUser;
    }

    public boolean isLogado() {
        return logado;
    }

    public void setLogado(boolean logado) {
        this.logado = logado;
    }
}
