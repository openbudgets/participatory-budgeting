### Sample development data

## Admin roles

civio = Admin::Role.create(email: '@civio.es')

## Voters

raul    = Voter.create(email: 'raul@civio.es', verified: true)
david   = Voter.create(email: 'david@civio.es', verified: true)
eduardo = Voter.create(email: 'eduardo@civio.es', verified: true)

## Classifiers

# Districts
municipio   = District.create(name: 'Municipio')
pedanias    = District.create(name: 'Pedanías')
programas   = District.create(name: 'Programas de actuación')

# Areas
ambiente  = Area.create(name: 'Medio Ambiente')
deporte   = Area.create(name: 'Deportes')
urbanismo = Area.create(name: 'Urbanismo')
cultura   = Area.create(name: 'Cultura y Patrimonio')
parques   = Area.create(name: 'Parques y Jardines')
sanidad   = Area.create(name: 'Sanidad')

# Tags
energia      = Tag.create(name: 'Energía')
juegos       = Tag.create(name: 'Juegos')
equipamiento = Tag.create(name: 'Equipamiento')
salud        = Tag.create(name: 'Salud')
accesos      = Tag.create(name: 'Accesos')
parques      = Tag.create(name: 'Parques')
movilidad    = Tag.create(name: 'Movilidad')
espectaculos = Tag.create(name: 'Espectáculos')
formacion    = Tag.create(name: 'Formación')

## Campaigns

nov_2016  = Campaign.create(
              title: "Presupuestos participativos 2016",
              budget: 160_000.00,
              start_date: '2016-11-07',
              end_date: '2017-11-14',
              active: true,
              description: <<~EOD.squish
                El principal objetivo de los presupuestos participativos es
                fomentar la participación y formar ciudadanos activos. En el
                proceso de unos presupuestos participativos, son los ciudadanos
                los que van a decidir en qué se gasta el presupuesto municipal.
                Por tanto, hablar de presupuestos participativos es hablar de
                información, transparencia en la gestión, debate y participación
                directa de los vecinos en los asuntos públicos.
              EOD
            )

## Proposals

municipio_1 = Proposal.create(
                title: 'Acondicionar el auditorio municipal Tierno Galván (fase 1)',
                budget: 40_000.00,
                classifiers: [municipio, cultura, espectaculos],
                campaign: nov_2016,
                description: <<~EOD.squish
                  Destinar 40.000 € a la ejecución de obras de mejora en el
                  Auditorio. La partida se destinaría a una primera fase que
                  incluiría la reparación de la estructura del graderío y la
                  reposición de asientos.
                EOD
              )
municipio_2 = Proposal.create(
                title: 'Renovación de zona de juegos infantiles',
                budget: 40_000.00,
                classifiers: [municipio, parques, juegos],
                campaign: nov_2016,
                description: <<~EOD.squish
                  La propuesta se centra en la mejora de las áreas de juegos
                  infantiles en los jardines, priorizando los que más lo
                  necesiten. Se estudiará la mejora de iluminación en zonas
                  puntuales, la mejora de los juegos incluyendo juegos adaptados
                  para niños con discapacidad, la reposición de pavimentos de
                  losetas, etc.
                EOD
              )
municipio_3 = Proposal.create(
                title: 'Apertura de las pistas deportivas de los colegios',
                budget: 20_000.00,
                classifiers: [municipio, deporte, juegos],
                campaign: nov_2016,
                description: <<~EOD.squish
                  Se propone el vallado de las pistas deportivas de los colegios
                  Ricardo Codorníu y Antonio Machado, con accesos independientes
                  para poder utilizarlos fuera del horario escolar.
                EOD
              )
