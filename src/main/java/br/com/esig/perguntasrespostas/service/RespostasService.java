package br.com.esig.perguntasrespostas.service;

import br.com.esig.perguntasrespostas.persistence.model.Perguntas;
import br.com.esig.perguntasrespostas.persistence.model.Respostas;

import java.util.List;

public interface RespostasService {

    Respostas salvar(Respostas respostas);

    List<Respostas> recuperar(Perguntas filtro);

    List<Respostas> recuperarTodas();

    Respostas recuperarPorId(Long id);

    void atualizar(Respostas respostas);

    void excluir(Long id);
}
