package br.com.esig.perguntasrespostas.persistence.dao;

import br.com.esig.perguntasrespostas.persistence.model.Perguntas;

import java.util.List;

public interface PerguntasDao {

    void salvar(Perguntas perguntas);

    List<Perguntas> recuperar(String filtro);

    Perguntas recuperarPorId(Long id);

    void atualizar(Perguntas perguntas);

    void excluir(Long id);
}
