### Sample development data

## Admin roles

civio = Admin::Role.create(email: '@civio.es')

## Voters

raul    = Voter.create(email: 'raul@civio.es', verified: true)
david   = Voter.create(email: 'david@civio.es', verified: true)
eduardo = Voter.create(email: 'eduardo@civio.es', verified: true)

## Classifiers

# Districts
floridablanca = District.create(name: 'Floridablanca')
sanroque      = District.create(name: 'San Roque')
pradogrande   = District.create(name: 'Pradogrande')
polideportivo = District.create(name: 'Polideportivo')
atalaya       = District.create(name: 'Atalaya')
centro        = District.create(name: 'Centro')

# Areas
medioambiente = Area.create(name: 'Medio Ambiente')
deportes      = Area.create(name: 'Deportes')
patrimonio    = Area.create(name: 'Patrimonio')

# Tags
workout  = Tag.create(name: 'Workout')
juegos   = Tag.create(name: 'Juegos')
tirolina = Tag.create(name: 'Tirolina')
parkour  = Tag.create(name: 'Parkour')
turismo  = Tag.create(name: 'Turismo')
parques  = Tag.create(name: 'Parques')

## Campaigns

junio_2017  = Campaign.create(
                title: "Equipamiento infantil y juvenil",
                budget: 114_192.56,
                start_date: '2017-06-01',
                end_date: '2017-06-30',
                active: true,
                description: <<~EOD.squish
                  La idea para este primer año de presupuestos participativos
                  2017 de Torrelodones es elegir entre varias de las propuestas
                  más votadas tanto en el pleno infantil de noviembre 2016 como
                  el pleno juvenil de abril de 2017, ambos disponibles en la
                  web municipal, sección de infancia. También hemos añadido una
                  instalación de vóley playa en el polideportivo municipal.
                  Partimos de una partida de 100.000€ que serán ejecutados a lo
                  largo del último trimestre de 2017 con las propuestas más
                  votadas.
                EOD
              )

## Proposals

workout_1   = Proposal.create(
                title: 'Street Workout en el parque de Floridablanca',
                budget: 16_366.51,
                classifiers: [floridablanca, parques, workout, medioambiente],
                campaign: junio_2017,
                description: <<~EOD.squish
                  El Street Workout (entrenamiento de calle o callejero),
                  también conocido como Calistenia, es el movimiento basado en
                  el deporte callejero, es un movimiento que se basa en
                  entrenar en la calle, usando el propio cuerpo y el entorno.

                  Sus seguidores lo describen como mucho más que una modalidad
                  de entrenamiento, pues se considera un estilo de vida
                  caracterizado por valores como el respeto y la educación, así
                  como la solidaridad con el mundo y el resto de los habitantes
                  del mismo, sin ideologías políticas.

                  Se practica en parques con barras donde se trata de realizar
                  acciones básicas como fondos, como las muscle-ups y/o
                  estáticos como banderas, front-lever, etc. Este tipo de
                  deporte quiere acabar con el aburrimiento del gimnasio y el
                  entrenamiento de fuerza desde otra perspectiva más completa y
                  dinámica.

                  Crear espacios de actividad y no sólo de estancia para la
                  adolescencia es algo muy necesario en los parques públicos.
                  Los espacios públicos no tienen que estar segregados por
                  edades de las personas que los usan. De manera que incorporar
                  puntos de actividad para diferentes edades en los mismos
                  espacios públicos los acaba por transformar en lugares de
                  convivencia mucho más enriquecedores.

                  En el parque de Floridablanca existen ya zonas de juegos
                  infantiles, también maquinaria para la actividad física
                  adulta y un campo de petanca; además de una pista de futbol
                  3x3 y una canasta de baloncesto, se ha habilitado una zona para
                  patinar. Queda por tanto incluir un punto de encuentro y de
                  ocio activo para la población adolecente y de la primera
                  madurez.

                  Creemos que una instalación completa de workout sería un gran
                  avance en este sentido, y fomentaría la convivencia entre
                  generaciones dentro de un espacio público de calidad.
                EOD
              )
