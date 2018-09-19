### 2017_a campaign data

## Admin roles

civio = Admin::Role.create(email: '@civio.es')
dev = Voter.create(email: 'dev@civio.es', verified: true)

## Classifiers

# Districts
polideportivo = District.create(name: 'Polideportivo')
cordeldehoyo  = District.create(name: 'Cordel de Hoyo')
municipio     = District.create(name: 'Municipio')
dehesa        = District.create(name: 'Avenida de la Dehesa')
bomberos      = District.create(name: 'Los Bomberos')

# Areas
urbanismo    = Area.create(name: 'Urbanismo y Medio Ambiente')
deportes     = Area.create(name: 'Actividad Física y Deportes')
comunicacion = Area.create(name: 'Comunicación')
cultura      = Area.create(name: 'Cultura y Patrimonio')
educacion    = Area.create(name: 'Educación, Juventud e Infancia')
sanidad      = Area.create(name: 'Servicios Sociales y Sanidad')

# Tags
# no tags

## Campaign

octubre_2017 =  Campaign.create(
                  title: "Presupuestos participativos 2018",
                  budget: 100_000.0,
                  start_date: '2017-10-01',
                  end_date: '2017-10-15',
                  active: true,
                  description: <<~EOD.squish
                    Paralelamente a la votación de presupuestos participativos 2017
                    en junio abrimos la fase de consulta para recoger las propuestas
                    de cara a la votación de los presupuestos participativos 2018,
                    programada del 1 al 15 de octubre.
                  EOD
                )

## Proposals

tatami =  Proposal.create(
            title: "Tatami",
            budget: 7_500.0,
            classifiers: [polideportivo, deportes],
            campaign: octubre_2017,
            description: <<~EOD.squish
              Instalación de nuevo tatami en Polideportivo. Se propone la adquisición
              de un tatami de última generación para la sala de artes marciales,
              que sea transportable para posibles actividades en otros emplazamientos,
              y con los materiales que en este momento se están incorporando a la
              práctica de deportes como judo, kárate, aikido, taichí o taekwondo.
              Todos ellos practicados en Torrelodones.
            EOD
          )

circuito_canino = Proposal.create(
                    title: "Circuito canino",
                    budget: 10_000.0,
                    classifiers: [cordeldehoyo, urbanismo],
                    campaign: octubre_2017,
                    description: <<~EOD.squish
                      Ampliación de la zona de circuito canino (agility) en
                      Cordel de Hoyo.
                    EOD
                  )

carril_bici_ejecucion = Proposal.create(
                          title: "Ampliación de carril bici: ejecución",
                          budget: 50_000.0,
                          classifiers: [municipio, urbanismo],
                          campaign: octubre_2017,
                          description: <<~EOD.squish
                            Ampliación de carril bici. Actuación a llevar a cabo con posterioridad
                            a la realización de un estudio previo que determine la viabilidad y
                            mejor ubicación del mismo.
                          EOD
                        )

talonar_circuito =  Proposal.create(
                      title: "Talonar un circuito de carreras",
                      budget: 4_000.0,
                      classifiers: [dehesa, deportes],
                      campaign: octubre_2017,
                      description: <<~EOD.squish
                        Talonar un circuito de carreras a partir de la futura pista de atletismo.
                        Se trata de trazar un circuito que incorpore zona urbana y de monte de
                        Torrelodones, con los puntos de inicio y final en la pista de atletismo
                        de la Avenida de la Dehesa, cuidando y habilitando en caso necesario el
                        recorrido, y marcándolo con señalizaciones verticales, tanto en los puntos
                        kilométricos como en los cruces de caminos. Es una gran recurso para
                        deportistas que necesitan llevar un control sobre las distancias y/o los
                        tiempos de sus entrenamientos de carrera, marcha o paseo.
                      EOD
                    )

