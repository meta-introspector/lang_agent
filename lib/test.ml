
type empty

type stateMachine =
| St_start
| St_step
| St_end

type protocols2 =
  stateMachine
  (* singleton inductive, whose constructor was Pt_state_machine2 *)

type tNetwork_type =
| Build_TNetwork_type

type tNetwork_type2 =
| TNetwork_type2a2
| TNetwork_type2b2

type tNetwork_type3 =
| TNetwork_type2a
| TNetwork_type2b

type tAuth_type =
| Build_TAuth_type

type tConnection_type =
| Build_TConnection_type

type tConnection_type2 =
| Build_TConnection_type2

type diagonalization =
| Network of tNetwork_type
| Network2 of tNetwork_type2
| Network3 of tNetwork_type3
| Auth of tAuth_type
| Connection of tConnection_type
| Connection2 of tConnection_type2
| Empty of empty
| Unit
| Bool
| CoProd
| StateMachine1 of stateMachine
| Protocols22 of protocols2
| String
