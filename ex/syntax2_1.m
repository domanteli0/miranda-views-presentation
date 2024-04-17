abstype stack *
with empty :: stack *
     isempty :: stack * -> bool
     push :: * -> stack * -> stack *
     pop :: stack * -> stack *
     top :: stack * -> *