guia_escalada = Proposal.create(
                  title: "Guía de escalada",
                  budget: 7_500.0,
                  classifiers: [municipio, deportes, comunicacion],
                  campaign: octubre_2017,
                  description: <<~EOD.squish
                    Realización una guía de escalada (versión digital/web). Con esta pequeña guía,
                    se pretende dar a conocer y compartir una pequeña muestra de los bloques más
                    escalados de Torrelodones.
                  EOD
                )

herpetofauna =  Proposal.create(
                  title: "Recuperación de habitats herpetofauna",
                  budget: 10_500.0,
                  classifiers: [municipio, urbanismo],
                  campaign: octubre_2017,
                  description: <<~EOD.squish
                    Recuperación de habitats para la mejora y conservación de herpetofauna en
                    Torrelodones. Creación de una charca para anfibios en terrenos titularidad
                    del ayuntamiento de Torrelodones, con el fin de ayudar a la herpetofauna
                    del área de Torrelodones a tener puntos de cría y reproducción que permitan
                    la recuperación de sus poblaciones en esta zona. Se podrá emplear esta zona
                    para sensibilización e información de ciudadanos y como punto educativo
                    visitable.
                  EOD
                )

colores_paneles = Proposal.create(
                    title: '"Colores en paneles"',
                    budget: 3_000.0,
                    classifiers: [bomberos, urbanismo],
                    campaign: octubre_2017,
                    description: <<~EOD.squish
                      Propuesta infantil "colores en paneles" en subida al puente
                      sobre la A6 en sentido hacia "Los Bomberos", con el fin de
                      evitar el choque de los pájaros.
                    EOD
                  )

circuito_biosaludable = Proposal.create(
                          title: "Circuito biosaludable",
                          budget: 12_500.0,
                          classifiers: [cordeldehoyo, urbanismo],
                          campaign: octubre_2017,
                          description: <<~EOD.squish
                            Instalación de circuito biosaludable para adultos en
                            Cordel de Hoyo.
                          EOD
                        )

tenis_mesa =  Proposal.create(
                title: "Circuito biosaludable",
                budget: 3_000.0,
                classifiers: [polideportivo, deportes],
                campaign: octubre_2017,
                description: <<~EOD.squish
                  Instalación de mesas de tenis de mesa en el Polideportivo.
                  Una en el exterior, antivandálica, en alguna zona de espera,
                  para ofrecer una actividad más a la población que suele
                  acompañar a quienes van a practicar algún deporte, y otra
                  mesa ubicada en el interior para que se pueda practicar
                  tenis de mesa como actividad física en nuestro polideportivo.
                EOD
              )

festival_poesia = Proposal.create(
                    title: "Circuito biosaludable",
                    budget: 12_500.0,
                    classifiers: [municipio, cultura],
                    campaign: octubre_2017,
                    description: <<~EOD.squish
                      Con el objetivo de dinamizar el tejido cultural del municipio,
                      durante un fin de semana se realizarán actividades que aporten
                      nuevas visiones de la poesía.
                    EOD
                  )

inteligencia_emocional =  Proposal.create(
                            title: "Programas de inteligencia emocional",
                            budget: 14_500.0,
                            classifiers: [municipio, educacion, sanidad],
                            campaign: octubre_2017,
                            description: <<~EOD.squish
                              Desarrollo de programas de inteligencia emocional en
                              centros educativos y de atención a tercera edad.
                              Tiene como finalidad el desarrollo en los ciudadanos
                              de nuestro municipio (niños, adolescentes, padres y
                              tercera edad) de habilidades emocionales y sociales,
                              a través de la Inteligencia Emocional.
                            EOD
                          )

carril_bici_estudio = Proposal.create(
                        title: "Ampliación de carril bici: estudio previo",
                        budget: 15_000.0,
                        classifiers: [municipio, urbanismo],
                        campaign: octubre_2017,
                        description: <<~EOD.squish
                          Ampliación de carril bici. Realización de un estudio previo
                          que determine la viabilidad y mejor ubicación del mismo.
                        EOD
                      )

