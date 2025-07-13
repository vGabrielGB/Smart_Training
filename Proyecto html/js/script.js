let gruposMusculares = [];
let ejercicios = [];
let ejerciciosPorGrupo = {};

document.addEventListener('DOMContentLoaded', () => {

    // Cargar grupos musculares
    fetch('php/get_grupos_musculares.php')
        .then(res => res.json())
        .then(data => {
            gruposMusculares = data;
        });

    // Cargar ejercicios
    fetch('php/get_ejercicios.php')
        .then(res => res.json())
        .then(data => {
            ejercicios = data;
            // Construir ejerciciosPorGrupo para facilitar búsquedas
            ejerciciosPorGrupo = {};
            ejercicios.forEach(ej => {
                if (!ejerciciosPorGrupo[ej.id_grupo_principal]) ejerciciosPorGrupo[ej.id_grupo_principal] = [];
                ejerciciosPorGrupo[ej.id_grupo_principal].push(ej);
            });
        });

    const LIMITE_EJERCICIOS = 10;
    let diaActual = null;
    let gruposSeleccionadosPorDia = {};
    let rutinaUsuario = { Lunes: [], Martes: [], Miercoles: [], Jueves: [], Viernes: [], Sabado: [], Domingo: [] };

    // --- ELEMENTOS DEL DOM ---
    const rutinaContainer = document.getElementById('rutina-container');
    const modalGrupos = document.getElementById('modal-grupos');
    const modalEjercicios = document.getElementById('modal-ejercicios');
    const listaGruposChecklist = document.getElementById('lista-grupos-checklist');
    const listaEjerciciosContainer = document.getElementById('lista-ejercicios');
    const confirmarGruposBtn = document.getElementById('confirmar-grupos-btn');

    window.abrirModal = (idModal) => document.getElementById(idModal).classList.remove('hidden');
    window.cerrarModal = (idModal) => document.getElementById(idModal).classList.add('hidden');

    // 1. CLIC EN EL BOTÓN DE CABECERA DEL DÍA (PARA DEFINIR GRUPOS MUSCULARES)
    rutinaContainer.addEventListener('click', (e) => {
        if (e.target.classList.contains('dia-btn-header')) {
            diaActual = e.target.closest('.dia-entrenamiento').dataset.dia;
            document.getElementById('modal-grupos-titulo').textContent = `Define los grupos para el ${diaActual}`;

            // Espera a que gruposMusculares esté cargado
            if (!gruposMusculares || gruposMusculares.length === 0) {
                alert('Los grupos musculares aún no se han cargado. Espera unos segundos y vuelve a intentarlo.');
                return;
            }

            listaGruposChecklist.innerHTML = '';
            const gruposYaSeleccionados = gruposSeleccionadosPorDia[diaActual] || [];
            gruposMusculares.forEach(grupo => {
                const isChecked = gruposYaSeleccionados.includes(grupo.id_grupo_muscular.toString());
                listaGruposChecklist.innerHTML += `
                    <div class="grupo-checkbox-item">
                        <input type="checkbox" id="grupo-${grupo.id_grupo_muscular}" value="${grupo.id_grupo_muscular}" ${isChecked ? 'checked' : ''}>
                        <label for="grupo-${grupo.id_grupo_muscular}">${grupo.nombre_grupo}</label>
                    </div>`;
            });
            abrirModal('modal-grupos');
        }
    });

    // 2. GUARDAR LOS GRUPOS SELECCIONADOS AL CONFIRMAR EN EL PRIMER MODAL
    confirmarGruposBtn.addEventListener('click', () => {
        const seleccion = Array.from(listaGruposChecklist.querySelectorAll('input:checked')).map(cb => cb.value);
        gruposSeleccionadosPorDia[diaActual] = seleccion;

        const diaHeaderBtn = document.querySelector(`.dia-entrenamiento[data-dia="${diaActual}"] .dia-btn-header`);
        if (seleccion.length > 0) {
            diaHeaderBtn.classList.add('activo');
        } else {
            diaHeaderBtn.classList.remove('activo');
        }

        console.log("Grupos definidos:", gruposSeleccionadosPorDia);
        cerrarModal('modal-grupos');
    });

    // 3. CLIC EN EL BOTÓN "+ AGREGAR EJERCICIO" (PARA ELEGIR EJERCICIOS)
    rutinaContainer.addEventListener('click', (e) => {
        if (e.target.classList.contains('agregar-ejercicio-btn')) {
            diaActual = e.target.closest('.dia-entrenamiento').dataset.dia;
            const gruposParaHoy = gruposSeleccionadosPorDia[diaActual];

            if (!gruposParaHoy || gruposParaHoy.length === 0) {
                alert(`Primero haz clic en la cabecera "${diaActual}" para definir los grupos musculares.`);
                return;
            }

            listaEjerciciosContainer.innerHTML = '';
            gruposParaHoy.forEach(grupoId => {
                const grupo = gruposMusculares.find(g => Number(g.id_grupo_muscular) === Number(grupoId));
    const ejerciciosDelGrupo = ejerciciosPorGrupo[Number(grupoId)] || [];
    if (grupo) {
        listaEjerciciosContainer.innerHTML += `<h4>${grupo.nombre_grupo}</h4>`;
    }
                ejerciciosDelGrupo.forEach(ejercicio => {
                    // Verifica si el ejercicio ya está en la rutina del día actual
                    const yaSeleccionado = rutinaUsuario[diaActual].some(ej => ej.ejercicio_id === ejercicio.id_ejercicio);
                    listaEjerciciosContainer.innerHTML += `<button data-ejercicio-id="${ejercicio.id_ejercicio}" ${yaSeleccionado ? 'disabled style="opacity:0.5;"' : ''}>${ejercicio.nombre_ejercicio}</button>`;
                });
            });
            abrirModal('modal-ejercicios');
        }
    });

    // 4. SELECCIONAR Y AÑADIR UN EJERCICIO A LA COLUMNA
    listaEjerciciosContainer.addEventListener('click', (e) => {
        if (e.target.tagName === 'BUTTON') {
            if (rutinaUsuario[diaActual].length >= LIMITE_EJERCICIOS) {
                alert(`Límite de ${LIMITE_EJERCICIOS} ejercicios por día alcanzado.`);
                return;
            }
            const ejercicio = { id_ejercicio: e.target.dataset.ejercicioId, nombre_ejercicio: e.target.textContent };
            rutinaUsuario[diaActual].push({ 
                ejercicio_id: ejercicio.id_ejercicio, 
                nombre: ejercicio.nombre_ejercicio, 
                series: '', repeticiones: '', peso_kg: '', descanso_seg: '', orden: '' 
            });

            const plantilla = document.getElementById('plantilla-ejercicio').content.cloneNode(true);
            const itemDiv = plantilla.querySelector('.ejercicio-item');
            itemDiv.querySelector('.ejercicio-nombre').textContent = ejercicio.nombre_ejercicio;
            itemDiv.dataset.ejercicioId = ejercicio.id_ejercicio;
            document.querySelector(`[data-dia="${diaActual}"] .ejercicios-lista`).appendChild(plantilla);

            console.log("Rutina actualizada:", rutinaUsuario);
            cerrarModal('modal-ejercicios');
        }
    });

    // Mostrar tabla resumen al pulsar "Guardar cambios"
    document.getElementById('guardar-cambios-btn').addEventListener('click', () => {
        const contenedor = document.getElementById('tabla-resumen-container');
        let html = '<h2>Resumen de Rutina</h2>';
        html += '<table border="1" cellpadding="8" style="border-collapse:collapse;width:100%;background:white;">';
        html += '<thead><tr><th>Día</th><th>Ejercicio</th><th>Series</th><th>Reps</th><th>Peso (kg)</th><th>Descanso (s)</th><th>Orden</th></tr></thead><tbody>';

        let hayDatos = false;
        for (const dia in rutinaUsuario) {
            rutinaUsuario[dia].forEach(ej => {
                hayDatos = true;
                html += `<tr>
                    <td>${dia}</td>
                    <td>${ej.nombre}</td>
                    <td>${ej.series || ''}</td>
                    <td>${ej.repeticiones || ''}</td>
                    <td>${ej.peso_kg || ej.peso || ''}</td>
                    <td>${ej.descanso_seg || ej.descanso || ''}</td>
                    <td>${ej.orden || ''}</td>
                </tr>`;
            });
        }
        if (!hayDatos) {
            html += '<tr><td colspan="7" style="text-align:center;">No hay ejercicios seleccionados.</td></tr>';
        }
        html += '</tbody></table>';
        contenedor.innerHTML = html;
    });

    // Eliminar y actualizar inputs
    rutinaContainer.addEventListener('click', (e) => {
        if (e.target.classList.contains('eliminar-ejercicio-btn')) {
            const item = e.target.closest('.ejercicio-item');
            const dia = item.closest('.dia-entrenamiento').dataset.dia;
            const id = item.dataset.ejercicioId;
            rutinaUsuario[dia] = rutinaUsuario[dia].filter(ej => ej.ejercicio_id !== id);
            item.remove();
            console.log("Rutina actualizada:", rutinaUsuario);
        }
    });
    rutinaContainer.addEventListener('input', (e) => {
        if (e.target.tagName === 'INPUT') {
            const item = e.target.closest('.ejercicio-item');
            const dia = item.closest('.dia-entrenamiento').dataset.dia;
            const id = item.dataset.ejercicioId;
            const campo = e.target.name;
            const valor = e.target.value;
            const ejercicio = rutinaUsuario[dia].find(ej => ej.ejercicio_id === id);
            if(ejercicio) ejercicio[campo] = valor;
            console.log("Rutina actualizada:", rutinaUsuario);
        }
    });

    // Mostrar plantillas al hacer clic en el botón
    document.querySelector('#btn-plantilla').addEventListener('click', () => {
        fetch('php/get_plantillas.php')
            .then(res => res.json())
            .then(plantillas => {
                let html = '';
                plantillas.forEach(p => {
                    html += `<button data-id="${p.id_plantilla}">${p.nombre_plantilla}</button><br>`;
                });
                document.getElementById('lista-plantillas').innerHTML = html;
                document.getElementById('modal-plantillas').classList.remove('hidden');
            });
    });

    // Seleccionar una plantilla y cargar ejercicios
    document.getElementById('lista-plantillas').addEventListener('click', e => {
    if (e.target.tagName === 'BUTTON') {
        const id = e.target.dataset.id;
        fetch('php/get_ejercicios_plantilla.php?id_plantilla=' + id)
            .then(res => res.json())
            .then(datos => {
                // Limpiar rutinaUsuario y la interfaz
                for (const dia in rutinaUsuario) {
                    rutinaUsuario[dia] = [];
                    const lista = document.querySelector(`[data-dia="${dia}"] .ejercicios-lista`);
                    if (lista) lista.innerHTML = '';
                }
                // Recorrer los datos recibidos y renderizar
                for (const dia in datos) {
                    datos[dia].forEach(ej => {
                        rutinaUsuario[dia] = rutinaUsuario[dia] || [];
                        rutinaUsuario[dia].push({
                            ejercicio_id: ej.id_ejercicio,
                            nombre: ej.nombre_ejercicio,
                            series: ej.series,
                            repeticiones: ej.repeticiones,
                            peso_kg: ej.peso_recomendado_kg,
                            descanso_seg: ej.tiempo_descanso_seg,
                            orden: ej.orden
                        });
                        // Renderizar en el DOM
                        const plantilla = document.getElementById('plantilla-ejercicio').content.cloneNode(true);
                        const itemDiv = plantilla.querySelector('.ejercicio-item');
                        itemDiv.querySelector('.ejercicio-nombre').textContent = ej.nombre_ejercicio;
                        itemDiv.dataset.ejercicioId = ej.id_ejercicio;
                        itemDiv.querySelector('input[name="series"]').value = ej.series;
                        itemDiv.querySelector('input[name="repeticiones"]').value = ej.repeticiones;
                        itemDiv.querySelector('input[name="peso"]').value = ej.peso_recomendado_kg;
                        itemDiv.querySelector('input[name="descanso"]').value = ej.tiempo_descanso_seg;
                        itemDiv.querySelector('input[name="orden"]').value = ej.orden;
                        const lista = document.querySelector(`[data-dia="${dia}"] .ejercicios-lista`);
                        if (lista) lista.appendChild(plantilla);
                    });

                    // Marcar automáticamente los grupos musculares para ese día
                    const gruposDia = new Set();
                    datos[dia].forEach(ej => {
                        const ejercicioInfo = ejercicios.find(e => String(e.id_ejercicio) === String(ej.id_ejercicio));
                        if (ejercicioInfo) {
                            gruposDia.add(String(ejercicioInfo.id_grupo_principal));
                        }
                    });
                    gruposSeleccionadosPorDia[dia] = Array.from(gruposDia);
                    const diaHeaderBtn = document.querySelector(`.dia-entrenamiento[data-dia="${dia}"] .dia-btn-header`);
                    if (gruposDia.size > 0) {
                        diaHeaderBtn.classList.add('activo');
                    } else {
                        diaHeaderBtn.classList.remove('activo');
                    }
                }
                document.getElementById('modal-plantillas').classList.add('hidden');
            });
            }
        });

});