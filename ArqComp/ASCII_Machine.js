    let contador = 0;

    function trocarAba(aba) {
        document.querySelectorAll('.tab').forEach(t => t.classList.remove('active'));
        document.querySelectorAll('.conteudo').forEach(c => c.style.display = 'none');

        if (aba == 'converter') {
            document.querySelectorAll('.tab')[0].classList.add('active');
            document.getElementById('converter').style.display = 'block';
        } else {
            document.querySelectorAll('.tab')[1].classList.add('active');
            document.getElementById('somar').style.display = 'block';
        }

        resultado.innerHTML = '';
    }

    function adicionarCampo() {

        let div = document.createElement('div');
        div.className = 'linha';
        div.id = 'linha' + contador;

        div.innerHTML = `
            <select id="base${contador}">
                <option value="2">Binário</option>
                <option value="8">Octal</option>
                <option value="10" selected>Decimal</option>
                <option value="16">Hexadecimal</option>
            </select>

            <input id="valor${contador}" placeholder="Valor">

            <button class="remover" onclick="removerCampo(${contador})">Remover</button>
        `;

        campos.appendChild(div);
        contador++;
    }

    function removerCampo(id) {
        document.getElementById('linha' + id).remove();
    }

    function validar(valor, base) {
        let regex;

        if (base == 2) regex = /^[01]+$/;
        if (base == 8) regex = /^[0-7]+$/;
        if (base == 10) regex = /^[0-9]+$/;
        if (base == 16) regex = /^[0-9A-Fa-f]+$/;

        return regex.test(valor);
    }

    function somar() {

        let soma = 0;
        let erro = false;

        for (let i = 0; i < contador; i++) {

            let input = document.getElementById('valor' + i);
            let baseEl = document.getElementById('base' + i);

            if (!input) continue;

            let valor = input.value;
            let base = Number(baseEl.value);

            input.classList.remove('erroCampo');

            if (!validar(valor, base)) {
                input.classList.add('erroCampo');
                erro = true;
                continue;
            }

            soma += parseInt(valor, base);
        }

        if (erro) {
            resultado.innerHTML = '<b style="color:red;">Corrija os campos destacados!</b>';
            return;
        }

        let baseRes = Number(baseResultado.value);
        let final = soma.toString(baseRes).toUpperCase();

        resultado.innerHTML = `<b>Resultado:</b> ${final}`;

        historico.innerHTML += `<div>Resultado: ${final}</div>`;
    }

    function converterValor() {

        let valor = valorConv.value;
        let b1 = Number(baseEntrada.value);
        let b2 = Number(baseSaida.value);

        if (!validar(valor, b1)) {
            resultado.innerHTML = '<b style="color:red;">Valor inválido!</b>';
            return;
        }

        let decimal = parseInt(valor, b1);
        let final = decimal.toString(b2).toUpperCase();

        resultado.innerHTML = `<b>Resultado:</b> ${final}`;

        historico.innerHTML += `<div>${valor} → ${final}</div>`;
    }

    adicionarCampo();
    adicionarCampo();