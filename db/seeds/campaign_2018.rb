### 2018 campaign data

## Admin roles

civio = Admin::Role.create(email: '@civio.es')
dev = Voter.create(email: 'dev@civio.es', verified: true)

## Classifiers

# Districts
municipio  = District.create(name: 'Municipio')
colonia    = District.create(name: 'La Colonia')
penascales = District.create(name: 'Los Peñascales')
pueblo     = District.create(name: 'Pueblo')
huertos    = District.create(name: 'Huertos Urbanos')
rozuelas   = District.create(name: 'Las Rozuelas')

# Areas
urbanismo    = Area.create(name: 'Urbanismo, Medio Ambiente y Obras')
deportes     = Area.create(name: 'Actividad Física y Deportes')
cultura      = Area.create(name: 'Cultura y Patrimonio')
comunicacion = Area.create(name: 'Comunicación')

# Tags
# no tags

## Campaign

september_2018 =  Campaign.create(
                    title: "Presupuestos participativos 2019",
                    budget: 100_000.0,
                    start_date: '2018-09-20',
                    end_date: '2018-10-20',
                    active: true,
                    description: <<~EOD.squish
                      En este segundo año de presupuestos participativos de
                      Torrelodones votaremos desde el 20 de septiembre al
                      20 de octubre de 2018 para elegir los proyectos que
                      serán ejecutados con cargo a los presupuestos de 2019.
                    EOD
                  )

## Proposals

guia_escalada = Proposal.create(
                  title: "Guía de escalada",
                  budget: 7_500.0,
                  classifiers: [municipio, deportes, comunicacion],
                  campaign: september_2018,
                  description: <<~EOD.squish
                    Realizar una guía de escalada (versión digital/web) donde se
                    identifiquen las zonas de escalada en nuestro municipio.
                  EOD
                )

aceras_mingo_alsina = Proposal.create(
                        title: "Remodelación aceras en calle Doctor Mingo Alsina",
                        budget: 20_000.0,
                        classifiers: [colonia, urbanismo],
                        campaign: september_2018,
                        description: <<~EOD.squish
                          Con el objetivo de mejorar el tránsito para todos los peatones
                          y, especialmente, para personas con movilidad reducida.
                        EOD
                      )

fondo_biblioteca = Proposal.create(
                    title: "Ampliación del fondo literario Biblioteca",
                    budget: 3_000.0,
                    classifiers: [colonia, cultura],
                    campaign: september_2018,
                    description: <<~EOD.squish
                      Ampliación del presupuesto destinado a libros, en función de
                      un estudio previo de necesidades bibliográficas para realizar
                      la selección de fondos con arreglo a la estimación de presupuesto.
                    EOD
                  )

aceras_penascales = Proposal.create(
                      title: "Renovar las aceras de Peñascales",
                      budget: 30_000.0,
                      classifiers: [penascales, urbanismo],
                      campaign: september_2018,
                      description: <<~EOD.squish
                        Con el objetivo de mejorar el tránsito para todos los peatones.
                      EOD
                    )

conexion_ruiz_gimenez = Proposal.create(
                          title: "Conexión entre el Paseo de Joaquín Ruiz Giménez con la Biblioteca José de Vicente Muñoz",
                          budget: 3_000.0,
                          classifiers: [pueblo, urbanismo, cultura],
                          campaign: september_2018,
                          description: <<~EOD.squish
                            Mejora de cerramiento.
                          EOD
                        )

entrada_huertos = Proposal.create(
                    title: "Entrada a la zona de los huertos urbanos",
                    budget: 500.0,
                    classifiers: [huertos, rozuelas],
                    campaign: september_2018,
                    description: <<~EOD.squish
                      Establecer una entrada para facilitar la entrada desde la zona
                      del pueblo.
                    EOD
                  )

rehabilitacion_auditorio = Proposal.create(
                  title: "Rehabilitación del Auditorio Vergara",
                  budget: 60_000.0,
                  classifiers: [colonia, urbanismo],
                  campaign: september_2018,
                  description: <<~EOD.squish
                    Rehabilitación del auditorio.
                  EOD
                )

estudio_leishmaniosis = Proposal.create(
                          title: "Estudio sobre la leishmaniosis",
                          budget: 5_150.0,
                          classifiers: [municipio, urbanismo],
                          campaign: september_2018,
                          description: <<~EOD.squish
                            Realización de un estudio sobre las poblaciones de insectos
                            transmisores de leishmaniosis, que permitirá planificar
                            medidas de control adecuadas para minimizar la posible
                            transmisión de la enfermedad.
                          EOD
                        )
