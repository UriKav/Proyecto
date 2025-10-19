module second::reservaciones {
    
    use sui::vec_map::{VecMap, Self};
      
      
      /// Crear un sistema que permita gestionar reservaciones en un restaurante.
    
    public struct Mesa has store, drop {      // Estructura para representar las mesa
        numero: u64,
        capacidad: u64,
        reservada: bool,
        reservada_por: address,
    }

      // la estructura que representa el restaurante
    public struct Restaurante has  store, drop {
       
        numero_de_mesa: u64,
        maximo_mesas: u64,
    }


        #[error]
        const MAXIMO_MESA: vector<u8> = b"ERROR: EL LIMITE MAXIMO DE MESAS HA SIDO ALCANZADO";
        #[error]
        const MESA_RESERVADA: vector<u8> = b"ERRO: HAS RESERVADO ESTA MESA"; 
        #[error]
        const CANCELADO: vector<u8> = b"ERRO: RESERVACION CANCELADA"; 


    /// Crear restaurante con un número máximo de mesas
    
    
    public fun crear_restaurante(numero_de_mesa: u64, maximo_mesas: u64, ctx: &mut TxContext) {
        let restaurante = Restaurante {
            
            numero_de_mesa: 0,
            maximo_mesas: 25
        };
    }

    /// Crear una nueva mesa si no se ha alcanzado el límite máximo de mesas
   
    public fun crear_mesa(restaurante: &mut Restaurante, numero: u64, capacidad: u64, ctx: &mut TxContext) {
         let mesa = Mesa {
           
            numero,
            capacidad,
            reservada: false,
            reservada_por: @0x0,
        }; 
        
        assert!(restaurante.numero_de_mesa < restaurante.maximo_mesas, MAXIMO_MESA);
        (restaurante.numero_de_mesa = restaurante.numero_de_mesa + 1);

         
    }
    

    /// Reserva una mesa si no está ya reservada
   
   
    public fun reservar_mesa(mesa: &mut Mesa, ctx: &TxContext) {
        assert!(!mesa.reservada, MESA_RESERVADA);
        mesa.reservada = true;
        mesa.reservada_por = tx_context::sender(ctx);
    }

    /// Cancelar la reservación (la idea es que solo quien reservó pueda cancelarla)
   
   
    public fun cancelar_reservacion(mesa: &mut Mesa, ctx: &TxContext) {
        assert!(mesa.reservada_por == tx_context::sender(ctx), CANCELADO);
        mesa.reservada = false;
        mesa.reservada_por = @0x0;
    }

    /// Poder verificar la disponibilidad de una mesa
    
    
    public fun disponibilidad_de_mesa(mesa: & Mesa, ctx: &TxContext) {
        let reservada: bool;
        if (mesa.reservada) {
            reservada = true;
        } 

    }


}