workout_2   = Proposal.create(
                title: 'Street Workout en el parque de San Roque',
                budget: 20_012.19,
                classifiers: [sanroque, parques, workout, medioambiente],
                campaign: junio_2017,
                description: <<~EOD.squish
                  El Street Workout (entrenamiento de calle o callejero),
                  también conocido como Calistenia, es el movimiento basado en
                  el deporte callejero, es un movimiento que se basa en
                  entrenar en la calle, usando el propio cuerpo y el entorno.

                  Sus seguidores lo describen como mucho más que una modalidad
                  de entrenamiento, pues se considera un estilo de vida
                  caracterizado por valores como el respeto y la educación, así
                  como la solidaridad con el mundo y el resto de los habitantes
                  del mismo, sin ideologías políticas.

                  Se practica en parques con barras donde se trata de realizar
                  acciones básicas como fondos, como las muscle-ups y/o
                  estáticos como banderas, front-lever, etc. Este tipo de
                  deporte quiere acabar con el aburrimiento del gimnasio y el
                  entrenamiento de fuerza desde otra perspectiva más completa y
                  dinámica.

                  Crear espacios de actividad y no sólo de estancia para la
                  adolescencia es algo muy necesario en los parques públicos.
                  Los espacios públicos no tienen que estar segregados por
                  edades de las personas que los usan. De manera que incorporar
                  puntos de actividad para diferentes edades en los mismos
                  espacios públicos los acaba por transformar en lugares de
                  convivencia mucho más enriquecedores.

                  En el parque de San Roque existen ya zonas de juegos
                  infantiles, también maquinaria para la actividad física
                  adulta y además una pista de futbol 3x3 y una canasta de
                  baloncesto y por su idiosincracia es una zona de juegos entre
                  roquedos y arbolado. Queda por tanto incluir un punto de
                  encuentro y de ocio activo para la población adolecente y de
                  la primera madurez.

                  Creemos que una instalación completa de workout sería un gran
                  avance en este sentido, y fomentaría la convivencia entre
                  generaciones dentro de un espacio público de calidad.
                EOD
              )
workout_3   = Proposal.create(
                title: 'Street Workout en el parque de Pradogrande',
                budget: 14_489.75,
                classifiers: [pradogrande, parques, workout, medioambiente],
                campaign: junio_2017,
                description: <<~EOD.squish
                  El Street Workout (entrenamiento de calle o callejero),
                  también conocido como Calistenia, es el movimiento basado en
                  el deporte callejero, es un movimiento que se basa en
                  entrenar en la calle, usando el propio cuerpo y el entorno.

                  Sus seguidores lo describen como mucho más que una modalidad
                  de entrenamiento, pues se considera un estilo de vida
                  caracterizado por valores como el respeto y la educación, así
                  como la solidaridad con el mundo y el resto de los habitantes
                  del mismo, sin ideologías políticas.

                  Se practica en parques con barras donde se trata de realizar
                  acciones básicas como fondos, como las muscle-ups y/o
                  estáticos como banderas, front-lever, etc. Este tipo de
                  deporte quiere acabar con el aburrimiento del gimnasio y el
                  entrenamiento de fuerza desde otra perspectiva más completa y
                  dinámica.

                  Crear espacios de actividad y no sólo de estancia para la
                  adolescencia es algo muy necesario en los parques públicos.
                  Los espacios públicos no tienen que estar segregados por
                  edades de las personas que los usan. De manera que incorporar
                  puntos de actividad para diferentes edades en los mismos
                  espacios públicos los acaba por transformar en lugares de
                  convivencia mucho más enriquecedores.

                  En el parque de Pradogrande existen ya zonas de juegos
                  infantiles, también una pista de futbol sala y una de
                  baloncesto; existe además una zona de skatepark y un circuito
                  de BMX. Queda por tanto incluir un punto de encuentro y de ocio
                  activo para la población adolecente y de la primera madurez.

                  Creemos que una instalación completa de workout sería un gran
                  avance en este sentido, y fomentaría la convivencia entre
                  generaciones dentro de un espacio público de calidad.
                EOD
              )
juegos      = Proposal.create(
                title: 'Juegos tradicionales en la Plaza de la Constitución',
                budget: 4_065.60,
                classifiers: [centro, juegos, medioambiente],
                campaign: june_2017,
                description: <<~EOD.squish
                 Pavimento de seguridad continuo en caucho a instalar en la
                 parte trasera del edificio de alcaldía, ampliando así la zona
                 de juego infantil existente, con propuestas de juegos
                 tradicionales con colores llamativos.

                 Se pretende ampliar la edad de uso de la zona infantil, con
                 juegos tradicionales intergeneracionales.
                EOD
              )
