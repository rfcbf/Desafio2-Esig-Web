package br.com.esig.perguntasrespostas.service;

import br.com.esig.perguntasrespostas.persistence.dao.PerguntasDao;
import br.com.esig.perguntasrespostas.persistence.model.Perguntas;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class PerguntasServiceImpl implements PerguntasService {

    @Autowired
    private PerguntasDao perguntasDao;

    @Override
    public Perguntas salvar(Perguntas perguntas) {
        perguntasDao.salvar(perguntas);
        return perguntas;
    }

    @Override
    @Transactional(readOnly = true)
    public List<Perguntas> recuperar(String filtro) {
        return perguntasDao.recuperar(filtro);
    }

    @Override
    @Transactional(readOnly = true)
    public Perguntas recuperarPorId(Long id) {
        return perguntasDao.recuperarPorId(id);
    }

    @Override
    public void atualizar(Perguntas perguntas) {
        perguntasDao.atualizar(perguntas);
    }

    @Override
    public void excluir(Long id) {
        perguntasDao.excluir(id);
    }

}
