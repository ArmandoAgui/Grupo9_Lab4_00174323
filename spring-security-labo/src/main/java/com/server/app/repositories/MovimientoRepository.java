package com.server.app.repositories;

import java.time.LocalDateTime;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.server.app.entities.finance.Movimiento;

public interface MovimientoRepository extends JpaRepository<Movimiento, Long> {

    @Query("""
            select m from Movimiento m
            where m.cuenta.usuario.id = :usuarioId
              and (:desde is null or m.fecha >= :desde)
              and (:hasta is null or m.fecha <= :hasta)
            """)
    Page<Movimiento> findByUsuarioAndFechaBetween(
            @Param("usuarioId") Integer usuarioId,
            @Param("desde") LocalDateTime desde,
            @Param("hasta") LocalDateTime hasta,
            Pageable pageable
    );
}