tirolina     = Proposal.create(
                title: 'Tirolina en el parque Pradogrande',
                budget: 8_145.72,
                classifiers: [pradogrande, parques, juegos, medioambiente],
                campaign: junio_2017,
                description: <<~EOD.squish
                  El origen de la tirolina como ingenio humano nos lleva a la
                  necesidad de las personas de salvar obstáculos y simas. La
                  incorporación de una tirolina adaptada a la infancia en un
                  parque público es una invitación para jugar soñando con eso,
                  con salvar el vacío, atravesar ríos, descubrir la aventura.

                  Torrelodones se encuentra enclavado entre dos parques
                  naturales, en ambos se practican deportes de naturaleza. A
                  muy poca distancia del parque de Pradogrande hay espacios
                  para el deporte llamado de aventura: la escalada en
                  prácticamente todas sus modalidades.

                  Incorporar una tirolina, de longitud muy considerable desde
                  las dimensiones infantiles, es una apuesta por incorporar esa
                  sensación de aventura dentro del juego espontáneo y potenciar
                  la actividad física de los niños y niñas.

                  Será, además, una fábrica de recuerdos de infancia compartida,
                  pues para su disfrute es muy conveniente la cooperación entre
                  iguales.
                EOD
              )
parkour     = Proposal.create(
                title: 'Espacio Parkour en el parque Pradogrande',
                budget: 33_070.93,
                classifiers: [pradogrande, parques, parkour, medioambiente],
                campaign: junio_2017,
                description: <<~EOD.squish
                  En grandes ciudades y poblaciones influenciadas por ellas,
                  adaptándose a una moda nacida en Francia a finales de los 90,
                  están empezando a instalarse zonas especialmente diseñadas
                  para el entrenamiento y la práctica del parkour.

                  En Torrelodones, por la inquietud de un inicialmente pequeño
                  grupo de jóvenes, desde hace un lustro se ha establecido una
                  afición que une ya a un buen número de jóvenes entorno al
                  parkour, entendida esta actividad como parte de una cultura
                  urbana en expansión.

                  Lo que aporta un parkourodromo de diferente sobre los lugares
                  en los que se suele practicar esta actividad es que se
                  construye con elementos y módulos normalizados y certificables
                  como seguros. Tanto los módulos como la superficie aseguran
                  la seguridad si la actividad se realiza propiamente.

                  La demanda de una zona normalizada está más que justificada
                  en una población como la nuestra en la que cada año se
                  incorporan del orden de 30 jóvenes, chicos y chicas, al
                  ámbito de la cultura del parkour.
                EOD
              )
voley       = Proposal.create(
                title: 'Campo de volley playa en el polideportivo municipal',
                budget: 21_780.00,
                classifiers: [polideportivo, deportes],
                campaign: junio_2017,
                description: <<~EOD.squish
                  El vóley playa es un deporte que desde hace tiempo tiene
                  impacto en nuestro municipio. Las componentes de los
                  diferentes equipos de vóley femenino y algunos jugadores que
                  compiten en otros municipios se suman a la petición de una
                  instalación fija cada verano.

                  Queremos instalar una instalación completa de vóley que pueda
                  estar sujeta al control del servicio municipal, para que se
                  pueda mantener en correcto uso y sea utilizada para la
                  actividad deportiva para la que se construirá, tanto para el
                  juego de ocio abierto a la población como para tener la
                  oportunidad de organizar algún campeonato puntualmente.

                  El Voley playa es un complemento perfecto del Voleybol y
                  también lo es de otras disciplinas deportivas, que lo
                  utilizan como juego para la puesta a punto o para calentar.

                  Esta instalación completaría la zona de raqueta y redes del
                  polideportivo municipal.
                EOD
              )
escalera    = Proposal.create(
                title: 'Instalación de escalera en la Atalaya de Torrelodones',
                budget: 12_000.00,
                classifiers: [atalaya, turismo, patrimonio],
                campaign: junio_2017,
                description: <<~EOD.squish
                  Con el objetivo de ir mejorando el acceso a la Torre,
                  proponemos la instalación de una escalera de caracol interior.

                  Más adelante, y en coordinación con la Dirección General de
                  Patrimonio, plantearemos acciones de mejora de la seguridad
                  de la parte superior de la Atalaya con el objetivo de fomentar
                  las visitas, tal y como solicitaron los alumn@s durante el
                  pasado pleno infantil de noviembre 2016.
                EOD
              )

## Voter secrets (fake data)

local_1      = VoterSecret.create(data: { document: '53713184D', birth_date: '1974-11-29' })
local_2      = VoterSecret.create(data: { document: '279793B', birth_date: '1986-10-19' })
residente_1  = VoterSecret.create(data: { document: 'X07323369A', birth_date: '1945-11-06' })
residente_2  = VoterSecret.create(data: { document: 'Y01927564M', birth_date: '1945-11-06' })
extranjero_1 = VoterSecret.create(data: { document: '423994F', birth_date: '1990-05-12'})
extranjero_2 = VoterSecret.create(data: { document: '8VU216016', birth_date: '1998-11-02' })
