// Archivo: test_content.dart
import 'dart:math';

class TestContent {
  static final Random _random = Random();

  static Map<String, List<Map<String, dynamic>>> questions = {
    'Clase 1': [
      {
        'type': 'simple',
        'question':
            '¿Cuál es la definición correcta de un producto farmacéutico según la normativa chilena?',
        'options': [
          'a) Cualquier sustancia que se vende en una farmacia',
          'b) Una sustancia natural o sintética destinada al ser humano con fines de curación, atenuación, tratamiento, prevención o diagnóstico',
          'c) Solo las sustancias sintéticas creadas en laboratorio para tratar enfermedades',
          'd) Exclusivamente las medicinas tradicionales y herbarias'
        ],
        'correctAnswer':
            'b) Una sustancia natural o sintética destinada al ser humano con fines de curación, atenuación, tratamiento, prevención o diagnóstico',
        'explanation':
            'Según lo explicado en la clase, un producto farmacéutico se define como una sustancia natural, sintética o mezcla de ambas que se destina al ser humano con fines de curación, atenuación, tratamiento, prevención o diagnóstico de enfermedades. Esta definición incluye tanto productos de origen natural como sintético, y abarca diversos propósitos terapéuticos.'
      },
      {
        'type': 'simple',
        'question':
            '¿Qué significa el sistema FEFO en el almacenamiento de medicamentos?',
        'options': [
          'a) First Expired, First Out - Primero en vencer, primero en salir',
          'b) First Entered, First Out - Primero en entrar, primero en salir',
          'c) First Expired, Final Out - Primero en vencer, último en salir',
          'd) First Entrance, Final Order - Primera entrada, orden final'
        ],
        'correctAnswer':
            'a) First Expired, First Out - Primero en vencer, primero en salir',
        'explanation':
            'FEFO (First Expired, First Out) es el sistema que prioriza la salida de los productos según su fecha de vencimiento. El producto que vence primero debe ser el primero en salir, independientemente de cuándo haya llegado a la farmacia. Este sistema es crucial para garantizar la rotación adecuada del stock y evitar el vencimiento de medicamentos.'
      },
      {
        'type': 'simple',
        'question': '¿Qué se define como biodisponibilidad de un medicamento?',
        'options': [
          'a) La cantidad total de medicamento en un envase',
          'b) La cantidad de principio activo que llega a la circulación sistémica y la velocidad con que esto ocurre',
          'c) El tiempo que tarda en vencerse un medicamento',
          'd) La capacidad del medicamento para disolverse en agua'
        ],
        'correctAnswer':
            'b) La cantidad de principio activo que llega a la circulación sistémica y la velocidad con que esto ocurre',
        'explanation':
            'La biodisponibilidad es un concepto farmacológico clave que se refiere específicamente a la cantidad de principio activo que logra alcanzar la circulación sistémica y la velocidad con que esto sucede. Este concepto es fundamental para determinar la efectividad real de un medicamento en el organismo.'
      },
      {
        'type': 'simple',
        'question':
            '¿Cuál es la temperatura ambiente correcta para el almacenamiento de medicamentos según la normativa?',
        'options': [
          'a) Entre 20°C y 30°C',
          'b) Entre 15°C y 25°C',
          'c) Entre 10°C y 20°C',
          'd) Entre 2°C y 8°C'
        ],
        'correctAnswer': 'b) Entre 15°C y 25°C',
        'explanation':
            'La temperatura ambiente para medicamentos está definida entre 15°C y 25°C según la normativa. Es crucial mantener este rango de temperatura para garantizar la estabilidad y eficacia de los medicamentos que no requieren refrigeración.'
      },
      {
        'type': 'simple',
        'question':
            '¿Qué documentación es obligatoria mantener disponible en una farmacia?',
        'options': [
          'a) Solo el reglamento de farmacia',
          'b) Únicamente el petitorio mínimo',
          'c) Reglamentos, petitorio mínimo, formulario nacional y monografías de productos de venta directa',
          'd) Solamente las recetas médicas'
        ],
        'correctAnswer':
            'c) Reglamentos, petitorio mínimo, formulario nacional y monografías de productos de venta directa',
        'explanation':
            'Las farmacias deben mantener disponible la siguiente documentación obligatoria: los reglamentos (de farmacia, droguerías, almacenes farmacéuticos y depósitos), el petitorio mínimo, el formulario nacional de medicamentos y las monografías de productos de venta directa.'
      },
      {
        'type': 'simple',
        'question':
            '¿Cuál es la función principal del químico farmacéutico en una farmacia?',
        'options': [
          'a) Únicamente vender medicamentos',
          'b) Solo supervisar al personal',
          'c) Dirigir técnicamente la farmacia y verificar el correcto despacho de recetas',
          'd) Exclusivamente manejar la caja registradora'
        ],
        'correctAnswer':
            'c) Dirigir técnicamente la farmacia y verificar el correcto despacho de recetas',
        'explanation':
            'El químico farmacéutico es el director técnico de la farmacia, responsable de verificar que el despacho de recetas se efectúe conforme a las disposiciones legales, supervisar el almacenamiento y promover el uso racional de medicamentos.'
      },
      {
        'type': 'simple',
        'question':
            '¿Qué requisitos debe cumplir una persona para ser auxiliar de farmacia?',
        'options': [
          'a) Solo tener experiencia en ventas',
          'b) Enseñanza media completa, experiencia en bodegaje y aprobar examen de competencia',
          'c) Únicamente tener enseñanza básica completa',
          'd) Solo tener autorización del dueño de la farmacia'
        ],
        'correctAnswer':
            'b) Enseñanza media completa, experiencia en bodegaje y aprobar examen de competencia',
        'explanation':
            'Para ser auxiliar de farmacia se requiere: haber completado la enseñanza media, tener experiencia en almacenaje y bodegaje de productos farmacéuticos, y aprobar un examen de competencia ante la autoridad sanitaria.'
      },
      {
        'type': 'simple',
        'question': '¿Qué son los productos farmacéuticos de asociación?',
        'options': [
          'a) Productos que se venden juntos por promoción',
          'b) Productos que contienen dos o más principios activos en una misma forma farmacéutica',
          'c) Productos que solo se venden en farmacias asociadas',
          'd) Productos que requieren receta médica'
        ],
        'correctAnswer':
            'b) Productos que contienen dos o más principios activos en una misma forma farmacéutica',
        'explanation':
            'Los productos farmacéuticos de asociación son aquellos que contienen dos o más principios activos incorporados en una misma forma farmacéutica, como por ejemplo un inhalador que contiene salbutamol y beclometasona.'
      },
      {
        'type': 'simple',
        'question': '¿Qué se entiende por equivalentes farmacéuticos?',
        'options': [
          'a) Medicamentos con el mismo precio',
          'b) Medicamentos con idénticas cantidades de principios activos y forma farmacéutica, pero pueden tener diferentes excipientes',
          'c) Medicamentos de diferentes laboratorios',
          'd) Medicamentos con el mismo color y forma'
        ],
        'correctAnswer':
            'b) Medicamentos con idénticas cantidades de principios activos y forma farmacéutica, pero pueden tener diferentes excipientes',
        'explanation':
            'Los equivalentes farmacéuticos son productos que contienen idénticas cantidades de los mismos principios activos, en la misma forma farmacéutica y vía de administración, aunque pueden variar en sus excipientes.'
      },
      {
        'type': 'simple',
        'question':
            '¿Qué tipos de libros de registro son obligatorios en una farmacia?',
        'options': [
          'a) Solo el libro de ventas',
          'b) Libro de inspección, fraccionamiento, control de psicotrópicos, reclamos y recetas magistrales',
          'c) Únicamente el libro de reclamos',
          'd) Solo el libro de asistencia del personal'
        ],
        'correctAnswer':
            'b) Libro de inspección, fraccionamiento, control de psicotrópicos, reclamos y recetas magistrales',
        'explanation':
            'Las farmacias deben mantener los siguientes libros de registro: libro de inspección, de fraccionamiento de envases, de control de psicotrópicos y estupefacientes, de reclamos y de recetas magistrales.'
      },
      {
        'type': 'simple',
        'question':
            '¿Qué condición deben cumplir los productos de venta directa en su exhibición?',
        'options': [
          'a) Pueden estar en cualquier lugar de la farmacia',
          'b) Deben estar en repisas a una altura superior a 1 metro del suelo',
          'c) Deben estar bajo llave',
          'd) Solo pueden exhibirse en la vitrina'
        ],
        'correctAnswer':
            'b) Deben estar en repisas a una altura superior a 1 metro del suelo',
        'explanation':
            'Los productos de venta directa deben exhibirse en repisas o góndolas a una altura superior a 1 metro del suelo para evitar que los niños puedan manipularlos, según las normativas de seguridad.'
      },
      {
        'type': 'simple',
        'question': '¿Qué se entiende por forma farmacéutica?',
        'options': [
          'a) El color del medicamento',
          'b) La forma física en que se presenta un medicamento para facilitar su administración',
          'c) El tamaño del envase',
          'd) El precio del medicamento'
        ],
        'correctAnswer':
            'b) La forma física en que se presenta un medicamento para facilitar su administración',
        'explanation':
            'La forma farmacéutica es la presentación física que se le da a un medicamento para facilitar su fraccionamiento, dispensación, dosificación y administración. Incluye presentaciones como comprimidos, cápsulas, jarabes, gotas, etc.'
      },
      {
        'type': 'simple',
        'question': '¿Qué es un preparado magistral?',
        'options': [
          'a) Un medicamento que solo venden los mejores químicos farmacéuticos',
          'b) Una fórmula elaborada para una persona específica según prescripción médica',
          'c) Un medicamento muy costoso',
          'd) Un medicamento de venta libre'
        ],
        'correctAnswer':
            'b) Una fórmula elaborada para una persona específica según prescripción médica',
        'explanation':
            'Un preparado magistral es aquel que se elabora de manera inmediata conforme a una prescripción médica específica para un paciente determinado, siguiendo las indicaciones precisas del médico tratante.'
      },
      {
        'type': 'simple',
        'question': '¿Qué son los productos farmacéuticos de combinación?',
        'options': [
          'a) Productos que se venden en combo',
          'b) Productos que contienen dos o más medicamentos en el mismo envase pero separados',
          'c) Productos que se pueden mezclar',
          'd) Productos que tienen el mismo color'
        ],
        'correctAnswer':
            'b) Productos que contienen dos o más medicamentos en el mismo envase pero separados',
        'explanation':
            'Los productos farmacéuticos de combinación son aquellos que incluyen dos o más productos farmacéuticos en el mismo envase pero separados físicamente, como por ejemplo un antibiótico con su diluyente.'
      },
      {
        'type': 'simple',
        'question': '¿Qué es un botiquín según la normativa chilena?',
        'options': [
          'a) Cualquier caja con medicamentos',
          'b) Un recinto para almacenar productos farmacéuticos de uso interno en establecimientos de salud',
          'c) Un mueble para guardar medicamentos en casa',
          'd) Una farmacia pequeña'
        ],
        'correctAnswer':
            'b) Un recinto para almacenar productos farmacéuticos de uso interno en establecimientos de salud',
        'explanation':
            'Un botiquín es un recinto autorizado para almacenar productos farmacéuticos destinados al uso interno de clínicas, maternidades, hospitales y otros establecimientos de salud, bajo la supervisión de un profesional autorizado.'
      },
      {
        'type': 'simple',
        'question':
            '¿Qué condición especial de almacenamiento requieren los productos psicotrópicos y estupefacientes?',
        'options': [
          'a) Pueden estar en cualquier estante',
          'b) Deben estar en una estantería exclusiva bajo llave cerca de la oficina del químico farmacéutico',
          'c) Pueden estar en la bodega general',
          'd) Solo necesitan estar refrigerados'
        ],
        'correctAnswer':
            'b) Deben estar en una estantería exclusiva bajo llave cerca de la oficina del químico farmacéutico',
        'explanation':
            'Los productos psicotrópicos y estupefacientes deben almacenarse en una estantería exclusiva, bajo llave y generalmente cerca de la oficina del químico farmacéutico, por ser medicamentos controlados que requieren especial custodia.'
      },
      {
        'type': 'simple',
        'question': '¿Qué significa que un medicamento sea de "venta directa"?',
        'options': [
          'a) Que es gratuito',
          'b) Que puede venderse sin receta médica',
          'c) Que solo se vende en farmacias grandes',
          'd) Que requiere receta retenida'
        ],
        'correctAnswer': 'b) Que puede venderse sin receta médica',
        'explanation':
            'Los medicamentos de venta directa son aquellos que pueden ser vendidos sin necesidad de presentar una receta médica, aunque deben cumplir con normativas específicas de exhibición y almacenamiento.'
      },
      {
        'type': 'simple',
        'question': '¿Qué función cumple la ANAMET en Chile?',
        'options': [
          'a) Vende medicamentos',
          'b) Es la Agencia Nacional de Medicamentos que controla productos farmacéuticos y cosméticos',
          'c) Solo registra farmacias',
          'd) Únicamente supervisa precios'
        ],
        'correctAnswer':
            'b) Es la Agencia Nacional de Medicamentos que controla productos farmacéuticos y cosméticos',
        'explanation':
            'La ANAMET (Agencia Nacional de Medicamentos) es un departamento del Instituto de Salud Pública encargado del control de los productos farmacéuticos y cosméticos que se fabrican o importan en Chile.'
      },
      {
        'type': 'simple',
        'question':
            '¿Qué se entiende por "principio activo" en un medicamento?',
        'options': [
          'a) El sabor del medicamento',
          'b) La sustancia que tiene el efecto farmacológico específico',
          'c) El color del medicamento',
          'd) El excipiente principal'
        ],
        'correctAnswer':
            'b) La sustancia que tiene el efecto farmacológico específico',
        'explanation':
            'El principio activo es la sustancia o mezcla de sustancias que tienen el efecto farmacológico específico en el medicamento. Es el componente que produce el efecto terapéutico deseado.'
      },
      {
        'type': 'simple',
        'question':
            '¿Cuál es la diferencia entre un almacén farmacéutico y una farmacia?',
        'options': [
          'a) No hay diferencia',
          'b) Solo el tamaño del local',
          'c) El almacén farmacéutico tiene limitaciones en los productos que puede vender y no puede preparar recetas magistrales',
          'd) Solo el horario de atención'
        ],
        'correctAnswer':
            'c) El almacén farmacéutico tiene limitaciones en los productos que puede vender y no puede preparar recetas magistrales',
        'explanation':
            'A diferencia de las farmacias, los almacenes farmacéuticos tienen restricciones en cuanto a los productos que pueden vender, no pueden preparar recetas magistrales ni oficinales, y están bajo la dirección técnica de un práctico en farmacia en lugar de un químico farmacéutico.'
      },
      // ****************************************************************************************

      // ****************************************************************************************

      // ****************************************************************************************

      {
        'type': 'complex',
        'question':
            'Analice las siguientes afirmaciones sobre los requisitos de documentación en una farmacia:',
        'solutions': [
          'I) Debe mantener disponible el reglamento de farmacias y droguerías',
          'II) Debe tener el formulario nacional de medicamentos',
          'III) Es obligatorio tener el listado de productos bioequivalentes',
          'IV) Las monografías de productos de venta directa deben estar disponibles'
        ],
        'options': [
          'a) Solo I y II son correctas',
          'b) Solo III y IV son correctas',
          'c) I, II y III son correctas',
          'd) Todas son correctas'
        ],
        'correctAnswer': 'd) Todas son correctas',
        'explanation':
            'Todas las afirmaciones son correctas según la normativa chilena. Las farmacias deben mantener disponible toda esta documentación para consulta: el reglamento de farmacias y droguerías, el formulario nacional de medicamentos, el listado de productos bioequivalentes y las monografías de productos de venta directa.'
      },
      {
        'type': 'complex',
        'question':
            'Sobre las condiciones de almacenamiento de medicamentos, analice:',
        'solutions': [
          'I) La humedad relativa no debe superar el 60%',
          'II) Los productos sensibles a la luz deben protegerse en envases ámbar',
          'III) La temperatura ambiente debe mantenerse entre 15°C y 25°C',
          'IV) Los medicamentos pueden almacenarse temporalmente en el piso si están en sus cajas originales'
        ],
        'options': [
          'a) Solo I y II son correctas',
          'b) Solo II y III son correctas',
          'c) I, II y III son correctas',
          'd) Todas son correctas'
        ],
        'correctAnswer': 'c) I, II y III son correctas',
        'explanation':
            'Las afirmaciones I, II y III son correctas según las buenas prácticas de almacenamiento. La humedad debe mantenerse bajo 60%, los productos fotosensibles deben protegerse en envases ámbar y la temperatura ambiente debe estar entre 15°C y 25°C. La afirmación IV es incorrecta porque los medicamentos nunca deben almacenarse directamente en el piso, ni siquiera temporalmente.'
      },
      {
        'type': 'complex',
        'question':
            'Respecto a las funciones del químico farmacéutico, analice:',
        'solutions': [
          'I) Debe supervisar el fraccionamiento de envases clínicos',
          'II) Es responsable de la custodia de productos controlados',
          'III) Debe capacitar al personal auxiliar',
          'IV) Puede delegar la dispensación de psicotrópicos a auxiliares capacitados'
        ],
        'options': [
          'a) Solo I y II son correctas',
          'b) Solo II y III son correctas',
          'c) I, II y III son correctas',
          'd) Todas son correctas'
        ],
        'correctAnswer': 'c) I, II y III son correctas',
        'explanation':
            'Las afirmaciones I, II y III son correctas según la normativa. El químico farmacéutico debe supervisar el fraccionamiento, es responsable de los productos controlados y debe capacitar al personal. La afirmación IV es incorrecta porque la dispensación de psicotrópicos debe ser realizada directamente por el químico farmacéutico y no puede delegarse.'
      },
      {
        'type': 'complex',
        'question':
            'Sobre los productos de venta directa, analice las siguientes afirmaciones:',
        'solutions': [
          'I) Deben exhibirse en góndolas a más de 1 metro de altura',
          'II) Pueden ser antitusivos y antigripales',
          'III) Deben estar agrupados por tipo terapéutico',
          'IV) Pueden ser todos los analgésicos sin excepción'
        ],
        'options': [
          'a) Solo I y II son correctas',
          'b) Solo II y III son correctas',
          'c) I, II y III son correctas',
          'd) Todas son correctas'
        ],
        'correctAnswer': 'c) I, II y III son correctas',
        'explanation':
            'Las afirmaciones I, II y III son correctas. Los productos de venta directa deben exhibirse a más de 1 metro de altura, incluyen algunos antitusivos y antigripales, y deben agruparse por tipo terapéutico. La afirmación IV es incorrecta porque no todos los analgésicos son de venta directa; algunos requieren receta médica.'
      },
      {
        'type': 'complex',
        'question':
            'Analice las siguientes afirmaciones sobre los libros de registro en una farmacia:',
        'solutions': [
          'I) El libro de reclamos debe estar disponible para el público',
          'II) El libro de control de psicotrópicos es manejado por el químico farmacéutico',
          'III) El libro de inspección registra las visitas de la autoridad sanitaria',
          'IV) Los libros no requieren autorización de la autoridad sanitaria'
        ],
        'options': [
          'a) Solo I y II son correctas',
          'b) Solo II y III son correctas',
          'c) I, II y III son correctas',
          'd) Todas son correctas'
        ],
        'correctAnswer': 'c) I, II y III son correctas',
        'explanation':
            'Las afirmaciones I, II y III son correctas según la normativa. El libro de reclamos debe estar accesible al público, el control de psicotrópicos es responsabilidad del químico farmacéutico y el libro de inspección registra las visitas de la autoridad sanitaria. La afirmación IV es incorrecta porque todos los libros requieren autorización de la autoridad sanitaria.'
      },
      {
        'type': 'complex',
        'question': 'Sobre los almacenes farmacéuticos, analice:',
        'solutions': [
          'I) Pueden vender productos de venta directa',
          'II) Están bajo la dirección de un práctico en farmacia',
          'III) No pueden preparar fórmulas magistrales',
          'IV) Pueden vender todos los medicamentos que vende una farmacia'
        ],
        'options': [
          'a) Solo I y II son correctas',
          'b) Solo II y III son correctas',
          'c) I, II y III son correctas',
          'd) Todas son correctas'
        ],
        'correctAnswer': 'c) I, II y III son correctas',
        'explanation':
            'Las afirmaciones I, II y III son correctas. Los almacenes farmacéuticos pueden vender productos de venta directa, están dirigidos por un práctico en farmacia y no pueden preparar fórmulas magistrales. La afirmación IV es incorrecta porque los almacenes farmacéuticos tienen limitaciones en cuanto a los productos que pueden vender.'
      },
      {
        'type': 'complex',
        'question': 'Sobre la dispensación de medicamentos, analice:',
        'solutions': [
          'I) El químico farmacéutico puede delegar la dispensación de medicamentos no controlados',
          'II) Se debe informar sobre posibles efectos adversos',
          'III) Se debe verificar la fecha de vencimiento antes de dispensar',
          'IV) No es necesario verificar la condición de venta si el cliente lo solicita'
        ],
        'options': [
          'a) Solo I y II son correctas',
          'b) Solo II y III son correctas',
          'c) I, II y III son correctas',
          'd) Todas son correctas'
        ],
        'correctAnswer': 'c) I, II y III son correctas',
        'explanation':
            'Las afirmaciones I, II y III son correctas. El químico puede delegar la dispensación de medicamentos no controlados a auxiliares capacitados, se debe informar sobre efectos adversos y verificar el vencimiento. La afirmación IV es incorrecta porque siempre se debe verificar la condición de venta, independientemente de la solicitud del cliente.'
      },
      {
        'type': 'complex',
        'question': 'Analice las siguientes afirmaciones sobre los botiquines:',
        'solutions': [
          'I) Pueden almacenar productos psicotrópicos',
          'II) Pueden adquirir medicamentos en envases clínicos',
          'III) No pueden preparar fórmulas magistrales',
          'IV) Pueden estar bajo responsabilidad de una matrona'
        ],
        'options': [
          'a) Solo I y II son correctas',
          'b) Solo II y III son correctas',
          'c) I, II y IV son correctas',
          'd) Todas son correctas'
        ],
        'correctAnswer': 'd) Todas son correctas',
        'explanation':
            'Todas las afirmaciones son correctas. Los botiquines pueden almacenar psicotrópicos siguiendo la reglamentación correspondiente, pueden adquirir medicamentos en envases clínicos, no están autorizados para preparar fórmulas magistrales, y pueden estar bajo la responsabilidad de profesionales de la salud autorizados, incluyendo matronas.'
      },
      {
        'type': 'complex',
        'question': 'Sobre los productos refrigerados, analice:',
        'solutions': [
          'I) Deben mantenerse entre 2°C y 8°C',
          'II) Requieren un registro diario de temperatura',
          'III) El refrigerador debe ser de uso exclusivo para medicamentos',
          'IV) La puerta puede permanecer abierta mientras se buscan medicamentos'
        ],
        'options': [
          'a) Solo I y II son correctas',
          'b) Solo II y III son correctas',
          'c) I, II y III son correctas',
          'd) Todas son correctas'
        ],
        'correctAnswer': 'c) I, II y III son correctas',
        'explanation':
            'Las afirmaciones I, II y III son correctas. Los productos refrigerados deben mantenerse entre 2°C y 8°C, requieren control diario de temperatura y el refrigerador debe ser de uso exclusivo para medicamentos. La afirmación IV es incorrecta porque la puerta debe permanecer cerrada para mantener la temperatura constante.'
      },
      {
        'type': 'complex',
        'question': 'Sobre la equivalencia de medicamentos, analice:',
        'solutions': [
          'I) Los equivalentes farmacéuticos tienen la misma cantidad de principio activo',
          'II) Pueden tener diferentes excipientes',
          'III) Deben tener la misma forma farmacéutica',
          'IV) Siempre tienen el mismo precio'
        ],
        'options': [
          'a) Solo I y II son correctas',
          'b) Solo II y III son correctas',
          'c) I, II y III son correctas',
          'd) Todas son correctas'
        ],
        'correctAnswer': 'c) I, II y III son correctas',
        'explanation':
            'Las afirmaciones I, II y III son correctas. Los equivalentes farmacéuticos contienen la misma cantidad de principio activo, pueden variar en sus excipientes y deben tener la misma forma farmacéutica. La afirmación IV es incorrecta porque el precio no es un factor en la equivalencia farmacéutica.'
      },
      {
        'type': 'complex',
        'question': 'Sobre las funciones del auxiliar de farmacia, analice:',
        'solutions': [
          'I) Debe apoyar en la indicación del uso correcto de medicamentos',
          'II) Debe mantener el orden y limpieza de los productos',
          'III) Puede dispensar medicamentos bajo supervisión del químico farmacéutico',
          'IV) Puede modificar las indicaciones médicas si lo considera necesario'
        ],
        'options': [
          'a) Solo I y II son correctas',
          'b) Solo II y III son correctas',
          'c) I, II y III son correctas',
          'd) Todas son correctas'
        ],
        'correctAnswer': 'c) I, II y III son correctas',
        'explanation':
            'Las afirmaciones I, II y III son correctas. Los auxiliares deben apoyar en la indicación del uso correcto de medicamentos, mantener el orden y limpieza, y pueden dispensar bajo supervisión. La afirmación IV es incorrecta porque nunca pueden modificar las indicaciones médicas.'
      },
      {
        'type': 'complex',
        'question':
            'Sobre el almacenamiento de productos farmacéuticos, analice:',
        'solutions': [
          'I) Debe seguirse el sistema FEFO para la rotación',
          'II) Los productos pesados deben ubicarse en niveles inferiores',
          'III) Debe mantenerse registro de temperatura',
          'IV) Los productos pueden apilarse sin límite si están en sus cajas'
        ],
        'options': [
          'a) Solo I y II son correctas',
          'b) Solo II y III son correctas',
          'c) I, II y III son correctas',
          'd) Todas son correctas'
        ],
        'correctAnswer': 'c) I, II y III son correctas',
        'explanation':
            'Las afirmaciones I, II y III son correctas. Se debe seguir el sistema FEFO, los productos pesados deben estar abajo y debe haber registro de temperatura. La afirmación IV es incorrecta porque el apilamiento debe respetar límites de seguridad y especificaciones del fabricante.'
      },
      {
        'type': 'complex',
        'question':
            'Analice las siguientes afirmaciones sobre los productos de venta directa:',
        'solutions': [
          'I) Incluyen algunos antitusivos y antigripales',
          'II) Deben tener monografías disponibles',
          'III) Pueden exhibirse en góndolas accesibles',
          'IV) Todos los analgésicos son de venta directa'
        ],
        'options': [
          'a) Solo I y II son correctas',
          'b) Solo II y III son correctas',
          'c) I, II y III son correctas',
          'd) Todas son correctas'
        ],
        'correctAnswer': 'c) I, II y III son correctas',
        'explanation':
            'Las afirmaciones I, II y III son correctas. Los productos de venta directa incluyen ciertos antitusivos y antigripales, deben tener monografías disponibles y pueden exhibirse en góndolas. La afirmación IV es incorrecta porque no todos los analgésicos son de venta directa.'
      },
      {
        'type': 'complex',
        'question': 'Sobre la autoridad sanitaria, analice:',
        'solutions': [
          'I) El ISP es la autoridad sanitaria nacional',
          'II) La SEREMI de Salud tiene facultades fiscalizadoras',
          'III) Pueden realizar visitas programadas o por denuncias',
          'IV) Solo pueden fiscalizar en horario de oficina'
        ],
        'options': [
          'a) Solo I y II son correctas',
          'b) Solo II y III son correctas',
          'c) I, II y III son correctas',
          'd) Todas son correctas'
        ],
        'correctAnswer': 'c) I, II y III son correctas',
        'explanation':
            'Las afirmaciones I, II y III son correctas. El ISP es la autoridad sanitaria nacional, la SEREMI tiene facultades fiscalizadoras y pueden realizar visitas programadas o por denuncias. La afirmación IV es incorrecta porque pueden fiscalizar en cualquier horario.'
      },
      {
        'type': 'complex',
        'question':
            'Respecto a las condiciones de almacenamiento de productos farmacéuticos, analice las siguientes afirmaciones:',
        'solutions': [
          'I) Los productos refrigerados deben mantenerse entre 2°C y 8°C',
          'II) Los productos nunca pueden ser colocados directamente en el piso',
          'III) La temperatura ambiente para medicamentos es entre 15°C y 25°C',
          'IV) El personal no autorizado puede acceder a las áreas de almacenamiento si está supervisado'
        ],
        'options': [
          'a) Solo I y II son correctas',
          'b) Solo II y III son correctas',
          'c) I, II y III son correctas',
          'd) Todas son correctas'
        ],
        'correctAnswer': 'c) I, II y III son correctas',
        'explanation':
            'La afirmación I es correcta ya que los productos refrigerados deben mantenerse entre 2°C y 8°C según la normativa. La afirmación II es correcta porque los productos farmacéuticos nunca deben colocarse directamente en el piso, incluso si están en cajas. La afirmación III es correcta ya que la temperatura ambiente para medicamentos está definida entre 15°C y 25°C. La afirmación IV es incorrecta porque el personal no autorizado no debe tener acceso a las áreas de almacenamiento bajo ninguna circunstancia, incluso con supervisión.'
      },
      {
        'type': 'complex',
        'question':
            'Sobre los establecimientos farmacéuticos en Chile, analice las siguientes afirmaciones:',
        'solutions': [
          'I) Las farmacias pueden realizar preparados magistrales y oficinales',
          'II) Los almacenes farmacéuticos pueden vender productos de venta directa',
          'III) Los botiquines pueden almacenar productos psicotrópicos',
          'IV) Las farmacias siempre deben tener un químico farmacéutico presente'
        ],
        'options': [
          'a) Solo I y II son correctas',
          'b) Solo II y III son correctas',
          'c) I, II y IV son correctas',
          'd) Todas son correctas'
        ],
        'correctAnswer': 'd) Todas son correctas',
        'explanation':
            'Todas las afirmaciones son correctas según lo explicado en clase. Las farmacias pueden realizar preparados magistrales y oficinales bajo la supervisión de un químico farmacéutico. Los almacenes farmacéuticos están autorizados para vender productos de venta directa. Los botiquines pueden almacenar productos psicotrópicos siguiendo la misma reglamentación que las farmacias. Y las farmacias siempre deben contar con un químico farmacéutico presente para poder funcionar.'
      },
      {
        'type': 'complex',
        'question': 'Sobre los medicamentos controlados, analice:',
        'solutions': [
          'I) Los psicotrópicos requieren almacenamiento bajo llave',
          'II) La dispensación debe ser realizada por el químico farmacéutico',
          'III) Requieren un libro de control específico',
          'IV) Los botiquines no pueden almacenarlos'
        ],
        'options': [
          'a) Solo I y II son correctas',
          'b) Solo II y III son correctas',
          'c) I, II y III son correctas',
          'd) Todas son correctas'
        ],
        'correctAnswer': 'c) I, II y III son correctas',
        'explanation':
            'Las afirmaciones I, II y III son correctas. Los psicotrópicos deben almacenarse bajo llave, ser dispensados por el químico farmacéutico y requieren un libro de control específico. La afirmación IV es incorrecta porque los botiquines sí pueden almacenar medicamentos controlados bajo la reglamentación correspondiente.'
      },
      {
        'type': 'complex',
        'question': 'Sobre las especialidades farmacéuticas, analice:',
        'solutions': [
          'I) Pueden ser de origen sintético o natural',
          'II) Incluyen productos biológicos y radiofármacos',
          'III) Deben tener registro sanitario',
          'IV) Solo pueden ser de fabricación nacional'
        ],
        'options': [
          'a) Solo I y II son correctas',
          'b) Solo II y III son correctas',
          'c) I, II y III son correctas',
          'd) Todas son correctas'
        ],
        'correctAnswer': 'c) I, II y III son correctas',
        'explanation':
            'Las afirmaciones I, II y III son correctas. Las especialidades farmacéuticas pueden ser de origen sintético o natural, incluyen productos biológicos y radiofármacos, y deben tener registro sanitario. La afirmación IV es incorrecta porque pueden ser tanto de fabricación nacional como importadas.'
      },
      {
        'type': 'complex',
        'question': 'Sobre el fraccionamiento de medicamentos, analice:',
        'solutions': [
          'I) Debe realizarse en un área independiente',
          'II) Requiere registro en un libro específico',
          'III) Solo puede realizarse con envases clínicos',
          'IV) Cualquier auxiliar puede realizarlo sin supervisión'
        ],
        'options': [
          'a) Solo I y II son correctas',
          'b) Solo II y III son correctas',
          'c) I, II y III son correctas',
          'd) Todas son correctas'
        ],
        'correctAnswer': 'c) I, II y III son correctas',
        'explanation':
            'Las afirmaciones I, II y III son correctas. El fraccionamiento debe realizarse en un área independiente, requiere registro en un libro específico y solo puede realizarse con envases clínicos. La afirmación IV es incorrecta porque debe realizarse bajo supervisión del químico farmacéutico.'
      },
      {
        'type': 'complex',
        'question': 'Sobre la documentación obligatoria en farmacias, analice:',
        'solutions': [
          'I) El petitorio mínimo debe estar actualizado',
          'II) Los reglamentos deben estar disponibles para consulta',
          'III) Las monografías deben ser autorizadas por el ISP',
          'IV) La documentación puede estar en formato digital únicamente'
        ],
        'options': [
          'a) Solo I y II son correctas',
          'b) Solo II y III son correctas',
          'c) I, II y III son correctas',
          'd) Todas son correctas'
        ],
        'correctAnswer': 'c) I, II y III son correctas',
        'explanation':
            'Las afirmaciones I, II y III son correctas. El petitorio mínimo debe estar actualizado, los reglamentos disponibles para consulta y las monografías autorizadas por el ISP. La afirmación IV es incorrecta porque la documentación debe estar disponible también en formato físico.'
      },
      {
        'type': 'complex',
        'question': 'Sobre las buenas prácticas de almacenamiento, analice:',
        'solutions': [
          'I) Se debe mantener registro de temperatura y humedad',
          'II) El personal debe estar capacitado',
          'III) Los productos vencidos deben separarse inmediatamente',
          'IV) La limpieza puede realizarse con cualquier producto'
        ],
        'options': [
          'a) Solo I y II son correctas',
          'b) Solo II y III son correctas',
          'c) I, II y III son correctas',
          'd) Todas son correctas'
        ],
        'correctAnswer': 'c) I, II y III son correctas',
        'explanation':
            'Las afirmaciones I, II y III son correctas. Se debe mantener registro de temperatura y humedad, el personal debe estar capacitado y los productos vencidos deben separarse. La afirmación IV es incorrecta porque la limpieza debe realizarse con productos específicos que no afecten los medicamentos.'
      },
      {
        'type': 'complex',
        'question': 'Sobre los preparados farmacéuticos, analice:',
        'solutions': [
          'I) Los preparados magistrales son para un paciente específico',
          'II) Los preparados oficinales siguen la farmacopea',
          'III) Requieren un área específica de preparación',
          'IV) Pueden prepararse en cualquier farmacia'
        ],
        'options': [
          'a) Solo I y II son correctas',
          'b) Solo II y III son correctas',
          'c) I, II y III son correctas',
          'd) Todas son correctas'
        ],
        'correctAnswer': 'c) I, II y III son correctas',
        'explanation':
            'Las afirmaciones I, II y III son correctas. Los preparados magistrales son específicos para un paciente, los oficinales siguen la farmacopea y requieren un área específica de preparación. La afirmación IV es incorrecta porque solo las farmacias autorizadas pueden preparar medicamentos.'
      }
    ],
    'Clase 3': [
      // Preguntas de Clase 3...
      {
        'type': 'simple',
        'question':
            '¿Cuál es la principal diferencia entre un principio activo y un excipiente en un medicamento?',
        'options': [
          'a) El principio activo es líquido y el excipiente es sólido',
          'b) El principio activo genera el efecto farmacológico mientras el excipiente facilita la administración',
          'c) El excipiente es más importante que el principio activo',
          'd) El principio activo solo se usa en jarabes y el excipiente en comprimidos'
        ],
        'correctAnswer':
            'b) El principio activo genera el efecto farmacológico mientras el excipiente facilita la administración',
        'explanation':
            'El principio activo es la sustancia o mezcla de sustancias dotadas de un efecto farmacológico específico que genera cambios en el organismo, mientras que los excipientes son materias primas utilizadas en la fabricación que no tienen acción farmacológica pero ayudan a dar forma al medicamento o mejorar su absorción.'
      },
      {
        'type': 'simple',
        'question':
            '¿Qué característica define a una forma farmacéutica de liberación convencional?',
        'options': [
          'a) Libera el principio activo de forma controlada por varios días',
          'b) Solo se libera en el intestino',
          'c) El principio activo se libera de forma pareja una vez que ingresa al organismo',
          'd) Requiere tecnología especial para su fabricación'
        ],
        'correctAnswer':
            'c) El principio activo se libera de forma pareja una vez que ingresa al organismo',
        'explanation':
            'Las formas farmacéuticas de liberación convencional se caracterizan porque las sustancias activas se liberan una vez que ingresan al organismo de forma pareja, sin tiempos de retención específicos ni procesos especiales de fabricación que modifiquen estos tiempos.'
      },
      {
        'type': 'simple',
        'question':
            '¿Cuál es la diferencia principal entre una pomada y una crema como forma farmacéutica?',
        'options': [
          'a) La pomada es líquida y la crema es sólida',
          'b) La pomada tiene una base de una sola fase oleosa, mientras la crema tiene una base multifásica',
          'c) La pomada es para uso oral y la crema para uso tópico',
          'd) La pomada solo puede contener un principio activo y la crema varios'
        ],
        'correctAnswer':
            'b) La pomada tiene una base de una sola fase oleosa, mientras la crema tiene una base multifásica',
        'explanation':
            'Las pomadas constan de una base de una sola fase que es principalmente oleosa, mientras que las cremas son preparaciones multifásicas que contienen una base grasa y una base acuosa mezcladas, lo que permite que puedan contener diferentes tipos de principios activos.'
      },
      {
        'type': 'simple',
        'question':
            '¿Qué característica principal tienen los parches transdérmicos?',
        'options': [
          'a) Solo pueden aplicarse en zonas con heridas',
          'b) Deben colocarse en piel sana para liberar principios activos a la circulación',
          'c) Son exclusivamente para uso oral',
          'd) Solo funcionan con antibióticos'
        ],
        'correctAnswer':
            'b) Deben colocarse en piel sana para liberar principios activos a la circulación',
        'explanation':
            'Los parches transdérmicos son preparaciones farmacéuticas diseñadas para ser aplicadas directamente sobre piel sana, permitiendo que los principios activos atraviesen la barrera cutánea y lleguen a la circulación general. Es fundamental que la piel esté sana y sin heridas para su correcta función.'
      },
      {
        'type': 'simple',
        'question': '¿Cuál es la característica distintiva de un colirio?',
        'options': [
          'a) Es una solución oral',
          'b) Es una preparación estéril para aplicación ocular',
          'c) Es un jarabe con saborizantes',
          'd) Es una crema para uso tópico'
        ],
        'correctAnswer': 'b) Es una preparación estéril para aplicación ocular',
        'explanation':
            'Los colirios son disoluciones o suspensiones estériles destinadas específicamente para ser aplicadas en el ojo. La esterilidad es su característica más importante debido a la sensibilidad y vulnerabilidad del tejido ocular.'
      },
      {
        'type': 'simple',
        'question':
            '¿Qué diferencia principal existe entre un resfrío y una gripe?',
        'options': [
          'a) El resfrío es más grave que la gripe',
          'b) La gripe tiene un inicio repentino y violento, mientras el resfrío es gradual',
          'c) El resfrío siempre tiene fiebre alta',
          'd) La gripe solo afecta a niños'
        ],
        'correctAnswer':
            'b) La gripe tiene un inicio repentino y violento, mientras el resfrío es gradual',
        'explanation':
            'La principal diferencia entre resfrío y gripe es la forma de inicio de los síntomas. La gripe se caracteriza por un comienzo repentino y violento con síntomas intensos, mientras que el resfrío presenta un desarrollo gradual de los síntomas a lo largo de varios días.'
      },
      {
        'type': 'simple',
        'question':
            '¿Qué característica define a los medicamentos antigripales de venta directa?',
        'options': [
          'a) Contienen un solo principio activo',
          'b) Son asociaciones de varios principios activos',
          'c) Solo se usan en niños',
          'd) Requieren receta médica'
        ],
        'correctAnswer': 'b) Son asociaciones de varios principios activos',
        'explanation':
            'Los antigripales de venta directa se caracterizan por ser asociaciones de diferentes principios activos que pueden incluir ácido ascórbico, cafeína, clorfenamina, noscapina y paracetamol, diseñados para tratar múltiples síntomas de la gripe simultáneamente.'
      },
      {
        'type': 'simple',
        'question': '¿Qué función cumple el ambroxol como medicamento?',
        'options': [
          'a) Es un antitusivo para tos seca',
          'b) Es un mucolítico que ayuda a eliminar secreciones',
          'c) Es un antigripal',
          'd) Es un antihistamínico'
        ],
        'correctAnswer': 'b) Es un mucolítico que ayuda a eliminar secreciones',
        'explanation':
            'El ambroxol es un mucolítico que se utiliza para facilitar la eliminación de secreciones en estados gripales, ayudando a fluidificar el moco y facilitando su expulsión cuando hay tos productiva.'
      },
      {
        'type': 'simple',
        'question':
            '¿Cuál es la diferencia entre un antiséptico y un desinfectante?',
        'options': [
          'a) El antiséptico es más fuerte que el desinfectante',
          'b) El antiséptico se aplica en tejidos vivos y el desinfectante en objetos inanimados',
          'c) El antiséptico es más barato que el desinfectante',
          'd) El antiséptico solo funciona contra bacterias'
        ],
        'correctAnswer':
            'b) El antiséptico se aplica en tejidos vivos y el desinfectante en objetos inanimados',
        'explanation':
            'La principal diferencia radica en su uso: los antisépticos están diseñados para aplicarse en tejidos vivos (piel, mucosas, heridas), mientras que los desinfectantes se utilizan en objetos inanimados y superficies.'
      },
      {
        'type': 'simple',
        'question': '¿Qué característica principal tienen las grajeas?',
        'options': [
          'a) Son líquidos para uso oral',
          'b) Son comprimidos recubiertos con capas de cera y saborizantes',
          'c) Son inyectables',
          'd) Son parches para la piel'
        ],
        'correctAnswer':
            'b) Son comprimidos recubiertos con capas de cera y saborizantes',
        'explanation':
            'Las grajeas son comprimidos que están recubiertos por múltiples capas de cera con saborizantes, lo que facilita su deglución al hacerlos más agradables al paladar y más fáciles de tragar.'
      },
      {
        'type': 'simple',
        'question': '¿Qué característica principal tienen los supositorios?',
        'options': [
          'a) Son preparaciones líquidas para uso oral',
          'b) Son preparaciones sólidas unidosis para administración rectal',
          'c) Son cremas para uso tópico',
          'd) Son gotas para los ojos'
        ],
        'correctAnswer':
            'b) Son preparaciones sólidas unidosis para administración rectal',
        'explanation':
            'Los supositorios son preparaciones sólidas unidosis diseñadas específicamente para ser administradas por vía rectal, donde se disuelven a temperatura corporal permitiendo la absorción de los principios activos.'
      },
      {
        'type': 'simple',
        'question': '¿Qué son las lágrimas artificiales?',
        'options': [
          'a) Gotas para el dolor de ojos',
          'b) Gotas lubricantes que mantienen la humedad del ojo',
          'c) Gotas con antibióticos',
          'd) Gotas para dilatar la pupila'
        ],
        'correctAnswer':
            'b) Gotas lubricantes que mantienen la humedad del ojo',
        'explanation':
            'Las lágrimas artificiales son gotas lubricantes diseñadas para mantener la humedad y lubricación de la superficie ocular, especialmente útiles en casos de ojo seco o cuando hay una producción insuficiente de lágrimas naturales.'
      },
      {
        'type': 'simple',
        'question':
            '¿Qué característica define a la vía sublingual de administración?',
        'options': [
          'a) El medicamento se traga directamente',
          'b) El medicamento se absorbe bajo la lengua',
          'c) El medicamento se inyecta',
          'd) El medicamento se aplica en la piel'
        ],
        'correctAnswer': 'b) El medicamento se absorbe bajo la lengua',
        'explanation':
            'La vía sublingual se caracteriza porque el medicamento se coloca bajo la lengua, donde es absorbido por los capilares, pasando directamente a la circulación sanguínea a través de la vena carótida.'
      },
      {
        'type': 'simple',
        'question': '¿Qué es la onicomicosis?',
        'options': [
          'a) Una infección en la piel',
          'b) Una infección por hongos en las uñas',
          'c) Una alergia cutánea',
          'd) Una infección bacterial'
        ],
        'correctAnswer': 'b) Una infección por hongos en las uñas',
        'explanation':
            'La onicomicosis es una infección fúngica que afecta las uñas, caracterizada por cambios en la coloración de la uña, que puede volverse amarillenta o café, y puede causar fragilidad o engrosamiento de la misma.'
      },
      {
        'type': 'simple',
        'question': '¿Qué son los preparados parenterales?',
        'options': [
          'a) Medicamentos para tomar por boca',
          'b) Preparaciones estériles para administración por inyección',
          'c) Cremas para la piel',
          'd) Gotas para los ojos'
        ],
        'correctAnswer':
            'b) Preparaciones estériles para administración por inyección',
        'explanation':
            'Los preparados parenterales son preparaciones estériles diseñadas para ser administradas mediante inyección o perfusión, debiendo tener el mismo pH y tonicidad que la sangre para su administración segura.'
      },
      {
        'type': 'simple',
        'question':
            '¿Qué característica principal tiene la clorhexidina como antiséptico?',
        'options': [
          'a) Es un antiséptico solo para la piel',
          'b) Es un antiséptico bucofaríngeo para aliviar molestias de garganta',
          'c) Es un antibiótico',
          'd) Es un analgésico'
        ],
        'correctAnswer':
            'b) Es un antiséptico bucofaríngeo para aliviar molestias de garganta',
        'explanation':
            'La clorhexidina es un antiséptico bucofaríngeo utilizado principalmente para aliviar las molestias producidas por infecciones o irritaciones en la garganta, administrado generalmente en forma de comprimidos para disolver en la boca.'
      },
      {
        'type': 'simple',
        'question':
            '¿Qué característica define a los productos farmacéuticos de asociación?',
        'options': [
          'a) Contienen un solo principio activo',
          'b) Contienen dos o más principios activos en una misma forma farmacéutica',
          'c) Solo pueden ser inyectables',
          'd) Solo pueden ser jarabes'
        ],
        'correctAnswer':
            'b) Contienen dos o más principios activos en una misma forma farmacéutica',
        'explanation':
            'Los productos farmacéuticos de asociación se caracterizan por contener dos o más principios activos incorporados en una misma forma farmacéutica, como por ejemplo un inhalador que contiene salbutamol y beclometasona.'
      },
      {
        'type': 'simple',
        'question': '¿Qué son los anillos vaginales?',
        'options': [
          'a) Dispositivos metálicos',
          'b) Aros de plástico que liberan hormonas',
          'c) Comprimidos vaginales',
          'd) Cremas vaginales'
        ],
        'correctAnswer': 'b) Aros de plástico que liberan hormonas',
        'explanation':
            'Los anillos vaginales son dispositivos en forma de aro, generalmente fabricados con materiales plásticos como acetato de vinilo, que se colocan en la vagina y liberan principios activos, principalmente hormonas femeninas.'
      },
      {
        'type': 'simple',
        'question':
            '¿Qué característica define a la vía intravenosa de administración?',
        'options': [
          'a) El medicamento se aplica en la piel',
          'b) El medicamento se ingiere por boca',
          'c) El medicamento ingresa directamente a una vena',
          'd) El medicamento se aplica en el músculo'
        ],
        'correctAnswer': 'c) El medicamento ingresa directamente a una vena',
        'explanation':
            'La vía intravenosa se caracteriza porque el medicamento ingresa directamente al sistema circulatorio a través de una vena, permitiendo una acción inmediata del fármaco sin proceso de absorción.'
      },
      {
        'type': 'simple',
        'question': '¿Qué son los polvos para uso oral?',
        'options': [
          'a) Polvos para aplicar en la piel',
          'b) Preparaciones para disolver o suspender en líquido antes de su administración oral',
          'c) Polvos para inhalar',
          'd) Polvos para uso tópico'
        ],
        'correctAnswer':
            'b) Preparaciones para disolver o suspender en líquido antes de su administración oral',
        'explanation':
            'Los polvos para uso oral son preparaciones que requieren ser disueltas o suspendidas en un líquido antes de su administración por vía oral, como por ejemplo las sales de rehidratación oral.'
      },
      // ****************************************************************************************

      // ****************************************************************************************

      // ****************************************************************************************
      {
        'type': 'complex',
        'question': 'Sobre las gomas de mascar medicamentosas:',
        'solutions': [
          'I) Deben ser masticadas y no tragadas',
          'II) Solo pueden contener un principio activo',
          'III) La base es una goma que libera el medicamento al masticar',
          'IV) El ejemplo más común son los chicles de nicotina'
        ],
        'options': [
          'a) Solo I y III son correctas',
          'b) I, III y IV son correctas',
          'c) Solo II y IV son correctas',
          'd) Todas son correctas'
        ],
        'correctAnswer': 'b) I, III y IV son correctas',
        'explanation':
            'Las gomas medicamentosas deben ser masticadas y no tragadas (I), tienen una base de goma que libera el medicamento durante la masticación (III), y el ejemplo más común son los chicles de nicotina (IV). La opción II es incorrecta porque pueden contener más de un principio activo.'
      },
      {
        'type': 'complex',
        'question': 'Respecto a los excipientes en los medicamentos:',
        'solutions': [
          'I) Son materias primas usadas en la fabricación',
          'II) No tienen acción farmacológica',
          'III) Solo pueden ser de origen natural',
          'IV) Incluyen colorantes y saborizantes'
        ],
        'options': [
          'a) I, II y IV son correctas',
          'b) Solo II y III son correctas',
          'c) Solo I y IV son correctas',
          'd) Todas son correctas'
        ],
        'correctAnswer': 'a) I, II y IV son correctas',
        'explanation':
            'Los excipientes son materias primas usadas en la fabricación (I), no tienen acción farmacológica (II), y pueden incluir colorantes y saborizantes (IV). La opción III es incorrecta porque pueden ser tanto de origen natural como sintético.'
      },
      {
        'type': 'complex',
        'question': 'En relación a los jarabes:',
        'solutions': [
          'I) Tienen consistencia viscosa',
          'II) Contienen más de 45% de sacarosa',
          'III) Solo pueden contener principios activos hidrosolubles',
          'IV) Tienen sabor dulce característico'
        ],
        'options': [
          'a) Solo I y II son correctas',
          'b) Solo II y III son correctas',
          'c) I, II y IV son correctas',
          'd) Todas son correctas'
        ],
        'correctAnswer': 'c) I, II y IV son correctas',
        'explanation':
            'Los jarabes tienen consistencia viscosa (I), contienen más de 45% de sacarosa (II), y tienen un sabor dulce característico (IV). La opción III es incorrecta porque pueden contener diferentes tipos de principios activos, no solo hidrosolubles.'
      },
      {
        'type': 'complex',
        'question': 'Sobre los óvulos vaginales:',
        'solutions': [
          'I) Son preparaciones sólidas unidosis',
          'II) Deben fundirse a temperatura corporal',
          'III) Solo pueden contener un principio activo',
          'IV) Se administran por vía vaginal'
        ],
        'options': [
          'a) Solo I y IV son correctas',
          'b) I, II y IV son correctas',
          'c) Solo II y III son correctas',
          'd) Todas son correctas'
        ],
        'correctAnswer': 'b) I, II y IV son correctas',
        'explanation':
            'Los óvulos son preparaciones sólidas unidosis (I), están diseñados para fundirse a temperatura corporal (II), y se administran por vía vaginal (IV). La opción III es incorrecta porque pueden contener uno o más principios activos.'
      },
      {
        'type': 'complex',
        'question': 'Respecto a la vía de administración subcutánea:',
        'solutions': [
          'I) La aguja atraviesa la piel hasta el tejido subdérmico',
          'II) Es una vía de acción inmediata',
          'III) Requiere técnicas de asepsia',
          'IV) La absorción ocurre por el plexo arteriovenoso'
        ],
        'options': [
          'a) Solo II y IV son correctas',
          'b) I, III y IV son correctas',
          'c) Solo I y III son correctas',
          'd) Todas son correctas'
        ],
        'correctAnswer': 'b) I, III y IV son correctas',
        'explanation':
            'En la vía subcutánea, la aguja atraviesa la piel hasta el tejido subdérmico (I), requiere técnicas de asepsia (III), y la absorción ocurre por el plexo arteriovenoso (IV). La opción II es incorrecta porque es una vía de acción lenta, no inmediata.'
      },
      {
        'type': 'complex',
        'question': 'Sobre las barras como forma farmacéutica:',
        'solutions': [
          'I) Son preparados sólidos para aplicación local',
          'II) Pueden presentarse como varillas o labiales',
          'III) Requieren refrigeración para su uso',
          'IV) Se disuelven con la temperatura corporal'
        ],
        'options': [
          'a) I, II y IV son correctas',
          'b) Solo II y III son correctas',
          'c) Solo I y IV son correctas',
          'd) Todas son correctas'
        ],
        'correctAnswer': 'a) I, II y IV son correctas',
        'explanation':
            'Las barras son preparados sólidos para aplicación local (I), pueden presentarse como varillas o labiales (II), y se disuelven con la temperatura corporal (IV). La opción III es incorrecta porque no requieren refrigeración para su uso.'
      },
      {
        'type': 'complex',
        'question': 'En relación a los champús medicamentosos:',
        'solutions': [
          'I) Son preparaciones líquidas o semisólidas',
          'II) Se aplican en el cuero cabelludo',
          'III) Siempre generan espuma',
          'IV) Requieren enjuague posterior'
        ],
        'options': [
          'a) Solo I y III son correctas',
          'b) I, II y IV son correctas',
          'c) Solo II y IV son correctas',
          'd) Todas son correctas'
        ],
        'correctAnswer': 'b) I, II y IV son correctas',
        'explanation':
            'Los champús medicamentosos son preparaciones líquidas o semisólidas (I), se aplican en el cuero cabelludo (II), y requieren enjuague posterior (IV). La opción III es incorrecta porque no todos generan espuma, depende de su formulación.'
      },
      {
        'type': 'complex',
        'question': 'Sobre los colutorios:',
        'solutions': [
          'I) Son formas farmacéuticas líquidas',
          'II) Se utilizan para enjuagues bucales',
          'III) Deben ser tragados después de su uso',
          'IV) Contienen generalmente antisépticos'
        ],
        'options': [
          'a) Solo I y II son correctas',
          'b) I, II y IV son correctas',
          'c) Solo III y IV son correctas',
          'd) Todas son correctas'
        ],
        'correctAnswer': 'b) I, II y IV son correctas',
        'explanation':
            'Los colutorios son formas farmacéuticas líquidas (I), se utilizan para enjuagues bucales (II), y contienen generalmente antisépticos (IV). La opción III es incorrecta porque nunca deben ser tragados después de su uso.'
      },
      {
        'type': 'complex',
        'question': 'Respecto a los anillos vaginales:',
        'solutions': [
          'I) Son de material plástico',
          'II) Miden aproximadamente 5 cm de diámetro',
          'III) Solo pueden liberar hormonas',
          'IV) Se colocan en el interior de la vagina'
        ],
        'options': [
          'a) Solo I y III son correctas',
          'b) I, II y IV son correctas',
          'c) Solo II y IV son correctas',
          'd) Todas son correctas'
        ],
        'correctAnswer': 'b) I, II y IV son correctas',
        'explanation':
            'Los anillos vaginales son de material plástico (I), miden aproximadamente 5 cm de diámetro (II), y se colocan en el interior de la vagina (IV). La opción III es incorrecta porque pueden liberar diferentes tipos de principios activos, no solo hormonas.'
      },
      {
        'type': 'complex',
        'question': 'Sobre los baños oculares:',
        'solutions': [
          'I) Son soluciones estériles',
          'II) Se usan para lavar el ojo',
          'III) Solo pueden contener un principio activo',
          'IV) Pueden usarse en vendajes oculares'
        ],
        'options': [
          'a) Solo I y III son correctas',
          'b) I, II y IV son correctas',
          'c) Solo II y IV son correctas',
          'd) Todas son correctas'
        ],
        'correctAnswer': 'b) I, II y IV son correctas',
        'explanation':
            'Los baños oculares son soluciones estériles (I), se usan para lavar el ojo (II), y pueden usarse en vendajes oculares (IV). La opción III es incorrecta porque pueden contener más de un principio activo.'
      },
      {
        'type': 'complex',
        'question': 'Sobre los jarabes como forma farmacéutica:',
        'solutions': [
          'I) Son preparaciones acuosas',
          'II) Tienen consistencia viscosa',
          'III) Contienen más de 45% de sacarosa',
          'IV) Siempre son de sabor amargo'
        ],
        'options': [
          'a) Solo I y II son correctas',
          'b) I, II y III son correctas',
          'c) Solo II y III son correctas',
          'd) Todas son correctas'
        ],
        'correctAnswer': 'a) Solo I y II son correctas',
        'explanation':
            'Los jarabes son preparaciones acuosas (I) y tienen consistencia viscosa (II). La opción III es incorrecta porque no necesariamente contienen más de 45% de sacarosa, y la IV es incorrecta porque justamente se caracterizan por su sabor dulce, no amargo.'
      },
      {
        'type': 'complex',
        'question':
            '¿Cuáles son las características fundamentales de un medicamento?',
        'solutions': [
          'I) Está compuesto por principio activo y excipientes',
          'II) La forma farmacéutica contiene la dosis establecida',
          'III) Los excipientes tienen acción farmacológica directa',
          'IV) El principio activo genera un cambio en el organismo'
        ],
        'options': [
          'a) Solo I y II son correctas',
          'b) Solo II y III son correctas',
          'c) I, II y IV son correctas',
          'd) Todas son correctas'
        ],
        'correctAnswer': 'c) I, II y IV son correctas',
        'explanation':
            'Un medicamento está compuesto fundamentalmente por principio activo (que genera el efecto farmacológico o cambio en el organismo) y excipientes (que NO tienen acción farmacológica, solo ayudan a dar forma y mejorar la absorción). La forma farmacéutica es la presentación final que contiene la dosis establecida. La opción III es incorrecta porque los excipientes específicamente se caracterizan por NO tener acción farmacológica.'
      },
      {
        'type': 'complex',
        'question':
            'Respecto a las formas farmacéuticas de liberación modificada:',
        'solutions': [
          'I) Controlan la velocidad de absorción del medicamento',
          'II) Pueden determinar el lugar específico de liberación',
          'III) Tienen una cubierta especial que controla el flujo del principio activo',
          'IV) Se liberan de forma inmediata al ingresar al organismo'
        ],
        'options': [
          'a) Solo I y II son correctas',
          'b) I, II y III son correctas',
          'c) Solo II y III son correctas',
          'd) Todas son correctas'
        ],
        'correctAnswer': 'b) I, II y III son correctas',
        'explanation':
            'Las formas farmacéuticas de liberación modificada se caracterizan por controlar la velocidad con la que el medicamento entra en contacto con el organismo (I), pueden estar diseñadas para liberarse en lugares específicos como estómago o intestino (II), y utilizan cubiertas especiales que controlan el flujo de salida del principio activo (III). La opción IV es incorrecta porque justamente se caracterizan por NO liberarse de forma inmediata, sino de manera controlada.'
      },
      {
        'type': 'complex',
        'question': 'Sobre los comprimidos y las grajeas:',
        'solutions': [
          'I) Las grajeas son comprimidos recubiertos con capas de cera',
          'II) Los comprimidos pueden contener una o más dosis de principio activo',
          'III) Las grajeas facilitan la deglución por su recubrimiento',
          'IV) Los comprimidos son siempre de liberación inmediata'
        ],
        'options': [
          'a) I, II y III son correctas',
          'b) Solo II y III son correctas',
          'c) Solo I y IV son correctas',
          'd) Todas son correctas'
        ],
        'correctAnswer': 'a) I, II y III son correctas',
        'explanation':
            'Las grajeas son efectivamente comprimidos recubiertos por capas de cera (I), los comprimidos pueden contener una o múltiples dosis de principios activos (II), y el recubrimiento de las grajeas con capas azucaradas facilita su deglución (III). La opción IV es incorrecta porque los comprimidos pueden ser tanto de liberación inmediata como modificada.'
      },
      {
        'type': 'complex',
        'question': 'Sobre las vías de administración enteral:',
        'solutions': [
          'I) Incluye la vía oral, sublingual y rectal',
          'II) Es la vía más segura y económica',
          'III) La absorción se realiza a través del tubo digestivo',
          'IV) Requiere técnicas de asepsia especiales'
        ],
        'options': [
          'a) Solo I y IV son correctas',
          'b) I, II y III son correctas',
          'c) Solo II y III son correctas',
          'd) Todas son correctas'
        ],
        'correctAnswer': 'b) I, II y III son correctas',
        'explanation':
            'La vía enteral incluye las vías oral, sublingual y rectal (I), es considerada la más segura y económica (II), y la absorción se realiza a través del tubo digestivo (III). La opción IV es incorrecta porque las técnicas de asepsia especiales son requeridas para la vía parenteral, no para la enteral.'
      },
      {
        'type': 'complex',
        'question': 'En relación a los antisépticos:',
        'solutions': [
          'I) Se aplican sobre tejidos vivos para destruir microorganismos',
          'II) Deben actuar contra la mayor variedad posible de microorganismos',
          'III) Deben difundir fácilmente a través de la materia orgánica',
          'IV) Son sinónimos de desinfectantes'
        ],
        'options': [
          'a) Solo I y IV son correctas',
          'b) I, II y III son correctas',
          'c) Solo II y III son correctas',
          'd) Todas son correctas'
        ],
        'correctAnswer': 'b) I, II y III son correctas',
        'explanation':
            'Los antisépticos se aplican sobre tejidos vivos para destruir microorganismos (I), deben tener un amplio espectro de acción contra diferentes microorganismos (II), y necesitan difundir fácilmente a través de la materia orgánica (III). La opción IV es incorrecta porque los antisépticos y desinfectantes NO son sinónimos - los desinfectantes se aplican sobre objetos inanimados mientras que los antisépticos se usan en tejidos vivos.'
      },
      {
        'type': 'complex',
        'question':
            'Sobre las características de la gripe versus el resfriado:',
        'solutions': [
          'I) La gripe tiene un comienzo repentino y violento',
          'II) El resfriado presenta congestión y estornudos como síntomas principales',
          'III) La fiebre es más común en la gripe que en el resfriado',
          'IV) La gripe siempre presenta congestión nasal severa'
        ],
        'options': [
          'a) Solo I y IV son correctas',
          'b) I, II y III son correctas',
          'c) Solo II y III son correctas',
          'd) Todas son correctas'
        ],
        'correctAnswer': 'b) I, II y III son correctas',
        'explanation':
            'La gripe se caracteriza por un inicio repentino y violento (I), mientras que el resfriado se caracteriza principalmente por congestión y estornudos (II). La fiebre es un síntoma mucho más común en la gripe que en el resfriado (III). La opción IV es incorrecta porque la congestión nasal severa es más característica del resfriado que de la gripe.'
      },
      {
        'type': 'complex',
        'question':
            'Respecto a los medicamentos antigripales de venta directa:',
        'solutions': [
          'I) Son combinaciones de varios principios activos',
          'II) Se administran cada 8 horas',
          'III) No deben consumirse con alcohol',
          'IV) Son seguros en el embarazo sin supervisión médica'
        ],
        'options': [
          'a) I, II y III son correctas',
          'b) Solo II y III son correctas',
          'c) Solo I y IV son correctas',
          'd) Todas son correctas'
        ],
        'correctAnswer': 'a) I, II y III son correctas',
        'explanation':
            'Los antigripales de venta directa son combinaciones de varios principios activos (I), se administran cada 8 horas (II), y no deben consumirse con alcohol (III). La opción IV es incorrecta porque las mujeres embarazadas NO deben usar estos productos sin supervisión médica.'
      },
      {
        'type': 'complex',
        'question': 'Sobre los antifúngicos de venta directa:',
        'solutions': [
          'I) El ketoconazol al 1% en champú es de venta directa',
          'II) La morfina al 5% se usa para onicomicosis',
          'III) Se aplican en la zona afectada 2-3 veces al día',
          'IV) Pueden generar irritación en la zona de aplicación'
        ],
        'options': [
          'a) Solo I y IV son correctas',
          'b) I, III y IV son correctas',
          'c) Solo II y III son correctas',
          'd) Todas son correctas'
        ],
        'correctAnswer': 'b) I, III y IV son correctas',
        'explanation':
            'El ketoconazol al 1% en champú es efectivamente de venta directa (I), los antifúngicos tópicos generalmente se aplican 2-3 veces al día (III), y pueden causar irritación en la zona de aplicación (IV). La opción II es incorrecta porque es amorfolina, no morfina, la que se usa para onicomicosis.'
      },
      {
        'type': 'complex',
        'question': 'Sobre los colirios:',
        'solutions': [
          'I) Son preparaciones estériles',
          'II) Se administran en forma de gotas en el ojo',
          'III) Pueden ser soluciones o suspensiones',
          'IV) No requieren condiciones especiales de almacenamiento'
        ],
        'options': [
          'a) Solo I y IV son correctas',
          'b) I, II y III son correctas',
          'c) Solo II y III son correctas',
          'd) Todas son correctas'
        ],
        'correctAnswer': 'b) I, II y III son correctas',
        'explanation':
            'Los colirios son preparaciones estériles (I), se administran en forma de gotas en el ojo (II), y pueden ser soluciones o suspensiones (III). La opción IV es incorrecta porque los colirios sí requieren condiciones especiales de almacenamiento para mantener su esterilidad y estabilidad.'
      },
      {
        'type': 'complex',
        'question': 'Sobre las vías de administración parenteral:',
        'solutions': [
          'I) La vía intravenosa permite una acción inmediata',
          'II) La vía intramuscular tiene una absorción más lenta',
          'III) Requieren técnicas de asepsia',
          'IV) Son las más económicas y seguras'
        ],
        'options': [
          'a) Solo I y IV son correctas',
          'b) I, II y III son correctas',
          'c) Solo II y III son correctas',
          'd) Todas son correctas'
        ],
        'correctAnswer': 'b) I, II y III son correctas',
        'explanation':
            'La vía intravenosa permite una acción inmediata del fármaco (I), la vía intramuscular tiene una absorción más lenta por requerir absorción desde el músculo (II), y todas las vías parenterales requieren técnicas de asepsia (III). La opción IV es incorrecta porque las vías parenterales NO son las más económicas ni seguras - esa característica corresponde a la vía enteral.'
      },
    ],
    'Clase 4': [
      // Preguntas de Clase 4...
      {
        'type': 'simple',
        'question':
            '¿Qué dosis de simeticona junto con malganat se recomienda para adultos con acidez y exceso de gases?',
        'options': [
          'a) 30-60 mg de simeticona con 0.25-0.5 g de malganat',
          'b) 60-120 mg de simeticona con 0.5-1 g de malganat',
          'c) 120-240 mg de simeticona con 1-2 g de malganat',
          'd) 240-480 mg de simeticona con 2-4 g de malganat'
        ],
        'correctAnswer': 'b) 60-120 mg de simeticona con 0.5-1 g de malganat',
        'explanation':
            'Según lo explicado en la clase, para adultos la dosis recomendada es de 60-120 mg de simeticona junto con 0.5-1 g de malganat, administrado hasta 4 veces al día como máximo. Esta dosificación permite un alivio temporal efectivo de la acidez y el exceso de gases mientras se mantiene dentro de los márgenes de seguridad.'
      },
      {
        'type': 'simple',
        'question':
            '¿Cuál es la definición correcta de diarrea según lo explicado en clase?',
        'options': [
          'a) Más de dos evacuaciones líquidas al día',
          'b) Cualquier evacuación acuosa en 24 horas',
          'c) Heces acuosas y blandas que ocurren más de tres veces en un día',
          'd) Evacuaciones frecuentes sin importar su consistencia'
        ],
        'correctAnswer':
            'c) Heces acuosas y blandas que ocurren más de tres veces en un día',
        'explanation':
            'La definición precisa de diarrea presentada en la clase establece que son "aquellas heces acuosas y blandas que ocurren más de tres veces en un día". Esta definición es importante para distinguir un proceso diarreico de un proceso digestivo normal, lo cual es crucial para determinar cuándo se requiere intervención terapéutica.'
      },
      {
        'type': 'simple',
        'question':
            '¿Cuál es la dosis correcta de sacaromices bulandi (perenterol) para adultos en el tratamiento de diarrea?',
        'options': [
          'a) 125 mg cada 12 horas por 3-5 días',
          'b) 250 mg cada 12 horas por 3-5 días',
          'c) 500 mg cada 24 horas por 3-5 días',
          'd) 250 mg cada 8 horas por 3-5 días'
        ],
        'correctAnswer': 'b) 250 mg cada 12 horas por 3-5 días',
        'explanation':
            'Según lo explicado en clase, la dosis correcta para adultos de sacaromices bulandi (perenterol) es de 250 mg cada 12 horas durante un período de 3 a 5 días. Esta dosificación es importante para mantener niveles adecuados del probiótico en el sistema digestivo y lograr el efecto terapéutico deseado en el control de la diarrea.'
      },
      {
        'type': 'simple',
        'question':
            '¿Qué precaución especial debe tenerse al administrar probióticos como el perenterol?',
        'options': [
          'a) Debe tomarse con el estómago lleno',
          'b) No debe administrarse con líquidos calientes',
          'c) Debe tomarse inmediatamente antes de las comidas',
          'd) Debe administrarse con leche exclusivamente'
        ],
        'correctAnswer': 'b) No debe administrarse con líquidos calientes',
        'explanation':
            'Como se explicó en clase, los probióticos contienen microorganismos vivos, por lo que no deben administrarse con líquidos calientes ya que el calor puede matar estos microorganismos y hacer que el medicamento pierda su eficacia. Por esta razón, debe esperarse al menos una hora después de ingerir bebidas calientes para tomar el medicamento.'
      },
      {
        'type': 'simple',
        'question':
            '¿Cuál es la dosis máxima diaria de paracetamol permitida en adultos?',
        'options': ['a) 2 gramos', 'b) 3 gramos', 'c) 4 gramos', 'd) 5 gramos'],
        'correctAnswer': 'c) 4 gramos',
        'explanation':
            'Como se explicó en clase, la dosis máxima diaria de paracetamol en adultos es de 4 gramos (4000 mg). Esta limitación es crucial para prevenir la toxicidad hepática, ya que dosis superiores pueden causar daño hepático severo. Es importante no exceder esta dosis máxima incluso cuando se usan diferentes presentaciones del medicamento.'
      },
      {
        'type': 'simple',
        'question':
            '¿Cuál es la dosis correcta de metamizol (dipirona) para adultos?',
        'options': [
          'a) 100 mg de una a tres veces al día',
          'b) 200 mg de una a tres veces al día',
          'c) 300 mg de una a tres veces al día',
          'd) 400 mg de una a tres veces al día'
        ],
        'correctAnswer': 'c) 300 mg de una a tres veces al día',
        'explanation':
            'Según lo explicado en clase, la dosis correcta de metamizol (dipirona) para adultos es de 300 mg de una a tres veces al día, sin superar los 3 gramos diarios como máximo. Esta dosificación es importante para mantener la eficacia analgésica y antipirética mientras se minimiza el riesgo de efectos adversos.'
      },
      {
        'type': 'simple',
        'question':
            '¿Qué característica define al estreñimiento según lo explicado en clase?',
        'options': [
          'a) Menos de una evacuación por semana',
          'b) Menos de tres evacuaciones por semana',
          'c) Heces muy duras ocasionalmente',
          'd) Cualquier dificultad para evacuar'
        ],
        'correctAnswer': 'b) Menos de tres evacuaciones por semana',
        'explanation':
            'En la clase se definió específicamente el estreñimiento como la condición en la que una persona tiene menos de tres evacuaciones en una semana, con heces de consistencia más dura y seca. Esta definición es importante para distinguir el estreñimiento de otras alteraciones del tránsito intestinal.'
      },
      {
        'type': 'simple',
        'question':
            '¿Cuál es la dosis pediátrica correcta de paracetamol para niños entre 6 y 8 años?',
        'options': [
          'a) 160 mg cada 6-8 horas',
          'b) 240 mg cada 6-8 horas',
          'c) 320 mg cada 6-8 horas',
          'd) 480 mg cada 6-8 horas'
        ],
        'correctAnswer': 'c) 320 mg cada 6-8 horas',
        'explanation':
            'Según la tabla presentada en clase, para niños entre 6 y 8 años, la dosis correcta de paracetamol es de 320 mg cada 6-8 horas, sin exceder los 1650 mg diarios. Esta dosificación está ajustada al peso promedio de los niños en este rango de edad.'
      },
      {
        'type': 'simple',
        'question':
            '¿Cuál es el tiempo máximo recomendado de uso continuo para el bismuto subsalicilato?',
        'options': [
          'a) No más de 1 día',
          'b) No más de 2 días',
          'c) No más de 3 días',
          'd) No más de 5 días'
        ],
        'correctAnswer': 'b) No más de 2 días',
        'explanation':
            'Según lo explicado en clase, el bismuto subsalicilato nunca debe utilizarse por más de dos días seguidos. Esta restricción es importante para evitar efectos adversos y asegurar que condiciones más serias no queden sin diagnóstico adecuado.'
      },
      {
        'type': 'simple',
        'question':
            '¿Cuál es la dosis correcta de hidróxido de aluminio para adultos?',
        'options': [
          'a) 100-200 mg tres veces al día',
          'b) 200-400 mg tres veces al día',
          'c) 400-600 mg tres veces al día',
          'd) 600-800 mg tres veces al día'
        ],
        'correctAnswer': 'b) 200-400 mg tres veces al día',
        'explanation':
            'La clase especificó que la dosis correcta de hidróxido de aluminio para adultos es de 200-400 mg tres veces al día, disponible en forma de suspensión o comprimidos masticables.'
      },
      {
        'type': 'simple',
        'question':
            '¿Qué se define como fiebre cuando se mide la temperatura vía rectal?',
        'options': [
          'a) Temperatura mayor a 37°C',
          'b) Temperatura mayor a 37.5°C',
          'c) Temperatura mayor a 38°C',
          'd) Temperatura mayor a 38.5°C'
        ],
        'correctAnswer': 'c) Temperatura mayor a 38°C',
        'explanation':
            'En la clase se especificó que cuando la temperatura se toma vía rectal, se considera fiebre cuando es mayor a 38°C, siendo este un punto de referencia diferente al de la medición axilar u oral.'
      },
      {
        'type': 'simple',
        'question':
            '¿Cuál es la dosis máxima diaria de ibuprofeno permitida en adultos?',
        'options': ['a) 800 mg', 'b) 1000 mg', 'c) 1200 mg', 'd) 1600 mg'],
        'correctAnswer': 'b) 1000 mg',
        'explanation':
            'Según lo explicado en clase, la dosis máxima diaria de ibuprofeno en adultos es de 1000 mg. Esta dosis se calcula considerando la administración de 200 mg cada 4-6 horas.'
      },
      {
        'type': 'simple',
        'question':
            '¿Cuál es la dosis pediátrica de ibuprofeno para niños mayores de 6 meses?',
        'options': [
          'a) 2-5 mg/kg cada 8 horas',
          'b) 5-10 mg/kg cada 8 horas',
          'c) 10-15 mg/kg cada 8 horas',
          'd) 15-20 mg/kg cada 8 horas'
        ],
        'correctAnswer': 'b) 5-10 mg/kg cada 8 horas',
        'explanation':
            'La clase especificó que para niños mayores de 6 meses, la dosis de ibuprofeno es de 5-10 mg por kilogramo de peso cada 8 horas, con un máximo de 40 mg/kg/día.'
      },
      {
        'type': 'simple',
        'question':
            '¿Cuál es la dosis recomendada de pancreatina con simeticona para adultos?',
        'options': [
          'a) 30-60 mg simeticona y 200-400 mg pancreatina, máximo 4 veces al día',
          'b) 60-125 mg simeticona y 400-800 mg pancreatina, máximo 4 veces al día',
          'c) 125-250 mg simeticona y 800-1200 mg pancreatina, máximo 4 veces al día',
          'd) 250-500 mg simeticona y 1200-1600 mg pancreatina, máximo 4 veces al día'
        ],
        'correctAnswer':
            'b) 60-125 mg simeticona y 400-800 mg pancreatina, máximo 4 veces al día',
        'explanation':
            'Según lo explicado en clase, la dosis correcta para adultos es de 60-125 mg de simeticona y 400-800 mg de pancreatina, administrada hasta cuatro veces al día como máximo.'
      },
      {
        'type': 'simple',
        'question':
            '¿Cuál es la dosis máxima diaria de sulfaguanidina para infecciones intestinales leves?',
        'options': [
          'a) Una tableta 2 veces al día',
          'b) Una tableta 3 veces al día',
          'c) Una tableta 4 veces al día',
          'd) Una tableta 6 veces al día'
        ],
        'correctAnswer': 'c) Una tableta 4 veces al día',
        'explanation':
            'La clase especificó que la sulfaguanidina se usa en dosis de una tableta (que contiene 125 mg de carbón activado y 127 mg de sulfa) de tres a cuatro veces al día como máximo.'
      },
      {
        'type': 'simple',
        'question':
            '¿Qué temperatura indica fiebre cuando se mide vía oral o axilar?',
        'options': [
          'a) Mayor a 37.0°C',
          'b) Mayor a 37.5°C',
          'c) Mayor a 38.0°C',
          'd) Mayor a 38.5°C'
        ],
        'correctAnswer': 'b) Mayor a 37.5°C',
        'explanation':
            'En la clase se explicó que tanto para la medición oral como axilar, se considera fiebre cuando la temperatura es superior a 37.5°C.'
      },
      {
        'type': 'simple',
        'question':
            '¿Qué dosis de diclofenaco tópico se recomienda para adultos?',
        'options': [
          'a) Una aplicación diaria',
          'b) Dos aplicaciones diarias',
          'c) Tres a cuatro aplicaciones diarias',
          'd) Cinco aplicaciones diarias'
        ],
        'correctAnswer': 'c) Tres a cuatro aplicaciones diarias',
        'explanation':
            'Según lo explicado en clase, el diclofenaco tópico debe aplicarse de tres a cuatro veces al día con un masaje suave cubriendo la zona afectada.'
      },
      {
        'type': 'simple',
        'question':
            '¿Cuál es la dosis de ácido acetilsalicílico para dolor e inflamación leve a moderada?',
        'options': [
          'a) 325-650 mg cada 4 horas',
          'b) 500-1000 mg cada 6 horas',
          'c) 650-1000 mg cada 8 horas',
          'd) 1000-1500 mg cada 12 horas'
        ],
        'correctAnswer': 'a) 325-650 mg cada 4 horas',
        'explanation':
            'La clase indicó que la dosis de ácido acetilsalicílico para dolor e inflamación leve a moderada es de 325-650 mg cada 4 horas.'
      },
      {
        'type': 'simple',
        'question':
            '¿Cuál es la dosis de aloe ferox para el tratamiento del estreñimiento ocasional?',
        'options': [
          'a) 100 mg al día',
          'b) 150 mg al día',
          'c) 200 mg al día',
          'd) 250 mg al día'
        ],
        'correctAnswer': 'b) 150 mg al día',
        'explanation':
            'Según lo explicado en clase, la dosis de aloe ferox para el tratamiento del estreñimiento ocasional es de 150 mg al día, preferentemente antes de acostarse.'
      },
      {
        'type': 'simple',
        'question':
            '¿Cuál es la dosis máxima diaria de bismuto subsalicilato en suspensión?',
        'options': [
          'a) Cuatro dosis en 24 horas',
          'b) Seis dosis en 24 horas',
          'c) Ocho dosis en 24 horas',
          'd) Diez dosis en 24 horas'
        ],
        'correctAnswer': 'c) Ocho dosis en 24 horas',
        'explanation':
            'La clase especificó que para la suspensión de bismuto subsalicilato, la dosis máxima es de ocho dosis (dos cucharadas cada vez) en 24 horas.'
      },
      {
        'type': 'simple',
        'question': '¿Cuál es la dosis de metamizol para niños?',
        'options': [
          'a) 5-15 mg/kg/día',
          'b) 7-25 mg/kg/día',
          'c) 25-35 mg/kg/día',
          'd) 35-45 mg/kg/día'
        ],
        'correctAnswer': 'b) 7-25 mg/kg/día',
        'explanation':
            'Según la clase, la dosis pediátrica de metamizol es de 7-25 mg por kilo de peso al día, sin superar los 40 mg por kilo de peso al día como máximo.'
      },
      {
        'type': 'simple',
        'question':
            '¿Cuál es el intervalo mínimo entre dosis de paracetamol en adultos?',
        'options': ['a) 2 horas', 'b) 3 horas', 'c) 4 horas', 'd) 6 horas'],
        'correctAnswer': 'c) 4 horas',
        'explanation':
            'En la clase se especificó que el intervalo mínimo entre dosis de paracetamol debe ser de al menos 4 horas.'
      },
      {
        'type': 'simple',
        'question': '¿Qué dosis de ketoprofeno tópico se recomienda al día?',
        'options': [
          'a) Una aplicación diaria',
          'b) Una a dos aplicaciones diarias',
          'c) Una a tres aplicaciones diarias',
          'd) Dos a cuatro aplicaciones diarias'
        ],
        'correctAnswer': 'c) Una a tres aplicaciones diarias',
        'explanation':
            'Según lo explicado en clase, el ketoprofeno tópico debe aplicarse de una a tres veces al día en la zona afectada.'
      },
      {
        'type': 'simple',
        'question':
            '¿Cuál es la dosis de naproxeno sódico para el tratamiento inicial de la gota?',
        'options': [
          'a) 500 mg dosis inicial',
          'b) 750 mg dosis inicial',
          'c) 1000 mg dosis inicial',
          'd) 1250 mg dosis inicial'
        ],
        'correctAnswer': 'b) 750 mg dosis inicial',
        'explanation':
            'La clase indicó que para el tratamiento de la gota, se utiliza una dosis inicial de 750 mg de naproxeno sódico, seguida de 250 mg cada 8 horas hasta el alivio de los síntomas.'
      },

      // ****************************************************************************************

      // ****************************************************************************************

      // ****************************************************************************************

      {
        'type': 'complex',
        'question':
            'Respecto a los efectos adversos del ibuprofeno, ¿cuáles afirmaciones son correctas?',
        'solutions': [
          'I) Puede interferir con la coagulación sanguínea',
          'II) Puede causar problemas gastrointestinales',
          'III) No presenta interacciones con otros medicamentos',
          'IV) Debe evitarse cerca de procedimientos quirúrgicos'
        ],
        'options': [
          'a) Solo I y II son correctas',
          'b) Solo I, II y IV son correctas',
          'c) Solo II y III son correctas',
          'd) Todas son correctas'
        ],
        'correctAnswer': 'b) Solo I, II y IV son correctas',
        'explanation':
            'La clase explicó que el ibuprofeno puede interferir con la coagulación (I), causar problemas gastrointestinales (II) y debe evitarse cerca de cirugías (IV). La afirmación III es incorrecta porque sí presenta interacciones con otros medicamentos.'
      },
      {
        'type': 'complex',
        'question':
            'Sobre el uso del carbón activado, ¿cuáles afirmaciones son correctas?',
        'solutions': [
          'I) Actúa como una esponja absorbiendo excesos de líquido',
          'II) Puede tomarse junto con otros medicamentos',
          'III) Requiere abundante hidratación durante el tratamiento',
          'IV) Puede causar ennegrecimiento de las heces'
        ],
        'options': [
          'a) Solo I y II son correctas',
          'b) Solo I, III y IV son correctas',
          'c) Solo II y III son correctas',
          'd) Todas son correctas'
        ],
        'correctAnswer': 'b) Solo I, III y IV son correctas',
        'explanation':
            'El carbón activado actúa como esponja (I), requiere hidratación (III) y puede ennegrecer las heces (IV). La afirmación II es incorrecta porque no debe tomarse junto con otros medicamentos ya que puede absorberlos.'
      },
      {
        'type': 'complex',
        'question':
            'Sobre las vitaminas esenciales, ¿cuáles afirmaciones son correctas?',
        'solutions': [
          'I) El organismo necesita 13 vitaminas esenciales',
          'II) Todas se obtienen a través de la dieta',
          'III) Las vitaminas del complejo B son hidrosolubles',
          'IV) Las vitaminas liposolubles son menos tóxicas'
        ],
        'options': [
          'a) Solo I y II son correctas',
          'b) Solo I, II y III son correctas',
          'c) Solo II y III son correctas',
          'd) Todas son correctas'
        ],
        'correctAnswer': 'b) Solo I, II y III son correctas',
        'explanation':
            'La clase explicó que el organismo necesita 13 vitaminas esenciales (I), se obtienen a través de la dieta (II) y las vitaminas del complejo B son hidrosolubles (III). La afirmación IV es incorrecta porque las vitaminas liposolubles tienen mayor tendencia a la toxicidad.'
      },
      {
        'type': 'complex',
        'question':
            'Respecto al uso de la pancreatina con simeticona, ¿cuáles afirmaciones son correctas?',
        'solutions': [
          'I) Ayuda a mejorar el proceso digestivo',
          'II) Facilita la eliminación de gases',
          'III) No presenta efectos adversos',
          'IV) Puede causar náuseas y diarrea'
        ],
        'options': [
          'a) Solo I y II son correctas',
          'b) Solo I, II y IV son correctas',
          'c) Solo II y III son correctas',
          'd) Todas son correctas'
        ],
        'correctAnswer': 'b) Solo I, II y IV son correctas',
        'explanation':
            'Según la clase, la pancreatina con simeticona ayuda al proceso digestivo (I), facilita la eliminación de gases (II) y puede causar náuseas y diarrea (IV). La afirmación III es incorrecta porque sí presenta efectos adversos.'
      },
      {
        'type': 'complex',
        'question':
            'Sobre los minerales esenciales, ¿cuáles afirmaciones son correctas?',
        'solutions': [
          'I) El calcio y fósforo son macrominerales',
          'II) El hierro es un oligoelemento',
          'III) Todos los minerales son macrominerales',
          'IV) Son necesarios para procesos enzimáticos'
        ],
        'options': [
          'a) Solo I y II son correctas',
          'b) Solo I, II y IV son correctas',
          'c) Solo II y III son correctas',
          'd) Todas son correctas'
        ],
        'correctAnswer': 'b) Solo I, II y IV son correctas',
        'explanation':
            'La clase indicó que el calcio y fósforo son macrominerales (I), el hierro es un oligoelemento (II) y son necesarios para procesos enzimáticos (IV). La afirmación III es incorrecta porque existen tanto macrominerales como oligoelementos.'
      },
      {
        'type': 'complex',
        'question':
            'Sobre la acidez estomacal, ¿cuáles afirmaciones son correctas?',
        'solutions': [
          'I) Es una sensación de ardor en pecho o garganta',
          'II) Ocurre por reflujo del ácido estomacal',
          'III) Siempre requiere tratamiento prolongado',
          'IV) Los antiácidos proporcionan alivio temporal'
        ],
        'options': [
          'a) Solo I y II son correctas',
          'b) Solo I, II y IV son correctas',
          'c) Solo II y III son correctas',
          'd) Todas son correctas'
        ],
        'correctAnswer': 'b) Solo I, II y IV son correctas',
        'explanation':
            'La clase explicó que la acidez es una sensación de ardor (I), ocurre por reflujo del ácido estomacal (II) y los antiácidos dan alivio temporal (IV). La afirmación III es incorrecta porque no siempre requiere tratamiento prolongado.'
      },
      {
        'type': 'complex',
        'question':
            'Sobre el uso de ketoprofeno tópico, ¿cuáles afirmaciones son correctas?',
        'solutions': [
          'I) Se aplica en zonas con dolor localizado',
          'II) No debe aplicarse sobre heridas abiertas',
          'III) Se puede exponer al sol después de aplicarlo',
          'IV) Requiere un vendaje oclusivo siempre'
        ],
        'options': [
          'a) Solo I y II son correctas',
          'b) Solo I, II y IV son correctas',
          'c) Solo II y III son correctas',
          'd) Todas son correctas'
        ],
        'correctAnswer': 'a) Solo I y II son correctas',
        'explanation':
            'Según la clase, el ketoprofeno tópico se aplica en zonas con dolor localizado (I) y no debe aplicarse sobre heridas abiertas (II). Las afirmaciones III y IV son incorrectas porque no se debe exponer al sol y el vendaje oclusivo no siempre es necesario.'
      },
      {
        'type': 'complex',
        'question':
            'Respecto al uso de la sacaromices bulandi, ¿cuáles afirmaciones son correctas?',
        'solutions': [
          'I) Se usa para desbalance de flora intestinal',
          'II) La dosis es de 250 mg cada 12 horas',
          'III) El tratamiento dura entre 3 y 5 días',
          'IV) Se puede tomar con bebidas calientes'
        ],
        'options': [
          'a) Solo I y II son correctas',
          'b) Solo I, II y III son correctas',
          'c) Solo II y III son correctas',
          'd) Todas son correctas'
        ],
        'correctAnswer': 'b) Solo I, II y III son correctas',
        'explanation':
            'La clase indicó que se usa para desbalance de flora intestinal (I), la dosis es 250 mg cada 12 horas (II) y el tratamiento dura 3-5 días (III). La afirmación IV es incorrecta porque no debe tomarse con bebidas calientes.'
      },
      {
        'type': 'complex',
        'question':
            'Sobre el cálculo de dosis pediátricas de paracetamol, ¿cuáles afirmaciones son correctas?',
        'solutions': [
          'I) Se ajusta según peso y edad del niño',
          'II) Niños de 2-3 años usan 160 mg cada 6-8 horas',
          'III) La dosis máxima es igual para todas las edades',
          'IV) Niños de 11-12 años usan 480 mg por dosis'
        ],
        'options': [
          'a) Solo I y II son correctas',
          'b) Solo I, II y IV son correctas',
          'c) Solo II y III son correctas',
          'd) Todas son correctas'
        ],
        'correctAnswer': 'b) Solo I, II y IV son correctas',
        'explanation':
            'Se explicó que la dosis se ajusta por peso y edad (I), niños de 2-3 años usan 160 mg cada 6-8 horas (II) y niños de 11-12 años usan 480 mg por dosis (IV). La afirmación III es incorrecta porque la dosis máxima varía según edad y peso.'
      },
      {
        'type': 'complex',
        'question':
            'Sobre el manejo de la fiebre, ¿cuáles afirmaciones son correctas?',
        'solutions': [
          'I) Es un mecanismo de defensa del organismo',
          'II) Ayuda a inactivar microorganismos por calor',
          'III) Siempre debe tratarse inmediatamente',
          'IV) Los puntos de corte varían según el sitio de medición'
        ],
        'options': [
          'a) Solo I y II son correctas',
          'b) Solo I, II y IV son correctas',
          'c) Solo II y III son correctas',
          'd) Todas son correctas'
        ],
        'correctAnswer': 'b) Solo I, II y IV son correctas',
        'explanation':
            'La clase explicó que la fiebre es un mecanismo de defensa (I), inactiva microorganismos por calor (II) y los puntos de corte varían según el sitio de medición (IV). La afirmación III es incorrecta porque no siempre requiere tratamiento inmediato.'
      },
      {
        'type': 'complex',
        'question':
            'Sobre los efectos adversos de los antiácidos, ¿cuáles afirmaciones son correctas?',
        'solutions': [
          'I) Pueden causar alteraciones en el ritmo cardíaco',
          'II) Pueden producir pérdida del apetito',
          'III) No presentan riesgos en uso prolongado',
          'IV) Pueden causar constipación'
        ],
        'options': [
          'a) Solo I y II son correctas',
          'b) Solo I, II y IV son correctas',
          'c) Solo II y III son correctas',
          'd) Todas son correctas'
        ],
        'correctAnswer': 'b) Solo I, II y IV son correctas',
        'explanation':
            'Se explicó que los antiácidos pueden causar alteraciones del ritmo cardíaco (I), pérdida del apetito (II) y constipación (IV). La afirmación III es incorrecta porque sí presentan riesgos en uso prolongado.'
      },
      {
        'type': 'complex',
        'question':
            'Sobre el naproxeno sódico, ¿cuáles afirmaciones son correctas?',
        'solutions': [
          'I) Se usa para afecciones reumáticas',
          'II) La dosis para gota es mayor inicialmente',
          'III) Se puede usar sin restricciones antes de cirugías',
          'IV) Puede causar fotosensibilidad'
        ],
        'options': [
          'a) Solo I y II son correctas',
          'b) Solo I, II y IV son correctas',
          'c) Solo II y III son correctas',
          'd) Todas son correctas'
        ],
        'correctAnswer': 'b) Solo I, II y IV son correctas',
        'explanation':
            'La clase indicó que el naproxeno se usa para afecciones reumáticas (I), tiene una dosis inicial mayor para gota (II) y puede causar fotosensibilidad (IV). La afirmación III es incorrecta porque no debe usarse antes de cirugías.'
      },
      {
        'type': 'complex',
        'question':
            'Sobre los efectos del metamizol, ¿cuáles afirmaciones son correctas?',
        'solutions': [
          'I) Es efectivo para dolores en mucosas',
          'II) Es útil para dolor premenstrual',
          'III) No tiene contraindicaciones',
          'IV) Puede causar hipotensión por vía parenteral'
        ],
        'options': [
          'a) Solo I y II son correctas',
          'b) Solo I, II y IV son correctas',
          'c) Solo II y III son correctas',
          'd) Todas son correctas'
        ],
        'correctAnswer': 'b) Solo I, II y IV son correctas',
        'explanation':
            'Se explicó que el metamizol es efectivo para dolores en mucosas (I), útil para dolor premenstrual (II) y puede causar hipotensión por vía parenteral (IV). La afirmación III es incorrecta porque sí tiene contraindicaciones.'
      },
      {
        'type': 'complex',
        'question':
            'Respecto al uso de antiácidos con bicarbonato, ¿qué afirmaciones son correctas?',
        'solutions': [
          'I) La dosis va de 325 mg a 2g de bicarbonato',
          'II) Se puede usar junto con 1g de ácido cítrico',
          'III) Se pueden usar por tiempo indefinido',
          'IV) Pueden causar aumento en la frecuencia urinaria'
        ],
        'options': [
          'a) Solo I y II son correctas',
          'b) Solo I, II y IV son correctas',
          'c) Solo II y III son correctas',
          'd) Todas son correctas'
        ],
        'correctAnswer': 'b) Solo I, II y IV son correctas',
        'explanation':
            'La clase indicó que la dosis de bicarbonato va de 325 mg a 2g (I), se usa con 1g de ácido cítrico (II), y puede causar aumento en la frecuencia urinaria (IV). La afirmación III es incorrecta porque se especificó que los antiácidos no deben usarse por tiempo prolongado.'
      },
      {
        'type': 'complex',
        'question':
            'Sobre los efectos adversos del paracetamol, ¿cuáles afirmaciones son correctas?',
        'solutions': [
          'I) Puede causar daño hepático en uso prolongado',
          'II) Puede provocar reacciones alérgicas cutáneas',
          'III) Puede causar coloración amarilla en piel y ojos',
          'IV) No presenta efectos adversos en dosis terapéuticas'
        ],
        'options': [
          'a) Solo I y II son correctas',
          'b) Solo I, II y III son correctas',
          'c) Solo II y III son correctas',
          'd) Todas son correctas'
        ],
        'correctAnswer': 'b) Solo I, II y III son correctas',
        'explanation':
            'Según la clase, el paracetamol puede causar daño hepático en uso prolongado (I), provocar reacciones alérgicas cutáneas (II) y causar ictericia (coloración amarilla) en piel y ojos como signo de daño hepático (III). La afirmación IV es incorrecta porque incluso en dosis terapéuticas pueden presentarse efectos adversos.'
      },
      {
        'type': 'complex',
        'question':
            'Sobre el uso de probióticos como la sacaromices bulandi, ¿qué afirmaciones son correctas?',
        'solutions': [
          'I) Se debe administrar con líquidos a temperatura ambiente',
          'II) Puede causar hipocalemia en casos extremos',
          'III) Se puede tomar junto con el desayuno caliente',
          'IV) Debe esperarse una hora después de las comidas'
        ],
        'options': [
          'a) Solo I y II son correctas',
          'b) Solo I, II y IV son correctas',
          'c) Solo II y III son correctas',
          'd) Todas son correctas'
        ],
        'correctAnswer': 'b) Solo I, II y IV son correctas',
        'explanation':
            'Como se explicó en clase, los probióticos deben administrarse con líquidos a temperatura ambiente (I), pueden causar hipocalemia en casos extremos (II), y debe esperarse una hora después de las comidas (IV). La afirmación III es incorrecta porque el calor mata los microorganismos activos.'
      },
      {
        'type': 'complex',
        'question':
            'Respecto al uso de antiácidos, ¿cuáles de las siguientes afirmaciones son correctas?',
        'solutions': [
          'I) Neutralizan el ácido del estómago proporcionando alivio a corto plazo',
          'II) Se pueden usar de forma prolongada sin supervisión médica',
          'III) Pueden producir úlceras pépticas como efecto adverso',
          'IV) La persistencia de acidez podría indicar presencia de úlcera'
        ],
        'options': [
          'a) Solo I y II son correctas',
          'b) Solo I y IV son correctas',
          'c) Solo II y III son correctas',
          'd) Todas son correctas'
        ],
        'correctAnswer': 'b) Solo I y IV son correctas',
        'explanation':
            'Las afirmaciones I y IV son las únicas correctas según lo explicado en clase. Los antiácidos efectivamente neutralizan el ácido estomacal proporcionando alivio temporal (I), y la persistencia de acidez puede ser indicador de úlcera que requiere revisión médica (IV). La afirmación II es incorrecta porque se explicó específicamente que los antiácidos no deben usarse por tiempos prolongados. La afirmación III también es incorrecta porque los antiácidos no producen úlceras, aunque su uso prolongado puede causar otros efectos adversos.'
      },
      {
        'type': 'complex',
        'question':
            'Sobre el subsalicilato de bismuto, ¿cuáles de las siguientes afirmaciones son verdaderas?',
        'solutions': [
          'I) Se utiliza tanto como antidiarreico como antiácido',
          'II) En tabletas se pueden tomar hasta 2 comprimidos cada media hora',
          'III) Puede causar ennegrecimiento temporal de la lengua y las heces',
          'IV) Se puede usar sin restricciones por más de dos días'
        ],
        'options': [
          'a) Solo I y II son correctas',
          'b) Solo I, II y III son correctas',
          'c) Solo II y III son correctas',
          'd) Todas son correctas'
        ],
        'correctAnswer': 'b) Solo I, II y III son correctas',
        'explanation':
            'Según lo explicado en clase, el subsalicilato de bismuto tiene doble función como antidiarreico y antiácido (I), su dosificación en tabletas es de hasta 2 comprimidos cada media hora a una hora (II), y puede causar ennegrecimiento temporal de lengua y heces que no debe confundirse con melena (III). La afirmación IV es incorrecta porque se especificó que nunca debe utilizarse por más de dos días seguidos.'
      },
      {
        'type': 'complex',
        'question':
            'Respecto al aloe ferox como laxante, ¿cuáles de las siguientes afirmaciones son correctas?',
        'solutions': [
          'I) La dosis recomendada en adultos es de 150 mg al día',
          'II) Se recomienda tomarlo antes de acostarse',
          'III) En dosis altas puede causar pérdida permanente de la función intestinal',
          'IV) Puede causar hipocalemia como efecto adverso'
        ],
        'options': [
          'a) Solo I y II son correctas',
          'b) Solo I, II y IV son correctas',
          'c) Solo II y III son correctas',
          'd) Todas son correctas'
        ],
        'correctAnswer': 'b) Solo I, II y IV son correctas',
        'explanation':
            'Según la clase, el aloe ferox tiene una dosis recomendada de 150 mg al día (I), se debe tomar preferentemente antes de acostarse para que actúe durante la noche (II), y puede causar hipocalemia como efecto adverso (IV). La afirmación III es incorrecta porque se especificó que incluso en dosis altas no se pierde la función normal del intestino.'
      },
      {
        'type': 'complex',
        'question':
            'Sobre la fiebre y su medición, ¿cuáles de las siguientes afirmaciones son verdaderas?',
        'solutions': [
          'I) Se considera fiebre cuando la temperatura rectal es mayor a 38°C',
          'II) La temperatura axilar mayor a 37.5°C indica fiebre',
          'III) La fiebre es un mecanismo de defensa del organismo',
          'IV) La temperatura oral y axilar tienen el mismo punto de corte para determinar fiebre'
        ],
        'options': [
          'a) Solo I y II son correctas',
          'b) Solo I, II y III son correctas',
          'c) Solo II y III son correctas',
          'd) Todas son correctas'
        ],
        'correctAnswer': 'd) Todas son correctas',
        'explanation':
            'Todas las afirmaciones son correctas según lo explicado en clase. La fiebre se define como temperatura rectal mayor a 38°C (I), temperatura axilar mayor a 37.5°C (II), es un mecanismo de defensa que ayuda a eliminar microorganismos (III), y tanto la temperatura oral como axilar tienen el mismo punto de corte de 37.5°C para determinar fiebre (IV).'
      },

      {
        'type': 'complex',
        'question':
            'Sobre los antiinflamatorios no esteroidales (AINES), ¿cuáles afirmaciones son correctas?',
        'solutions': [
          'I) Interfieren con los procesos de coagulación',
          'II) Se pueden usar sin restricción antes de cirugías',
          'III) Pueden causar problemas gastrointestinales',
          'IV) Su uso prolongado puede generar úlceras'
        ],
        'options': [
          'a) Solo I y II son correctas',
          'b) Solo I, III y IV son correctas',
          'c) Solo II y III son correctas',
          'd) Todas son correctas'
        ],
        'correctAnswer': 'b) Solo I, III y IV son correctas',
        'explanation':
            'De acuerdo a lo explicado en clase, los AINES interfieren con la coagulación (I), pueden causar problemas gastrointestinales (III) y su uso prolongado puede generar úlceras (IV). La afirmación II es incorrecta porque precisamente por su efecto en la coagulación, no deben usarse antes de procedimientos quirúrgicos.'
      },
      {
        'type': 'complex',
        'question':
            'Sobre el uso de vitaminas y minerales, ¿cuáles afirmaciones son correctas?',
        'solutions': [
          'I) El organismo necesita 13 vitaminas esenciales',
          'II) Todas las vitaminas son hidrosolubles',
          'III) Las vitaminas liposolubles pueden acumularse en el organismo',
          'IV) Una dieta balanceada proporciona todas las vitaminas necesarias'
        ],
        'options': [
          'a) Solo I y II son correctas',
          'b) Solo I, III y IV son correctas',
          'c) Solo II y III son correctas',
          'd) Todas son correctas'
        ],
        'correctAnswer': 'b) Solo I, III y IV son correctas',
        'explanation':
            'La clase explicó que el organismo necesita 13 vitaminas esenciales (I), las vitaminas liposolubles se acumulan en el tejido graso (III), y una dieta balanceada proporciona todas las vitaminas necesarias (IV). La afirmación II es incorrecta porque existen tanto vitaminas hidrosolubles como liposolubles.'
      },
    ],
    'Clase Repaso': [
      // Preguntas de Clase Repaso...
      {
        'type': 'simple',
        'question':
            '¿Qué establecimientos están habilitados para el expendio y/o dispensación de productos farmacéuticos?',
        'options': [
          'a) Solo farmacias',
          'b) Farmacias y almacenes farmacéuticos',
          'c) Farmacias, botiquines y almacenes farmacéuticos',
          'd) Farmacias, droguerías y almacenes farmacéuticos'
        ],
        'correctAnswer': 'c) Farmacias, botiquines y almacenes farmacéuticos',
        'explanation':
            'Los establecimientos farmacéuticos habilitados para el expendio y/o dispensación de productos farmacéuticos son farmacias, botiquines y almacenes farmacéuticos, según se establece en la normativa vigente. Cada uno tiene sus propias características y limitaciones específicas para la dispensación.'
      },
      {
        'type': 'simple',
        'question':
            '¿Bajo la dirección técnica de qué profesional deben funcionar las farmacias?',
        'options': [
          'a) Químico farmacéutico',
          'b) Estudiante de farmacia en vía de titulación',
          'c) Técnico en farmacia',
          'd) Químico farmacéutico o estudiante en práctica'
        ],
        'correctAnswer': 'a) Químico farmacéutico',
        'explanation':
            'Las farmacias deben funcionar exclusivamente bajo la dirección técnica de un químico farmacéutico. No está permitido que funcionen bajo la dirección de estudiantes en vía de titulación u otros profesionales, ya que la responsabilidad técnica requiere la formación y habilitación profesional completa.'
      },
      {
        'type': 'simple',
        'question':
            '¿Qué elemento protege y conserva al envase primario de un medicamento?',
        'options': [
          'a) El blíster',
          'b) El envase secundario',
          'c) El encarte',
          'd) El empaque terciario'
        ],
        'correctAnswer': 'b) El envase secundario',
        'explanation':
            'El envase secundario es el que permite contener, proteger y conservar el envase primario. El encarte es un elemento distinto que generalmente contiene información adicional del producto, mientras que el blíster es parte del envase primario que está en contacto directo con el medicamento.'
      },
      {
        'type': 'simple',
        'question':
            '¿Qué característica define a los equivalentes farmacéuticos?',
        'options': [
          'a) Tienen los mismos excipientes',
          'b) Tienen diferente forma farmacéutica',
          'c) Contienen diferentes principios activos',
          'd) Contienen las mismas cantidades de principios activos y comparten forma farmacéutica'
        ],
        'correctAnswer':
            'd) Contienen las mismas cantidades de principios activos y comparten forma farmacéutica',
        'explanation':
            'Los equivalentes farmacéuticos son aquellos productos que contienen las mismas cantidades de principios activos, comparten la misma forma farmacéutica y vía de administración, aunque pueden tener diferentes excipientes. Un ejemplo mencionado en la clase son el Tapsin y el Trioval en sachet.'
      },
      {
        'type': 'simple',
        'question':
            '¿Cuál es el tiempo de vigencia para el expendio de una receta médica simple?',
        'options': [
          'a) 30 días',
          'b) No tiene tiempo límite',
          'c) 60 días',
          'd) 15 días'
        ],
        'correctAnswer': 'b) No tiene tiempo límite',
        'explanation':
            'La receta médica simple no tiene un tiempo límite establecido para su expendio. Solo las recetas retenidas de psicotrópicos y estupefacientes tienen una vigencia limitada de 30 días para su dispensación desde la fecha de emisión.'
      },
      {
        'type': 'simple',
        'question':
            '¿Qué profesionales están habilitados para emitir recetas médicas?',
        'options': [
          'a) Médicos, dentistas, veterinarios y enfermeras',
          'b) Médicos, dentistas, veterinarios y matronas',
          'c) Médicos, dentistas, matronas y tecnólogos médicos',
          'd) Médicos, enfermeras, matronas y veterinarios'
        ],
        'correctAnswer': 'b) Médicos, dentistas, veterinarios y matronas',
        'explanation':
            'Los profesionales habilitados para emitir recetas médicas son médicos cirujanos, dentistas, veterinarios y matronas. Las enfermeras no están autorizadas para la emisión de recetas médicas, aunque pueden realizar otras funciones dentro del ámbito de la salud.'
      },
      {
        'type': 'simple',
        'question':
            '¿Quién establece la condición de venta de un producto farmacéutico?',
        'options': [
          'a) El Instituto de Salud Pública (ISP)',
          'b) El Ministerio de Salud',
          'c) La SEREMI de Salud',
          'd) El laboratorio fabricante'
        ],
        'correctAnswer': 'a) El Instituto de Salud Pública (ISP)',
        'explanation':
            'La condición de venta de un producto farmacéutico es establecida por el Instituto de Salud Pública (ISP) y queda registrada en el registro sanitario del producto. Esta es una función exclusiva del ISP como autoridad reguladora.'
      },
      {
        'type': 'simple',
        'question':
            '¿Qué altura mínima debe existir entre el piso y los medicamentos almacenados?',
        'options': [
          'a) 5 centímetros',
          'b) 10 centímetros',
          'c) 15 centímetros',
          'd) 20 centímetros'
        ],
        'correctAnswer': 'b) 10 centímetros',
        'explanation':
            'Los medicamentos deben mantenerse a una altura mínima de 10 centímetros desde el piso, ya sea mediante estantes o reposición directa en anaqueles. Esto es para proteger los productos de la humedad y facilitar la limpieza del área de almacenamiento.'
      },
      {
        'type': 'simple',
        'question': '¿Qué define el decreto 405?',
        'options': [
          'a) Reglamento de farmacia',
          'b) Reglamento de productos psicotrópicos',
          'c) Reglamento de estupefacientes',
          'd) Reglamento de productos farmacéuticos'
        ],
        'correctAnswer': 'b) Reglamento de productos psicotrópicos',
        'explanation':
            'El decreto 405 corresponde específicamente al reglamento de productos psicotrópicos. Es importante distinguirlo del decreto 404 que regula los estupefacientes, ya que son normativas diferentes aunque relacionadas con el control de sustancias especiales.'
      },
      {
        'type': 'simple',
        'question':
            '¿Qué significa el enunciado "No a más de 25°C" en el almacenamiento de medicamentos?',
        'options': [
          'a) Entre 0° y 25°C',
          'b) Entre 8° y 25°C',
          'c) Entre 2° y 25°C',
          'd) Entre -8° y 25°C'
        ],
        'correctAnswer': 'c) Entre 2° y 25°C',
        'explanation':
            'Cuando un medicamento indica "No a más de 25°C", significa que debe almacenarse en un rango de temperatura entre 2°C y 25°C. Este rango asegura la estabilidad del producto y su correcta conservación.'
      },
      {
        'type': 'simple',
        'question': '¿Qué es una receta médica digital?',
        'options': [
          'a) Una receta generada por un sistema informático con firma electrónica',
          'b) Una fotografía o escaneo de una receta física',
          'c) Una receta enviada por correo electrónico',
          'd) Una receta escrita en computadora e impresa'
        ],
        'correctAnswer': 'b) Una fotografía o escaneo de una receta física',
        'explanation':
            'Una receta médica digital es aquella que se genera mediante una fotografía o utilizando un escáner para transformar una receta física en un archivo digital. Es importante distinguirla de una receta electrónica, que es generada directamente por un sistema informático con firma electrónica avanzada.'
      },
      {
        'type': 'simple',
        'question': '¿Qué medicamento corresponde a un antitusivo puro?',
        'options': [
          'a) Ambroxol',
          'b) Bromhexina',
          'c) Noscapina',
          'd) Hedera helix'
        ],
        'correctAnswer': 'c) Noscapina',
        'explanation':
            'La noscapina es el único antitusivo puro entre las opciones. El ambroxol y la bromhexina son mucolíticos, mientras que la hedera helix es un expectorante. Los antitusivos puros se utilizan específicamente para la tos seca donde no hay generación de flema.'
      },
      {
        'type': 'simple',
        'question': '¿Qué son los descongestionantes oftálmicos?',
        'options': [
          'a) Medicamentos que aportan lubricación al ojo',
          'b) Medicamentos para tratar infecciones oculares',
          'c) Medicamentos para controlar el enrojecimiento del ojo',
          'd) Pomadas de uso oftálmico'
        ],
        'correctAnswer':
            'c) Medicamentos para controlar el enrojecimiento del ojo',
        'explanation':
            'Los descongestionantes oftálmicos son medicamentos específicamente diseñados para controlar el enrojecimiento del ojo. No deben confundirse con lubricantes oculares o medicamentos para tratar infecciones, ya que su función principal es reducir la congestión de los vasos sanguíneos en el ojo.'
      },
      {
        'type': 'simple',
        'question':
            '¿Cuál es el medicamento de venta directa utilizado para tratar la onicomicosis?',
        'options': [
          'a) Amorolfina tópica',
          'b) Ketoconazol tópico',
          'c) Ácido undecínico',
          'd) Clotrimazol'
        ],
        'correctAnswer': 'a) Amorolfina tópica',
        'explanation':
            'La amorolfina tópica es el medicamento de venta directa indicado para el tratamiento de la onicomicosis (infección por hongos en las uñas de manos o pies). Es importante destacar que es el único de los antifúngicos mencionados que está aprobado como venta directa específicamente para esta condición.'
      },
      {
        'type': 'simple',
        'question': '¿Qué acción realizan los antiácidos?',
        'options': [
          'a) Reducen los efectos del ácido neutralizándolo',
          'b) Aumentan la liberación de moco estomacal',
          'c) Reducen la producción de ácido gástrico',
          'd) Estimulan el vaciamiento estomacal'
        ],
        'correctAnswer': 'a) Reducen los efectos del ácido neutralizándolo',
        'explanation':
            'Los antiácidos actúan reduciendo los efectos del ácido en el estómago mediante su neutralización directa. No modifican la producción de ácido ni alteran otros mecanismos fisiológicos como la liberación de moco o el vaciamiento estomacal.'
      },
      {
        'type': 'simple',
        'question':
            '¿Cuál es la principal característica de una farmacia homeopática?',
        'options': [
          'a) Vende todo tipo de productos farmacéuticos',
          'b) Vende productos homeopáticos y fitoterapéuticos y confecciona preparados homeopáticos',
          'c) Vende exclusivamente flores de Bach',
          'd) Importa y fracciona drogas a granel'
        ],
        'correctAnswer':
            'b) Vende productos homeopáticos y fitoterapéuticos y confecciona preparados homeopáticos',
        'explanation':
            'Las farmacias homeopáticas están legalmente definidas como establecimientos destinados a la venta de productos farmacéuticos homeopáticos y fitoterapéuticos, y a la confección de preparados homeopáticos de carácter oficinal. Esta es su característica distintiva principal.'
      },
      {
        'type': 'simple',
        'question':
            '¿Qué define a las formas farmacéuticas de liberación convencional?',
        'options': [
          'a) Tienen velocidad y lugar de liberación diferentes',
          'b) No están modificadas por diseño o método de fabricación',
          'c) Aumentan su velocidad de disolución con agua',
          'd) Son administradas por vía parenteral'
        ],
        'correctAnswer':
            'b) No están modificadas por diseño o método de fabricación',
        'explanation':
            'Las formas farmacéuticas de liberación convencional son aquellas en las que la liberación de la sustancia activa no está deliberadamente modificada por un diseño de formulación particular ni por un método de fabricación especial. Esta es su característica definitoria principal.'
      },
      {
        'type': 'simple',
        'question':
            '¿Qué caracteriza a los productos farmacéuticos de venta directa?',
        'options': [
          'a) Requieren receta médica',
          'b) Son para patologías complejas',
          'c) No requieren receta médica y son para patologías reconocibles',
          'd) Solo se pueden vender en farmacias de cadena'
        ],
        'correctAnswer':
            'c) No requieren receta médica y son para patologías reconocibles',
        'explanation':
            'Los productos farmacéuticos de venta directa se caracterizan por no requerir receta médica para su adquisición y estar destinados para tratar patologías fácilmente reconocibles por el usuario. Esta condición está establecida por el Instituto de Salud Pública en el registro sanitario del producto.'
      },
      {
        'type': 'simple',
        'question': '¿Qué define a las droguerías?',
        'options': [
          'a) Venden medicamentos directamente a pacientes',
          'b) Abastecen solo a hospitales',
          'c) Importan, fraccionan y distribuyen drogas a granel',
          'd) Están dirigidas por médicos cirujanos'
        ],
        'correctAnswer':
            'c) Importan, fraccionan y distribuyen drogas a granel',
        'explanation':
            'Las droguerías son establecimientos destinados a la importación, fraccionamiento, distribución y venta de drogas a granel y sustancias químicas. No están autorizadas para la venta directa a pacientes y tienen funciones específicas en la cadena de distribución farmacéutica.'
      },
      {
        'type': 'simple',
        'question':
            '¿Qué acción debe tomar un auxiliar de farmacia si un paciente solicita un medicamento para la hipertensión sin receta?',
        'options': [
          'a) Despachar un antihipertensivo conocido',
          'b) Preguntar qué medicamento usa habitualmente',
          'c) Comunicar al químico farmacéutico',
          'd) Consultar con otros auxiliares'
        ],
        'correctAnswer': 'c) Comunicar al químico farmacéutico',
        'explanation':
            'El auxiliar de farmacia debe comunicar esta situación al químico farmacéutico para que él determine la mejor solución para el paciente. No está autorizado para tomar decisiones sobre la dispensación de medicamentos sin receta, especialmente en casos de medicamentos para condiciones crónicas como la hipertensión.'
      },

      // ****************************************************************************************

      // ****************************************************************************************

      // ****************************************************************************************

      {
        'type': 'complex',
        'question':
            'Respecto al almacenamiento de productos farmacéuticos, ¿qué condiciones son correctas?',
        'solutions': [
          'I) El área debe tener iluminación suficiente para evitar errores',
          'II) Se requiere un programa de mantenimiento y limpieza',
          'III) Solo puede ingresar personal autorizado y capacitado',
          'IV) Los medicamentos pueden almacenarse directamente en el piso'
        ],
        'options': [
          'a) Solo I, II y III son correctas',
          'b) Solo II y III son correctas',
          'c) Solo I y IV son correctas',
          'd) Todas son correctas'
        ],
        'correctAnswer': 'a) Solo I, II y III son correctas',
        'explanation':
            'El área de almacenamiento debe tener iluminación suficiente para evitar errores, requiere un programa de mantenimiento y limpieza para evitar acumulación de polvo y humedad, y solo puede ingresar personal autorizado. Los medicamentos nunca pueden almacenarse directamente en el piso, deben estar a una altura mínima de 10 cm.'
      },
      {
        'type': 'complex',
        'question':
            '¿Cuáles son características de las responsabilidades sanitarias del director técnico de una farmacia?',
        'solutions': [
          'I) Velar por el sistema de almacenamiento de productos farmacéuticos',
          'II) Adiestrar al personal auxiliar y supervisar su desempeño',
          'III) Asegurar la disponibilidad de sencillo para el funcionamiento',
          'IV) Formar auxiliares para la prescripción de medicamentos'
        ],
        'options': [
          'a) Solo I y II son correctas',
          'b) Solo II y III son correctas',
          'c) Solo III y IV son correctas',
          'd) Todas son correctas'
        ],
        'correctAnswer': 'a) Solo I y II son correctas',
        'explanation':
            'Las responsabilidades sanitarias del director técnico incluyen velar por el correcto almacenamiento de productos y adiestrar al personal. La disponibilidad de sencillo es una responsabilidad administrativa, no sanitaria, y los auxiliares no pueden ser formados para prescribir ya que no están habilitados para esta función.'
      },
      {
        'type': 'complex',
        'question':
            'Sobre los productos de venta directa, ¿qué afirmaciones son correctas?',
        'solutions': [
          'I) No requieren receta médica para su adquisición',
          'II) Tratan patologías fácilmente reconocibles',
          'III) Necesitan indicación profesional para su dispensación',
          'IV) Solo se puede dispensar una caja por producto'
        ],
        'options': [
          'a) Solo I es correcta',
          'b) Solo I y II son correctas',
          'c) Solo II y III son correctas',
          'd) Solo III y IV son correctas'
        ],
        'correctAnswer': 'b) Solo I y II son correctas',
        'explanation':
            'Los productos de venta directa no requieren receta médica y están destinados a tratar patologías fácilmente reconocibles por el usuario. No necesitan indicación profesional para su dispensación y no hay limitación en la cantidad de cajas que se pueden dispensar.'
      },
      {
        'type': 'complex',
        'question': '¿Qué características definen a una receta médica?',
        'solutions': [
          'I) Es un instrumento privado gráfico o electrónico',
          'II) Es emitida por profesionales habilitados',
          'III) Requiere evaluación previa del paciente',
          'IV) Tiene vigencia indefinida para su expendio'
        ],
        'options': [
          'a) Solo I, II y III son correctas',
          'b) Solo II y III son correctas',
          'c) Solo I y IV son correctas',
          'd) Todas son correctas'
        ],
        'correctAnswer': 'a) Solo I, II y III son correctas',
        'explanation':
            'La receta médica es un instrumento privado gráfico o electrónico, emitido por profesionales habilitados y requiere evaluación previa del paciente. La vigencia no es indefinida para todos los tipos de recetas, ya que las de psicotrópicos y estupefacientes tienen vigencia de 30 días.'
      },
      {
        'type': 'complex',
        'question':
            'Sobre los principios activos, ¿qué afirmaciones son correctas?',
        'solutions': [
          'I) Son sustancias con efecto farmacológico específico',
          'II) Pueden adquirir actividad al ser administrados',
          'III) Son todos los componentes de un medicamento',
          'IV) Son siempre sustancias sintéticas'
        ],
        'options': [
          'a) Solo I y II son correctas',
          'b) Solo II y III son correctas',
          'c) Solo III y IV son correctas',
          'd) Todas son correctas'
        ],
        'correctAnswer': 'a) Solo I y II son correctas',
        'explanation':
            'Los principios activos son sustancias con efecto farmacológico específico y algunas pueden adquirir actividad al ser administradas en el organismo. No todos los componentes de un medicamento son principios activos (existen excipientes) y pueden ser tanto naturales como sintéticos.'
      },
      {
        'type': 'complex',
        'question':
            'Sobre los medicamentos antiinflamatorios, ¿qué afirmaciones son correctas?',
        'solutions': [
          'I) Pueden interferir con los procesos de coagulación',
          'II) Son seguros para usar en cualquier paciente',
          'III) El ácido acetilsalicílico es útil para dolores musculares',
          'IV) No producen reacciones adversas graves'
        ],
        'options': [
          'a) Solo I y III son correctas',
          'b) Solo II y IV son correctas',
          'c) Solo III y IV son correctas',
          'd) Todas son correctas'
        ],
        'correctAnswer': 'a) Solo I y III son correctas',
        'explanation':
            'Los antiinflamatorios pueden interferir con los procesos de coagulación y el ácido acetilsalicílico es efectivo para dolores musculares. No son seguros para todos los pacientes y pueden producir reacciones adversas graves, especialmente en pacientes con úlceras o próximos a cirugías.'
      },
      {
        'type': 'complex',
        'question': '¿Qué aspectos son correctos sobre las farmacias?',
        'solutions': [
          'I) Venden productos farmacéuticos',
          'II) Elaboran productos oficinales y magistrales',
          'III) Realizan fraccionamiento de productos',
          'IV) Venden alimentos de uso médico'
        ],
        'options': [
          'a) Solo I y II son correctas',
          'b) Solo II y III son correctas',
          'c) Solo I, II y III son correctas',
          'd) Todas son correctas'
        ],
        'correctAnswer': 'd) Todas son correctas',
        'explanation':
            'Las farmacias están autorizadas para vender productos farmacéuticos, elaborar productos oficinales y magistrales, realizar fraccionamiento de productos farmacéuticos y vender alimentos de uso médico. Todas estas funciones están contempladas en su definición legal.'
      },
      {
        'type': 'complex',
        'question': 'Sobre los antisépticos, ¿qué afirmaciones son correctas?',
        'solutions': [
          'I) Se aplican sobre tejidos vivos',
          'II) Destruyen o inhiben microorganismos',
          'III) Son lo mismo que los desinfectantes',
          'IV) Pueden usarse en superficies inertes'
        ],
        'options': [
          'a) Solo I y II son correctas',
          'b) Solo II y III son correctas',
          'c) Solo III y IV son correctas',
          'd) Todas son correctas'
        ],
        'correctAnswer': 'a) Solo I y II son correctas',
        'explanation':
            'Los antisépticos se aplican sobre tejidos vivos y tienen la capacidad de destruir microorganismos o inhibir su reproducción. No son lo mismo que los desinfectantes y no están diseñados para usar en superficies inertes, ya que estos últimos son específicos para superficies no vivas.'
      },
      {
        'type': 'complex',
        'question':
            '¿Qué características corresponden a las vías de administración enterales?',
        'solutions': [
          'I) Incluyen la vía oral',
          'II) Incluyen la vía rectal',
          'III) Incluyen la vía intravenosa',
          'IV) No atraviesan barreras de la piel'
        ],
        'options': [
          'a) Solo I y II son correctas',
          'b) Solo I, II y IV son correctas',
          'c) Solo II y III son correctas',
          'd) Todas son correctas'
        ],
        'correctAnswer': 'b) Solo I, II y IV son correctas',
        'explanation':
            'Las vías de administración enterales incluyen la vía oral y rectal, y se caracterizan por no atravesar barreras de la piel. La vía intravenosa es una vía parenteral, no enteral, ya que atraviesa la barrera cutánea.'
      },
      {
        'type': 'complex',
        'question':
            'Sobre los cinco correctos de la dispensación, ¿qué elementos son correctos?',
        'solutions': [
          'I) Paciente correcto',
          'II) Medicamento correcto',
          'III) Dosis correcta',
          'IV) Vuelto correcto'
        ],
        'options': [
          'a) Solo I, II y III son correctas',
          'b) Solo II y III son correctas',
          'c) Solo I y IV son correctas',
          'd) Todas son correctas'
        ],
        'correctAnswer': 'a) Solo I, II y III son correctas',
        'explanation':
            'Los cinco correctos de la dispensación incluyen paciente correcto, medicamento correcto y dosis correcta, además de vía y horarios correctos (no mencionados en las soluciones). El vuelto correcto no es parte de los cinco correctos de la dispensación, ya que es un aspecto administrativo, no sanitario.'
      },
      {
        'type': 'complex',
        'question':
            '¿Qué características definen a los equivalentes farmacéuticos?',
        'solutions': [
          'I) Contienen las mismas cantidades de principios activos',
          'II) Comparten la misma forma farmacéutica',
          'III) Tienen la misma vía de administración',
          'IV) Deben tener los mismos excipientes'
        ],
        'options': [
          'a) Solo I y II son correctas',
          'b) Solo II y III son correctas',
          'c) Solo I, II y III son correctas',
          'd) Todas son correctas'
        ],
        'correctAnswer': 'c) Solo I, II y III son correctas',
        'explanation':
            'Los equivalentes farmacéuticos contienen las mismas cantidades de principios activos, comparten la misma forma farmacéutica y vía de administración. No necesitan tener los mismos excipientes, esta es una característica que los distingue.'
      },
      {
        'type': 'complex',
        'question':
            'Sobre el almacenamiento de medicamentos, ¿qué condiciones son correctas?',
        'solutions': [
          'I) Debe tener temperatura controlada',
          'II) Requiere registro de humedad',
          'III) Puede realizarse directo en el piso',
          'IV) Necesita iluminación adecuada'
        ],
        'options': [
          'a) Solo I, II y IV son correctas',
          'b) Solo II y III son correctas',
          'c) Solo I y IV son correctas',
          'd) Todas son correctas'
        ],
        'correctAnswer': 'a) Solo I, II y IV son correctas',
        'explanation':
            'El almacenamiento de medicamentos requiere temperatura controlada, registro de humedad e iluminación adecuada para evitar errores. No pueden almacenarse directamente en el piso, deben mantener una altura mínima de 10 cm sobre este.'
      },
      {
        'type': 'complex',
        'question':
            'Sobre los productos psicotrópicos, ¿qué afirmaciones son correctas?',
        'solutions': [
          'I) El alprazolam es un psicotrópico',
          'II) El clonazepam es un psicotrópico',
          'III) La morfina es un psicotrópico',
          'IV) El lorazepam es un psicotrópico'
        ],
        'options': [
          'a) Solo I y II son correctas',
          'b) Solo II y III son correctas',
          'c) Solo I, II y IV son correctas',
          'd) Todas son correctas'
        ],
        'correctAnswer': 'c) Solo I, II y IV son correctas',
        'explanation':
            'El alprazolam, clonazepam y lorazepam son medicamentos psicotrópicos. La morfina no es un psicotrópico sino un estupefaciente, por lo que está regulada por una normativa diferente (decreto 404, no 405).'
      },
      {
        'type': 'complex',
        'question':
            'Sobre la ley 20.724 (Ley de Fármacos), ¿qué afirmaciones son correctas?',
        'solutions': [
          'I) Prohíbe la publicidad de medicamentos con receta',
          'II) Regula el control sanitario de medicamentos',
          'III) Define el Formulario Nacional',
          'IV) Las faltas solo aplican al dueño de la farmacia'
        ],
        'options': [
          'a) Solo I es correcta',
          'b) Solo I y II son correctas',
          'c) Solo II y III son correctas',
          'd) Ninguna es correcta'
        ],
        'correctAnswer': 'a) Solo I es correcta',
        'explanation':
            'La ley 20.724 prohíbe la publicidad de medicamentos con receta. El control sanitario es responsabilidad del ISP, no de los SEREMIS. El Formulario Nacional no es definido por esta ley, y las faltas aplican a todos los involucrados, no solo al dueño de la farmacia.'
      },
      {
        'type': 'complex',
        'question':
            'Sobre los medicamentos de uso oftálmico, ¿qué afirmaciones son correctas?',
        'solutions': [
          'I) Pueden ser prescritos por tecnólogos médicos en oftalmología',
          'II) Solo tratan afecciones externas del ojo',
          'III) Todos son de venta bajo receta médica',
          'IV) Pueden ser recetados por cualquier profesional de la salud'
        ],
        'options': [
          'a) Solo I y II son correctas',
          'b) Solo II y III son correctas',
          'c) Solo III y IV son correctas',
          'd) Todas son correctas'
        ],
        'correctAnswer': 'a) Solo I y II son correctas',
        'explanation':
            'Los tecnólogos médicos con mención en oftalmología pueden prescribir medicamentos oftálmicos, pero solo para afecciones externas del ojo. No todos son de venta bajo receta médica y no pueden ser recetados por cualquier profesional de la salud.'
      },
      {
        'type': 'complex',
        'question':
            'Sobre el fraccionamiento de medicamentos, ¿qué condiciones son correctas?',
        'solutions': [
          'I) Debe realizarse en un área específica',
          'II) Requiere registro de las operaciones',
          'III) Puede realizarse con cualquier medicamento',
          'IV) Debe ser supervisado por el químico farmacéutico'
        ],
        'options': [
          'a) Solo I, II y IV son correctas',
          'b) Solo II y III son correctas',
          'c) Solo I y IV son correctas',
          'd) Todas son correctas'
        ],
        'correctAnswer': 'a) Solo I, II y IV son correctas',
        'explanation':
            'El fraccionamiento debe realizarse en un área específica, requiere registro de las operaciones y debe ser supervisado por el químico farmacéutico. No puede realizarse con cualquier medicamento, hay restricciones específicas para ciertos tipos de productos.'
      },
      {
        'type': 'complex',
        'question':
            'Sobre las formas farmacéuticas, ¿qué afirmaciones son correctas?',
        'solutions': [
          'I) Determinan la vía de administración',
          'II) Afectan la biodisponibilidad del fármaco',
          'III) Solo pueden ser sólidas o líquidas',
          'IV) Influyen en la estabilidad del medicamento'
        ],
        'options': [
          'a) Solo I y II son correctas',
          'b) Solo II y III son correctas',
          'c) Solo I, II y IV son correctas',
          'd) Todas son correctas'
        ],
        'correctAnswer': 'c) Solo I, II y IV son correctas',
        'explanation':
            'Las formas farmacéuticas determinan la vía de administración, afectan la biodisponibilidad del fármaco e influyen en su estabilidad. No es correcto que solo puedan ser sólidas o líquidas, ya que también existen formas semisólidas y gaseosas.'
      },
      {
        'type': 'complex',
        'question': 'Sobre las droguerías, ¿qué características son correctas?',
        'solutions': [
          'I) Importan drogas a granel',
          'II) Distribuyen a establecimientos autorizados',
          'III) Venden directamente a pacientes',
          'IV) Realizan fraccionamiento de sustancias'
        ],
        'options': [
          'a) Solo I y II son correctas',
          'b) Solo II y III son correctas',
          'c) Solo I, II y IV son correctas',
          'd) Todas son correctas'
        ],
        'correctAnswer': 'c) Solo I, II y IV son correctas',
        'explanation':
            'Las droguerías están autorizadas para importar drogas a granel, distribuir a establecimientos autorizados y realizar fraccionamiento de sustancias. No pueden vender directamente a pacientes, ya que esta función está reservada para farmacias y otros establecimientos de dispensación.'
      },
      {
        'type': 'complex',
        'question':
            'Sobre los medicamentos antitusivos, ¿qué afirmaciones son correctas?',
        'solutions': [
          'I) La noscapina es un antitusivo puro',
          'II) Los mucolíticos son antitusivos',
          'III) Los expectorantes son antitusivos',
          'IV) Se usan solo en tos seca'
        ],
        'options': [
          'a) Solo I y IV son correctas',
          'b) Solo II y III son correctas',
          'c) Solo I, II y III son correctas',
          'd) Todas son correctas'
        ],
        'correctAnswer': 'a) Solo I y IV son correctas',
        'explanation':
            'La noscapina es un antitusivo puro y estos medicamentos se usan solo en tos seca. Los mucolíticos (como ambroxol y bromhexina) y los expectorantes no son antitusivos, aunque se usen para tratar la tos, tienen mecanismos de acción diferentes.'
      }
    ],
  };

