-- exec dbo.procREL_PEDIDO '{"dtinicial":"01/01/2023","dtfinal":"31/12/2023","vendedor_id":"0"}'
/*
PARÂMETRO: JSON
VALOR RECEBIDO: '{"dtinicial":"01/01/2023","dtfinal":"31/12/2023","vendedor_id":"1"}'
*/

drop procedure procREL_PEDIDO
go

create procedure procREL_PEDIDO @json varchar(max)
as
begin

declare
    @dtinicial datetime
  , @dtfinal datetime
  , @vendedor_id int
  , @comissao1 numeric(18,4)
  , @comissao2 numeric(18,4)
  , @comissao3 numeric(18,4)
  , @bonus numeric(18,4)
  , @vendedorMax int
  , @vendedorMin int

  select
      @dtinicial   = dtinicial
    , @dtfinal     = dtfinal
    , @vendedor_id = isnull(vendedor_id,0)
  from
    openjson(@json) 
    with (
            dtinicial   datetime '$.dtinicial'
          , dtfinal     datetime '$.dtfinal'
          , vendedor_id int '$.vendedor_id'
         )

  -- DEFININDO OS PERCENTUAIS DE COMISSÃO
  set @comissao1 = 5.0000
  set @comissao2 = 10.0000
  set @comissao3 = 10.0000
  set @bonus     = 20.0000

  -- PEGANDO OS TOTAIS POR VENDEDOR
  select 
        v.vendedor_id
      , v.valorvenda
      , v.valordesconto
      , v.valortotal
      , cast(10.0000 as numeric(18,4)) as percentualcomissao
      , cast(0.0000 as numeric(18,4)) as percentualbonificacao
      , cast(0.0000 as numeric(18,4)) as valorcomissao
      , cast(0.0000 as numeric(18,4)) as valorbonificacao
  
  into #TOTAL
  from (
    select 
        p.vendedor_id
        , sum(p.pedido_valorvenda) as valorvenda
        , sum(p.pedido_valordesconto) as valordesconto
        , sum(p.pedido_valortotal) as valortotal
    from T_PEDIDO p with(nolock)
    where p.pedido_data between @dtinicial and @dtfinal
    group by 
        p.vendedor_id ) v
 

  -- PEGANDO O VENDEDOR COM MAIOR VENDA
  select top 1 @vendedorMax = vendedor_id
  from #TOTAL
  order by valorvenda desc

  -- PEGANDO O VENDEDOR COM MENOR VENDA
  select top 1 @vendedorMin = vendedor_id
  from #TOTAL
  order by valorvenda

  set @vendedorMax = isnull(@vendedorMax, 0)
  set @vendedorMin = isnull(@vendedorMin, 0)

  --ATUALIZANDO OS PERCENTUAIS
  update #TOTAL
  set percentualcomissao = 10.0000
  , percentualbonificacao = 20.0000
  where vendedor_id = @vendedorMax

  update #TOTAL
  set percentualcomissao = 5.0000
  where vendedor_id = @vendedorMin
  and @vendedorMin <> @vendedorMax
  
  -- CALCULANDO A COMISSÃO GERAL (PODERÁ SER USADO EM UM RESUNO GERAL DE VENDAS)
  -- NO RELATÓRIO USO A SOMA DAS COLUNAS DE COMISSÃO E BONIFICACAO.
  update #TOTAL
  set valorcomissao = round((valortotal * percentualcomissao) / 100, 2)
  , valorbonificacao = case when percentualbonificacao > 0 then round( ( ( (valortotal * percentualcomissao) / 100 ) * percentualbonificacao ) / 100 , 2) 
                            else 0 
                       end
  where percentualcomissao > 0 and valortotal > 0
  
  -- SELECT DOS VENDEDORES DO PERIODO COM VENDAS 
  -- UNION ALL
  -- COM OS VENDEDORES SEM VENDAS NO PERÍODO
  select 
        p.pedido_id
      , p.pedido_data
      , p.pedido_valorvenda
      , p.pedido_valordesconto
      , p.pedido_valortotal
      , round((p.pedido_valortotal * t.percentualcomissao) / 100, 2) as valorcomissao
      , case when t.percentualbonificacao > 0 then round( ( ( (p.pedido_valortotal * t.percentualcomissao) / 100 ) * t.percentualbonificacao ) / 100 , 2) 
             else 0 
        end as valorbonificacao
      , p.vendedor_id
      , v.vendedor_nome
      , t.percentualcomissao
      , t.percentualbonificacao

  from T_PEDIDO p with(nolock)
  inner join T_VENDEDOR v with(nolock) on v.vendedor_id = p.vendedor_id
  inner join #TOTAL t on t.vendedor_id = p.vendedor_id
  where p.pedido_data between @dtinicial and @dtfinal
  and ( (@vendedor_id = 0)
        or
        (p.vendedor_id = @vendedor_id)
      )

  union all

  select 
        null as pedido_id
      , @dtinicial as pedido_data
      , 0.0000 as pedido_valorvenda
      , 0.0000 as pedido_valordesconto
      , 0.0000 as pedido_valortotal
      , 0.0000 as valorcomissao
      , 0.0000 as valorbonificacao
      , vendedor_id
      , concat(vendedor_nome, ' (SEM VENDAS NO PERÍODO)') as vendedor_nome
      , 0.0000 as percentualcomissao
      , 0.0000 as percentualbonificacao

  from T_VENDEDOR v with(nolock)
  where not exists(select 1 from #TOTAL where #TOTAL.vendedor_id = v.vendedor_id)
  and ( (@vendedor_id = 0)
        or
        (v.vendedor_id = @vendedor_id)
      )
  order by v.vendedor_nome, p.pedido_data

  drop table #TOTAL

end