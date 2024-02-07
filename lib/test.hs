module Test where

import qualified Prelude

type Empty = () -- empty inductive

data StateMachine =
   St_start
 | St_step
 | St_end

type Protocols2 =
  StateMachine
  -- singleton inductive, whose constructor was Pt_state_machine2
  
data TNetwork_type =
   Build_TNetwork_type

data TNetwork_type2 =
   TNetwork_type2a2
 | TNetwork_type2b2

data TNetwork_type3 =
   TNetwork_type2a
 | TNetwork_type2b

data TAuth_type =
   Build_TAuth_type

data TConnection_type =
   Build_TConnection_type

data TConnection_type2 =
   Build_TConnection_type2

data Diagonalization =
   Network TNetwork_type
 | Network2 TNetwork_type2
 | Network3 TNetwork_type3
 | Auth TAuth_type
 | Connection TConnection_type
 | Connection2 TConnection_type2
 | Empty0 Empty
 | Unit
 | Bool
 | CoProd
 | StateMachine1 StateMachine
 | Protocols22 Protocols2
 | String