  // Método para obtener 5 preguntas aleatorias de una clase específica
  static List<Map<String, dynamic>> getRandomQuestions(
      String className, int count) {
    final List<Map<String, dynamic>> classQuestions =
        questions[className] ?? [];
    if (classQuestions.isEmpty) {
      return [];
    }

    // Crear una copia de la lista para no modificar la original
    final List<Map<String, dynamic>> availableQuestions =
        List.from(classQuestions);
    final List<Map<String, dynamic>> selectedQuestions = [];

    // Asegurarse de que no intentamos obtener más preguntas de las disponibles
    count = min(count, availableQuestions.length);

    // Obtener preguntas aleatorias usando el algoritmo Fisher-Yates shuffle
    while (selectedQuestions.length < count) {
      final int remainingQuestions = availableQuestions.length;
      final int randomIndex = _random.nextInt(remainingQuestions);
      selectedQuestions.add(availableQuestions[randomIndex]);

      // Mover la última pregunta a la posición del elemento seleccionado
      availableQuestions[randomIndex] =
          availableQuestions[remainingQuestions - 1];
      availableQuestions.removeLast();
    }

    return selectedQuestions;
  }

  // Método para agregar una nueva pregunta
  static void addQuestion(String className, Map<String, dynamic> question) {
    if (!questions.containsKey(className)) {
      questions[className] = [];
    }
    if (validateQuestion(question)) {
      questions[className]!.add(question);
    }
  }

  // Método para validar el formato de una pregunta
  static bool validateQuestion(Map<String, dynamic> question) {
    if (!question.containsKey('type') ||
        !question.containsKey('question') ||
        !question.containsKey('options') ||
        !question.containsKey('correctAnswer') ||
        !question.containsKey('explanation')) {
      return false;
    }

    if (question['type'] == 'complex' && !question.containsKey('solutions')) {
      return false;
    }

    if (question['options'] is! List ||
        (question['solutions'] != null && question['solutions'] is! List)) {
      return false;
    }

    return true;
  }

  // Método para obtener el número total de preguntas por clase
  static int getQuestionCount(String className) {
    return questions[className]?.length ?? 0;
  }

  // Método para obtener las estadísticas de las preguntas
  static Map<String, dynamic> getQuestionStats(String className) {
    final List<Map<String, dynamic>> classQuestions =
        questions[className] ?? [];
    int simpleQuestions = 0;
    int complexQuestions = 0;

    for (var question in classQuestions) {
      if (question['type'] == 'simple') {
        simpleQuestions++;
      } else {
        complexQuestions++;
      }
    }

    return {
      'total': classQuestions.length,
      'simple': simpleQuestions,
      'complex': complexQuestions,
    };
  }
}