municipio_4 = Proposal.create(
                title: 'Eficiencia energética en la piscina cubierta municipal',
                budget: 25_000.00,
                classifiers: [municipio, deporte, energia],
                campaign: nov_2016,
                description: <<~EOD.squish
                  La propuesta consiste en la sustitución de las dos calderas
                  de gas natural actuales por una única modulante, más moderna
                  y más eficiente. Instalación de sistema de “manta térmica”
                  para cubrir los vasos de la piscina en los períodos de no
                  utilización. Evita evaporación y enfriamiento del agua.
                  Sustitución de toda la iluminación actual por iluminación
                  LED, mucho más eficiente.

                  Ahorro estimado con estas tres medidas: 12% del coste total
                  en energía.
                EOD
              )
pedanias_1  = Proposal.create(
                title: 'Pedanías Cardioprotegidas',
                budget: 10_000.00,
                classifiers: [pedanias, sanidad, salud],
                campaign: nov_2016,
                description: <<~EOD.squish
                  Adquirir 5 desfibriladores, uno para cada uno de las pedanías
                  y realizar campañas de formación a aquellos vecinos que lo
                  deseen con objetivo de formar espacios cardioprotegidos.
                EOD
              )

pedanias_2  = Proposal.create(
                title: 'Senda Gebas - Alhama',
                budget: 8_000.00,
                classifiers: [pedanias, urbanismo, accesos],
                campaign: nov_2016,
                description: <<~EOD.squish
                  La propuesta contempla acondicionar nuevos tramos de los
                  antiguos senderos de La Muela y los Barrancos de Gebas. Con
                  ellos se recuperaría uno de los más antiguos recorridos utilizados
                  por los geberos para venir con sus bestias hasta Alhama (el
                  resto de los senderos sólo permitían el paso de personas. Por
                  tanto, se trata de una importante recuperación patrimonial de
                  repercusión cultural y ambiental.

                  Esta propuesta está casi en su totalidad incluida en el Proyecto
                  de recuperación de los senderos tradicionales de la Sierra de
                  la Muela. De momento, existe financiación fuera de este proceso
                  para atender los trazados de La Rellana y los corrales de la
                  casa de Don Lázaro. Sería conveniente esperar a ver los resultados
                  de los trabajos que ahora van a comenzar y que se van a desarrollar
                  hasta marzo de 2017 para ver qué partes se pueden llegar a hacer
                  y cuáles se quedarían para concluir por otra vía presupuestaria.
                EOD
              )
pedanias_3  = Proposal.create(
                title: 'Colocar marquesinas en las paradas de autobús escolares',
                budget: 10_000.00,
                classifiers: [pedanias, urbanismo, movilidad],
                campaign: nov_2016,
                description: <<~EOD.squish
                  Instalación de marquesinas para paradas de autobús escolar en
                  Venta Aledo y Condado de Alhama (10.000 € por unidad).
                EOD
              )
programas_1 = Proposal.create(
                title: 'Campaña de sensibilización sobre movilidad reducida',
                budget: 12_000.00,
                classifiers: [programas, urbanismo, formacion],
                campaign: nov_2016,
                description: <<~EOD.squish
                  Instalación de escalera en la Atalaya de Torrelodones.
                EOD
              )
programas_2 = Proposal.create(
                title: 'La bici como medio de transporte',
                budget: 3_000.00,
                classifiers: [programas, ambiente, salud],
                campaign: nov_2016,
                description: <<~EOD.squish
                  Acciones para fomentar el uso de la bici en familia y campaña
                  de concienciación sobre los beneficios de desplazarse en bicicleta
                  a nivel de salud y a nivel medioambiental.
                EOD
              )
programas_3 = Proposal.create(
                title: 'Formación cívica y medioambiental',
                budget: 3_000.00,
                classifiers: [programas, ambiente, formacion],
                campaign: nov_2016,
                description: <<~EOD.squish
                  Formación para colegios e institutos y agentes de policía para
                  prevenir las agresiones medioambientales y contra los animales,
                  saber cómo actuar ante casos e infracciones y promover el respeto
                  al medio ambiente. Fomentar también la adopción de animales y
                  su tenencia responsable.
                EOD
              )
