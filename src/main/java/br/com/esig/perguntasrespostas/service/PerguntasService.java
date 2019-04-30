package br.com.esig.perguntasrespostas.service;

import br.com.esig.perguntasrespostas.persistence.model.Perguntas;

import java.util.List;

public interface PerguntasService {

    Perguntas salvar(Perguntas perguntas);

    List<Perguntas> recuperar(String filtro);

    Perguntas recuperarPorId(Long id);

    void atualizar(Perguntas perguntas);

    void excluir(Long id);

}
