(** File generated by coq-of-ocaml *)
Require Import CoqOfOCaml.

Module heros_journey_type.
  Record record {t_apotheosis t_adventure t_threshold t_mentor t_wisdom
    t_state_machine t_event t_call t_recognition t_retry t_sword t_denied
    t_failure t_home t_challenge t_action t_decision t_being t_hero
    t_observation t_descent t_world t_journey t_team t_allies : Set} : Set := Build {
    handle_event : t_event;
    recognise : t_recognition;
    recieve : t_call -> t_adventure;
    begin0 : t_journey -> t_state_machine;
    thrown : t_world -> t_being -> t_event;
    join : t_team -> t_allies;
    meet : t_hero -> t_mentor;
    crossing : t_threshold;
    observe : t_observation;
    descend : t_descent;
    raise : t_apotheosis;
    decide : t_decision;
    act : t_action;
    judge : t_action;
    critique : t_action;
    struggle : t_hero -> t_challenge;
    transform : t_hero -> t_challenge;
    take : t_hero -> t_sword;
    gain : t_hero -> t_wisdom;
    refusal : t_hero -> t_call -> t_denied;
    succeed : t_hero -> t_sword;
    return_to : t_hero -> t_home;
    resurrection : t_hero -> t_failure -> t_retry;
  }.
  Arguments record : clear implicits.
  Definition with_handle_event
    {t_t_apotheosis t_t_adventure t_t_threshold t_t_mentor t_t_wisdom
      t_t_state_machine t_t_event t_t_call t_t_recognition t_t_retry t_t_sword
      t_t_denied t_t_failure t_t_home t_t_challenge t_t_action t_t_decision
      t_t_being t_t_hero t_t_observation t_t_descent t_t_world t_t_journey
      t_t_team t_t_allies} handle_event
    (r :
      record t_t_apotheosis t_t_adventure t_t_threshold t_t_mentor t_t_wisdom
        t_t_state_machine t_t_event t_t_call t_t_recognition t_t_retry t_t_sword
        t_t_denied t_t_failure t_t_home t_t_challenge t_t_action t_t_decision
        t_t_being t_t_hero t_t_observation t_t_descent t_t_world t_t_journey
        t_t_team t_t_allies) :=
    Build t_t_apotheosis t_t_adventure t_t_threshold t_t_mentor t_t_wisdom
      t_t_state_machine t_t_event t_t_call t_t_recognition t_t_retry t_t_sword
      t_t_denied t_t_failure t_t_home t_t_challenge t_t_action t_t_decision
      t_t_being t_t_hero t_t_observation t_t_descent t_t_world t_t_journey
      t_t_team t_t_allies handle_event r.(recognise) r.(recieve) r.(begin0)
      r.(thrown) r.(join) r.(meet) r.(crossing) r.(observe) r.(descend)
      r.(raise) r.(decide) r.(act) r.(judge) r.(critique) r.(struggle)
      r.(transform) r.(take) r.(gain) r.(refusal) r.(succeed) r.(return_to)
      r.(resurrection).
  Definition with_recognise
    {t_t_apotheosis t_t_adventure t_t_threshold t_t_mentor t_t_wisdom
      t_t_state_machine t_t_event t_t_call t_t_recognition t_t_retry t_t_sword
      t_t_denied t_t_failure t_t_home t_t_challenge t_t_action t_t_decision
      t_t_being t_t_hero t_t_observation t_t_descent t_t_world t_t_journey
      t_t_team t_t_allies} recognise
    (r :
      record t_t_apotheosis t_t_adventure t_t_threshold t_t_mentor t_t_wisdom
        t_t_state_machine t_t_event t_t_call t_t_recognition t_t_retry t_t_sword
        t_t_denied t_t_failure t_t_home t_t_challenge t_t_action t_t_decision
        t_t_being t_t_hero t_t_observation t_t_descent t_t_world t_t_journey
        t_t_team t_t_allies) :=
    Build t_t_apotheosis t_t_adventure t_t_threshold t_t_mentor t_t_wisdom
      t_t_state_machine t_t_event t_t_call t_t_recognition t_t_retry t_t_sword
      t_t_denied t_t_failure t_t_home t_t_challenge t_t_action t_t_decision
      t_t_being t_t_hero t_t_observation t_t_descent t_t_world t_t_journey
      t_t_team t_t_allies r.(handle_event) recognise r.(recieve) r.(begin0)
      r.(thrown) r.(join) r.(meet) r.(crossing) r.(observe) r.(descend)
      r.(raise) r.(decide) r.(act) r.(judge) r.(critique) r.(struggle)
      r.(transform) r.(take) r.(gain) r.(refusal) r.(succeed) r.(return_to)
      r.(resurrection).
  Definition with_recieve
    {t_t_apotheosis t_t_adventure t_t_threshold t_t_mentor t_t_wisdom
      t_t_state_machine t_t_event t_t_call t_t_recognition t_t_retry t_t_sword
      t_t_denied t_t_failure t_t_home t_t_challenge t_t_action t_t_decision
      t_t_being t_t_hero t_t_observation t_t_descent t_t_world t_t_journey
      t_t_team t_t_allies} recieve
    (r :
      record t_t_apotheosis t_t_adventure t_t_threshold t_t_mentor t_t_wisdom
        t_t_state_machine t_t_event t_t_call t_t_recognition t_t_retry t_t_sword
        t_t_denied t_t_failure t_t_home t_t_challenge t_t_action t_t_decision
        t_t_being t_t_hero t_t_observation t_t_descent t_t_world t_t_journey
        t_t_team t_t_allies) :=
    Build t_t_apotheosis t_t_adventure t_t_threshold t_t_mentor t_t_wisdom
      t_t_state_machine t_t_event t_t_call t_t_recognition t_t_retry t_t_sword
      t_t_denied t_t_failure t_t_home t_t_challenge t_t_action t_t_decision
      t_t_being t_t_hero t_t_observation t_t_descent t_t_world t_t_journey
      t_t_team t_t_allies r.(handle_event) r.(recognise) recieve r.(begin0)
      r.(thrown) r.(join) r.(meet) r.(crossing) r.(observe) r.(descend)
      r.(raise) r.(decide) r.(act) r.(judge) r.(critique) r.(struggle)
      r.(transform) r.(take) r.(gain) r.(refusal) r.(succeed) r.(return_to)
      r.(resurrection).
  Definition with_begin0
    {t_t_apotheosis t_t_adventure t_t_threshold t_t_mentor t_t_wisdom
      t_t_state_machine t_t_event t_t_call t_t_recognition t_t_retry t_t_sword
      t_t_denied t_t_failure t_t_home t_t_challenge t_t_action t_t_decision
      t_t_being t_t_hero t_t_observation t_t_descent t_t_world t_t_journey
      t_t_team t_t_allies} begin0
    (r :
      record t_t_apotheosis t_t_adventure t_t_threshold t_t_mentor t_t_wisdom
        t_t_state_machine t_t_event t_t_call t_t_recognition t_t_retry t_t_sword
        t_t_denied t_t_failure t_t_home t_t_challenge t_t_action t_t_decision
        t_t_being t_t_hero t_t_observation t_t_descent t_t_world t_t_journey
        t_t_team t_t_allies) :=
    Build t_t_apotheosis t_t_adventure t_t_threshold t_t_mentor t_t_wisdom
      t_t_state_machine t_t_event t_t_call t_t_recognition t_t_retry t_t_sword
      t_t_denied t_t_failure t_t_home t_t_challenge t_t_action t_t_decision
      t_t_being t_t_hero t_t_observation t_t_descent t_t_world t_t_journey
      t_t_team t_t_allies r.(handle_event) r.(recognise) r.(recieve) begin0
      r.(thrown) r.(join) r.(meet) r.(crossing) r.(observe) r.(descend)
      r.(raise) r.(decide) r.(act) r.(judge) r.(critique) r.(struggle)
      r.(transform) r.(take) r.(gain) r.(refusal) r.(succeed) r.(return_to)
      r.(resurrection).
  Definition with_thrown
    {t_t_apotheosis t_t_adventure t_t_threshold t_t_mentor t_t_wisdom
      t_t_state_machine t_t_event t_t_call t_t_recognition t_t_retry t_t_sword
      t_t_denied t_t_failure t_t_home t_t_challenge t_t_action t_t_decision
      t_t_being t_t_hero t_t_observation t_t_descent t_t_world t_t_journey
      t_t_team t_t_allies} thrown
    (r :
      record t_t_apotheosis t_t_adventure t_t_threshold t_t_mentor t_t_wisdom
        t_t_state_machine t_t_event t_t_call t_t_recognition t_t_retry t_t_sword
        t_t_denied t_t_failure t_t_home t_t_challenge t_t_action t_t_decision
        t_t_being t_t_hero t_t_observation t_t_descent t_t_world t_t_journey
        t_t_team t_t_allies) :=
    Build t_t_apotheosis t_t_adventure t_t_threshold t_t_mentor t_t_wisdom
      t_t_state_machine t_t_event t_t_call t_t_recognition t_t_retry t_t_sword
      t_t_denied t_t_failure t_t_home t_t_challenge t_t_action t_t_decision
      t_t_being t_t_hero t_t_observation t_t_descent t_t_world t_t_journey
      t_t_team t_t_allies r.(handle_event) r.(recognise) r.(recieve) r.(begin0)
      thrown r.(join) r.(meet) r.(crossing) r.(observe) r.(descend) r.(raise)
      r.(decide) r.(act) r.(judge) r.(critique) r.(struggle) r.(transform)
      r.(take) r.(gain) r.(refusal) r.(succeed) r.(return_to) r.(resurrection).
  Definition with_join
    {t_t_apotheosis t_t_adventure t_t_threshold t_t_mentor t_t_wisdom
      t_t_state_machine t_t_event t_t_call t_t_recognition t_t_retry t_t_sword
      t_t_denied t_t_failure t_t_home t_t_challenge t_t_action t_t_decision
      t_t_being t_t_hero t_t_observation t_t_descent t_t_world t_t_journey
      t_t_team t_t_allies} join
    (r :
      record t_t_apotheosis t_t_adventure t_t_threshold t_t_mentor t_t_wisdom
        t_t_state_machine t_t_event t_t_call t_t_recognition t_t_retry t_t_sword
        t_t_denied t_t_failure t_t_home t_t_challenge t_t_action t_t_decision
        t_t_being t_t_hero t_t_observation t_t_descent t_t_world t_t_journey
        t_t_team t_t_allies) :=
    Build t_t_apotheosis t_t_adventure t_t_threshold t_t_mentor t_t_wisdom
      t_t_state_machine t_t_event t_t_call t_t_recognition t_t_retry t_t_sword
      t_t_denied t_t_failure t_t_home t_t_challenge t_t_action t_t_decision
      t_t_being t_t_hero t_t_observation t_t_descent t_t_world t_t_journey
      t_t_team t_t_allies r.(handle_event) r.(recognise) r.(recieve) r.(begin0)
      r.(thrown) join r.(meet) r.(crossing) r.(observe) r.(descend) r.(raise)
      r.(decide) r.(act) r.(judge) r.(critique) r.(struggle) r.(transform)
      r.(take) r.(gain) r.(refusal) r.(succeed) r.(return_to) r.(resurrection).
  Definition with_meet
    {t_t_apotheosis t_t_adventure t_t_threshold t_t_mentor t_t_wisdom
      t_t_state_machine t_t_event t_t_call t_t_recognition t_t_retry t_t_sword
      t_t_denied t_t_failure t_t_home t_t_challenge t_t_action t_t_decision
      t_t_being t_t_hero t_t_observation t_t_descent t_t_world t_t_journey
      t_t_team t_t_allies} meet
    (r :
      record t_t_apotheosis t_t_adventure t_t_threshold t_t_mentor t_t_wisdom
        t_t_state_machine t_t_event t_t_call t_t_recognition t_t_retry t_t_sword
        t_t_denied t_t_failure t_t_home t_t_challenge t_t_action t_t_decision
        t_t_being t_t_hero t_t_observation t_t_descent t_t_world t_t_journey
        t_t_team t_t_allies) :=
    Build t_t_apotheosis t_t_adventure t_t_threshold t_t_mentor t_t_wisdom
      t_t_state_machine t_t_event t_t_call t_t_recognition t_t_retry t_t_sword
      t_t_denied t_t_failure t_t_home t_t_challenge t_t_action t_t_decision
      t_t_being t_t_hero t_t_observation t_t_descent t_t_world t_t_journey
      t_t_team t_t_allies r.(handle_event) r.(recognise) r.(recieve) r.(begin0)
      r.(thrown) r.(join) meet r.(crossing) r.(observe) r.(descend) r.(raise)
      r.(decide) r.(act) r.(judge) r.(critique) r.(struggle) r.(transform)
      r.(take) r.(gain) r.(refusal) r.(succeed) r.(return_to) r.(resurrection).
  Definition with_crossing
    {t_t_apotheosis t_t_adventure t_t_threshold t_t_mentor t_t_wisdom
      t_t_state_machine t_t_event t_t_call t_t_recognition t_t_retry t_t_sword
      t_t_denied t_t_failure t_t_home t_t_challenge t_t_action t_t_decision
      t_t_being t_t_hero t_t_observation t_t_descent t_t_world t_t_journey
      t_t_team t_t_allies} crossing
    (r :
      record t_t_apotheosis t_t_adventure t_t_threshold t_t_mentor t_t_wisdom
        t_t_state_machine t_t_event t_t_call t_t_recognition t_t_retry t_t_sword
        t_t_denied t_t_failure t_t_home t_t_challenge t_t_action t_t_decision
        t_t_being t_t_hero t_t_observation t_t_descent t_t_world t_t_journey
        t_t_team t_t_allies) :=
    Build t_t_apotheosis t_t_adventure t_t_threshold t_t_mentor t_t_wisdom
      t_t_state_machine t_t_event t_t_call t_t_recognition t_t_retry t_t_sword
      t_t_denied t_t_failure t_t_home t_t_challenge t_t_action t_t_decision
      t_t_being t_t_hero t_t_observation t_t_descent t_t_world t_t_journey
      t_t_team t_t_allies r.(handle_event) r.(recognise) r.(recieve) r.(begin0)
      r.(thrown) r.(join) r.(meet) crossing r.(observe) r.(descend) r.(raise)
      r.(decide) r.(act) r.(judge) r.(critique) r.(struggle) r.(transform)
      r.(take) r.(gain) r.(refusal) r.(succeed) r.(return_to) r.(resurrection).
  Definition with_observe
    {t_t_apotheosis t_t_adventure t_t_threshold t_t_mentor t_t_wisdom
      t_t_state_machine t_t_event t_t_call t_t_recognition t_t_retry t_t_sword
      t_t_denied t_t_failure t_t_home t_t_challenge t_t_action t_t_decision
      t_t_being t_t_hero t_t_observation t_t_descent t_t_world t_t_journey
      t_t_team t_t_allies} observe
    (r :
      record t_t_apotheosis t_t_adventure t_t_threshold t_t_mentor t_t_wisdom
        t_t_state_machine t_t_event t_t_call t_t_recognition t_t_retry t_t_sword
        t_t_denied t_t_failure t_t_home t_t_challenge t_t_action t_t_decision
        t_t_being t_t_hero t_t_observation t_t_descent t_t_world t_t_journey
        t_t_team t_t_allies) :=
    Build t_t_apotheosis t_t_adventure t_t_threshold t_t_mentor t_t_wisdom
      t_t_state_machine t_t_event t_t_call t_t_recognition t_t_retry t_t_sword
      t_t_denied t_t_failure t_t_home t_t_challenge t_t_action t_t_decision
      t_t_being t_t_hero t_t_observation t_t_descent t_t_world t_t_journey
      t_t_team t_t_allies r.(handle_event) r.(recognise) r.(recieve) r.(begin0)
      r.(thrown) r.(join) r.(meet) r.(crossing) observe r.(descend) r.(raise)
      r.(decide) r.(act) r.(judge) r.(critique) r.(struggle) r.(transform)
      r.(take) r.(gain) r.(refusal) r.(succeed) r.(return_to) r.(resurrection).
  Definition with_descend
    {t_t_apotheosis t_t_adventure t_t_threshold t_t_mentor t_t_wisdom
      t_t_state_machine t_t_event t_t_call t_t_recognition t_t_retry t_t_sword
      t_t_denied t_t_failure t_t_home t_t_challenge t_t_action t_t_decision
      t_t_being t_t_hero t_t_observation t_t_descent t_t_world t_t_journey
      t_t_team t_t_allies} descend
    (r :
      record t_t_apotheosis t_t_adventure t_t_threshold t_t_mentor t_t_wisdom
        t_t_state_machine t_t_event t_t_call t_t_recognition t_t_retry t_t_sword
        t_t_denied t_t_failure t_t_home t_t_challenge t_t_action t_t_decision
        t_t_being t_t_hero t_t_observation t_t_descent t_t_world t_t_journey
        t_t_team t_t_allies) :=
    Build t_t_apotheosis t_t_adventure t_t_threshold t_t_mentor t_t_wisdom
      t_t_state_machine t_t_event t_t_call t_t_recognition t_t_retry t_t_sword
      t_t_denied t_t_failure t_t_home t_t_challenge t_t_action t_t_decision
      t_t_being t_t_hero t_t_observation t_t_descent t_t_world t_t_journey
      t_t_team t_t_allies r.(handle_event) r.(recognise) r.(recieve) r.(begin0)
      r.(thrown) r.(join) r.(meet) r.(crossing) r.(observe) descend r.(raise)
      r.(decide) r.(act) r.(judge) r.(critique) r.(struggle) r.(transform)
      r.(take) r.(gain) r.(refusal) r.(succeed) r.(return_to) r.(resurrection).
  Definition with_raise
    {t_t_apotheosis t_t_adventure t_t_threshold t_t_mentor t_t_wisdom
      t_t_state_machine t_t_event t_t_call t_t_recognition t_t_retry t_t_sword
      t_t_denied t_t_failure t_t_home t_t_challenge t_t_action t_t_decision
      t_t_being t_t_hero t_t_observation t_t_descent t_t_world t_t_journey
      t_t_team t_t_allies} raise
    (r :
      record t_t_apotheosis t_t_adventure t_t_threshold t_t_mentor t_t_wisdom
        t_t_state_machine t_t_event t_t_call t_t_recognition t_t_retry t_t_sword
        t_t_denied t_t_failure t_t_home t_t_challenge t_t_action t_t_decision
        t_t_being t_t_hero t_t_observation t_t_descent t_t_world t_t_journey
        t_t_team t_t_allies) :=
    Build t_t_apotheosis t_t_adventure t_t_threshold t_t_mentor t_t_wisdom
      t_t_state_machine t_t_event t_t_call t_t_recognition t_t_retry t_t_sword
      t_t_denied t_t_failure t_t_home t_t_challenge t_t_action t_t_decision
      t_t_being t_t_hero t_t_observation t_t_descent t_t_world t_t_journey
      t_t_team t_t_allies r.(handle_event) r.(recognise) r.(recieve) r.(begin0)
      r.(thrown) r.(join) r.(meet) r.(crossing) r.(observe) r.(descend) raise
      r.(decide) r.(act) r.(judge) r.(critique) r.(struggle) r.(transform)
      r.(take) r.(gain) r.(refusal) r.(succeed) r.(return_to) r.(resurrection).
  Definition with_decide
    {t_t_apotheosis t_t_adventure t_t_threshold t_t_mentor t_t_wisdom
      t_t_state_machine t_t_event t_t_call t_t_recognition t_t_retry t_t_sword
      t_t_denied t_t_failure t_t_home t_t_challenge t_t_action t_t_decision
      t_t_being t_t_hero t_t_observation t_t_descent t_t_world t_t_journey
      t_t_team t_t_allies} decide
    (r :
      record t_t_apotheosis t_t_adventure t_t_threshold t_t_mentor t_t_wisdom
        t_t_state_machine t_t_event t_t_call t_t_recognition t_t_retry t_t_sword
        t_t_denied t_t_failure t_t_home t_t_challenge t_t_action t_t_decision
        t_t_being t_t_hero t_t_observation t_t_descent t_t_world t_t_journey
        t_t_team t_t_allies) :=
    Build t_t_apotheosis t_t_adventure t_t_threshold t_t_mentor t_t_wisdom
      t_t_state_machine t_t_event t_t_call t_t_recognition t_t_retry t_t_sword
      t_t_denied t_t_failure t_t_home t_t_challenge t_t_action t_t_decision
      t_t_being t_t_hero t_t_observation t_t_descent t_t_world t_t_journey
      t_t_team t_t_allies r.(handle_event) r.(recognise) r.(recieve) r.(begin0)
      r.(thrown) r.(join) r.(meet) r.(crossing) r.(observe) r.(descend)
      r.(raise) decide r.(act) r.(judge) r.(critique) r.(struggle) r.(transform)
      r.(take) r.(gain) r.(refusal) r.(succeed) r.(return_to) r.(resurrection).
  Definition with_act
    {t_t_apotheosis t_t_adventure t_t_threshold t_t_mentor t_t_wisdom
      t_t_state_machine t_t_event t_t_call t_t_recognition t_t_retry t_t_sword
      t_t_denied t_t_failure t_t_home t_t_challenge t_t_action t_t_decision
      t_t_being t_t_hero t_t_observation t_t_descent t_t_world t_t_journey
      t_t_team t_t_allies} act
    (r :
      record t_t_apotheosis t_t_adventure t_t_threshold t_t_mentor t_t_wisdom
        t_t_state_machine t_t_event t_t_call t_t_recognition t_t_retry t_t_sword
        t_t_denied t_t_failure t_t_home t_t_challenge t_t_action t_t_decision
        t_t_being t_t_hero t_t_observation t_t_descent t_t_world t_t_journey
        t_t_team t_t_allies) :=
    Build t_t_apotheosis t_t_adventure t_t_threshold t_t_mentor t_t_wisdom
      t_t_state_machine t_t_event t_t_call t_t_recognition t_t_retry t_t_sword
      t_t_denied t_t_failure t_t_home t_t_challenge t_t_action t_t_decision
      t_t_being t_t_hero t_t_observation t_t_descent t_t_world t_t_journey
      t_t_team t_t_allies r.(handle_event) r.(recognise) r.(recieve) r.(begin0)
      r.(thrown) r.(join) r.(meet) r.(crossing) r.(observe) r.(descend)
      r.(raise) r.(decide) act r.(judge) r.(critique) r.(struggle) r.(transform)
      r.(take) r.(gain) r.(refusal) r.(succeed) r.(return_to) r.(resurrection).
  Definition with_judge
    {t_t_apotheosis t_t_adventure t_t_threshold t_t_mentor t_t_wisdom
      t_t_state_machine t_t_event t_t_call t_t_recognition t_t_retry t_t_sword
      t_t_denied t_t_failure t_t_home t_t_challenge t_t_action t_t_decision
      t_t_being t_t_hero t_t_observation t_t_descent t_t_world t_t_journey
      t_t_team t_t_allies} judge
    (r :
      record t_t_apotheosis t_t_adventure t_t_threshold t_t_mentor t_t_wisdom
        t_t_state_machine t_t_event t_t_call t_t_recognition t_t_retry t_t_sword
        t_t_denied t_t_failure t_t_home t_t_challenge t_t_action t_t_decision
        t_t_being t_t_hero t_t_observation t_t_descent t_t_world t_t_journey
        t_t_team t_t_allies) :=
    Build t_t_apotheosis t_t_adventure t_t_threshold t_t_mentor t_t_wisdom
      t_t_state_machine t_t_event t_t_call t_t_recognition t_t_retry t_t_sword
      t_t_denied t_t_failure t_t_home t_t_challenge t_t_action t_t_decision
      t_t_being t_t_hero t_t_observation t_t_descent t_t_world t_t_journey
      t_t_team t_t_allies r.(handle_event) r.(recognise) r.(recieve) r.(begin0)
      r.(thrown) r.(join) r.(meet) r.(crossing) r.(observe) r.(descend)
      r.(raise) r.(decide) r.(act) judge r.(critique) r.(struggle) r.(transform)
      r.(take) r.(gain) r.(refusal) r.(succeed) r.(return_to) r.(resurrection).
  Definition with_critique
    {t_t_apotheosis t_t_adventure t_t_threshold t_t_mentor t_t_wisdom
      t_t_state_machine t_t_event t_t_call t_t_recognition t_t_retry t_t_sword
      t_t_denied t_t_failure t_t_home t_t_challenge t_t_action t_t_decision
      t_t_being t_t_hero t_t_observation t_t_descent t_t_world t_t_journey
      t_t_team t_t_allies} critique
    (r :
      record t_t_apotheosis t_t_adventure t_t_threshold t_t_mentor t_t_wisdom
        t_t_state_machine t_t_event t_t_call t_t_recognition t_t_retry t_t_sword
        t_t_denied t_t_failure t_t_home t_t_challenge t_t_action t_t_decision
        t_t_being t_t_hero t_t_observation t_t_descent t_t_world t_t_journey
        t_t_team t_t_allies) :=
    Build t_t_apotheosis t_t_adventure t_t_threshold t_t_mentor t_t_wisdom
      t_t_state_machine t_t_event t_t_call t_t_recognition t_t_retry t_t_sword
      t_t_denied t_t_failure t_t_home t_t_challenge t_t_action t_t_decision
      t_t_being t_t_hero t_t_observation t_t_descent t_t_world t_t_journey
      t_t_team t_t_allies r.(handle_event) r.(recognise) r.(recieve) r.(begin0)
      r.(thrown) r.(join) r.(meet) r.(crossing) r.(observe) r.(descend)
      r.(raise) r.(decide) r.(act) r.(judge) critique r.(struggle) r.(transform)
      r.(take) r.(gain) r.(refusal) r.(succeed) r.(return_to) r.(resurrection).
  Definition with_struggle
    {t_t_apotheosis t_t_adventure t_t_threshold t_t_mentor t_t_wisdom
      t_t_state_machine t_t_event t_t_call t_t_recognition t_t_retry t_t_sword
      t_t_denied t_t_failure t_t_home t_t_challenge t_t_action t_t_decision
      t_t_being t_t_hero t_t_observation t_t_descent t_t_world t_t_journey
      t_t_team t_t_allies} struggle
    (r :
      record t_t_apotheosis t_t_adventure t_t_threshold t_t_mentor t_t_wisdom
        t_t_state_machine t_t_event t_t_call t_t_recognition t_t_retry t_t_sword
        t_t_denied t_t_failure t_t_home t_t_challenge t_t_action t_t_decision
        t_t_being t_t_hero t_t_observation t_t_descent t_t_world t_t_journey
        t_t_team t_t_allies) :=
    Build t_t_apotheosis t_t_adventure t_t_threshold t_t_mentor t_t_wisdom
      t_t_state_machine t_t_event t_t_call t_t_recognition t_t_retry t_t_sword
      t_t_denied t_t_failure t_t_home t_t_challenge t_t_action t_t_decision
      t_t_being t_t_hero t_t_observation t_t_descent t_t_world t_t_journey
      t_t_team t_t_allies r.(handle_event) r.(recognise) r.(recieve) r.(begin0)
      r.(thrown) r.(join) r.(meet) r.(crossing) r.(observe) r.(descend)
      r.(raise) r.(decide) r.(act) r.(judge) r.(critique) struggle r.(transform)
      r.(take) r.(gain) r.(refusal) r.(succeed) r.(return_to) r.(resurrection).
  Definition with_transform
    {t_t_apotheosis t_t_adventure t_t_threshold t_t_mentor t_t_wisdom
      t_t_state_machine t_t_event t_t_call t_t_recognition t_t_retry t_t_sword
      t_t_denied t_t_failure t_t_home t_t_challenge t_t_action t_t_decision
      t_t_being t_t_hero t_t_observation t_t_descent t_t_world t_t_journey
      t_t_team t_t_allies} transform
    (r :
      record t_t_apotheosis t_t_adventure t_t_threshold t_t_mentor t_t_wisdom
        t_t_state_machine t_t_event t_t_call t_t_recognition t_t_retry t_t_sword
        t_t_denied t_t_failure t_t_home t_t_challenge t_t_action t_t_decision
        t_t_being t_t_hero t_t_observation t_t_descent t_t_world t_t_journey
        t_t_team t_t_allies) :=
    Build t_t_apotheosis t_t_adventure t_t_threshold t_t_mentor t_t_wisdom
      t_t_state_machine t_t_event t_t_call t_t_recognition t_t_retry t_t_sword
      t_t_denied t_t_failure t_t_home t_t_challenge t_t_action t_t_decision
      t_t_being t_t_hero t_t_observation t_t_descent t_t_world t_t_journey
      t_t_team t_t_allies r.(handle_event) r.(recognise) r.(recieve) r.(begin0)
      r.(thrown) r.(join) r.(meet) r.(crossing) r.(observe) r.(descend)
      r.(raise) r.(decide) r.(act) r.(judge) r.(critique) r.(struggle) transform
      r.(take) r.(gain) r.(refusal) r.(succeed) r.(return_to) r.(resurrection).
  Definition with_take
    {t_t_apotheosis t_t_adventure t_t_threshold t_t_mentor t_t_wisdom
      t_t_state_machine t_t_event t_t_call t_t_recognition t_t_retry t_t_sword
      t_t_denied t_t_failure t_t_home t_t_challenge t_t_action t_t_decision
      t_t_being t_t_hero t_t_observation t_t_descent t_t_world t_t_journey
      t_t_team t_t_allies} take
    (r :
      record t_t_apotheosis t_t_adventure t_t_threshold t_t_mentor t_t_wisdom
        t_t_state_machine t_t_event t_t_call t_t_recognition t_t_retry t_t_sword
        t_t_denied t_t_failure t_t_home t_t_challenge t_t_action t_t_decision
        t_t_being t_t_hero t_t_observation t_t_descent t_t_world t_t_journey
        t_t_team t_t_allies) :=
    Build t_t_apotheosis t_t_adventure t_t_threshold t_t_mentor t_t_wisdom
      t_t_state_machine t_t_event t_t_call t_t_recognition t_t_retry t_t_sword
      t_t_denied t_t_failure t_t_home t_t_challenge t_t_action t_t_decision
      t_t_being t_t_hero t_t_observation t_t_descent t_t_world t_t_journey
      t_t_team t_t_allies r.(handle_event) r.(recognise) r.(recieve) r.(begin0)
      r.(thrown) r.(join) r.(meet) r.(crossing) r.(observe) r.(descend)
      r.(raise) r.(decide) r.(act) r.(judge) r.(critique) r.(struggle)
      r.(transform) take r.(gain) r.(refusal) r.(succeed) r.(return_to)
      r.(resurrection).
  Definition with_gain
    {t_t_apotheosis t_t_adventure t_t_threshold t_t_mentor t_t_wisdom
      t_t_state_machine t_t_event t_t_call t_t_recognition t_t_retry t_t_sword
      t_t_denied t_t_failure t_t_home t_t_challenge t_t_action t_t_decision
      t_t_being t_t_hero t_t_observation t_t_descent t_t_world t_t_journey
      t_t_team t_t_allies} gain
    (r :
      record t_t_apotheosis t_t_adventure t_t_threshold t_t_mentor t_t_wisdom
        t_t_state_machine t_t_event t_t_call t_t_recognition t_t_retry t_t_sword
        t_t_denied t_t_failure t_t_home t_t_challenge t_t_action t_t_decision
        t_t_being t_t_hero t_t_observation t_t_descent t_t_world t_t_journey
        t_t_team t_t_allies) :=
    Build t_t_apotheosis t_t_adventure t_t_threshold t_t_mentor t_t_wisdom
      t_t_state_machine t_t_event t_t_call t_t_recognition t_t_retry t_t_sword
      t_t_denied t_t_failure t_t_home t_t_challenge t_t_action t_t_decision
      t_t_being t_t_hero t_t_observation t_t_descent t_t_world t_t_journey
      t_t_team t_t_allies r.(handle_event) r.(recognise) r.(recieve) r.(begin0)
      r.(thrown) r.(join) r.(meet) r.(crossing) r.(observe) r.(descend)
      r.(raise) r.(decide) r.(act) r.(judge) r.(critique) r.(struggle)
      r.(transform) r.(take) gain r.(refusal) r.(succeed) r.(return_to)
      r.(resurrection).
  Definition with_refusal
    {t_t_apotheosis t_t_adventure t_t_threshold t_t_mentor t_t_wisdom
      t_t_state_machine t_t_event t_t_call t_t_recognition t_t_retry t_t_sword
      t_t_denied t_t_failure t_t_home t_t_challenge t_t_action t_t_decision
      t_t_being t_t_hero t_t_observation t_t_descent t_t_world t_t_journey
      t_t_team t_t_allies} refusal
    (r :
      record t_t_apotheosis t_t_adventure t_t_threshold t_t_mentor t_t_wisdom
        t_t_state_machine t_t_event t_t_call t_t_recognition t_t_retry t_t_sword
        t_t_denied t_t_failure t_t_home t_t_challenge t_t_action t_t_decision
        t_t_being t_t_hero t_t_observation t_t_descent t_t_world t_t_journey
        t_t_team t_t_allies) :=
    Build t_t_apotheosis t_t_adventure t_t_threshold t_t_mentor t_t_wisdom
      t_t_state_machine t_t_event t_t_call t_t_recognition t_t_retry t_t_sword
      t_t_denied t_t_failure t_t_home t_t_challenge t_t_action t_t_decision
      t_t_being t_t_hero t_t_observation t_t_descent t_t_world t_t_journey
      t_t_team t_t_allies r.(handle_event) r.(recognise) r.(recieve) r.(begin0)
      r.(thrown) r.(join) r.(meet) r.(crossing) r.(observe) r.(descend)
      r.(raise) r.(decide) r.(act) r.(judge) r.(critique) r.(struggle)
      r.(transform) r.(take) r.(gain) refusal r.(succeed) r.(return_to)
      r.(resurrection).
  Definition with_succeed
    {t_t_apotheosis t_t_adventure t_t_threshold t_t_mentor t_t_wisdom
      t_t_state_machine t_t_event t_t_call t_t_recognition t_t_retry t_t_sword
      t_t_denied t_t_failure t_t_home t_t_challenge t_t_action t_t_decision
      t_t_being t_t_hero t_t_observation t_t_descent t_t_world t_t_journey
      t_t_team t_t_allies} succeed
    (r :
      record t_t_apotheosis t_t_adventure t_t_threshold t_t_mentor t_t_wisdom
        t_t_state_machine t_t_event t_t_call t_t_recognition t_t_retry t_t_sword
        t_t_denied t_t_failure t_t_home t_t_challenge t_t_action t_t_decision
        t_t_being t_t_hero t_t_observation t_t_descent t_t_world t_t_journey
        t_t_team t_t_allies) :=
    Build t_t_apotheosis t_t_adventure t_t_threshold t_t_mentor t_t_wisdom
      t_t_state_machine t_t_event t_t_call t_t_recognition t_t_retry t_t_sword
      t_t_denied t_t_failure t_t_home t_t_challenge t_t_action t_t_decision
      t_t_being t_t_hero t_t_observation t_t_descent t_t_world t_t_journey
      t_t_team t_t_allies r.(handle_event) r.(recognise) r.(recieve) r.(begin0)
      r.(thrown) r.(join) r.(meet) r.(crossing) r.(observe) r.(descend)
      r.(raise) r.(decide) r.(act) r.(judge) r.(critique) r.(struggle)
      r.(transform) r.(take) r.(gain) r.(refusal) succeed r.(return_to)
      r.(resurrection).
  Definition with_return_to
    {t_t_apotheosis t_t_adventure t_t_threshold t_t_mentor t_t_wisdom
      t_t_state_machine t_t_event t_t_call t_t_recognition t_t_retry t_t_sword
      t_t_denied t_t_failure t_t_home t_t_challenge t_t_action t_t_decision
      t_t_being t_t_hero t_t_observation t_t_descent t_t_world t_t_journey
      t_t_team t_t_allies} return_to
    (r :
      record t_t_apotheosis t_t_adventure t_t_threshold t_t_mentor t_t_wisdom
        t_t_state_machine t_t_event t_t_call t_t_recognition t_t_retry t_t_sword
        t_t_denied t_t_failure t_t_home t_t_challenge t_t_action t_t_decision
        t_t_being t_t_hero t_t_observation t_t_descent t_t_world t_t_journey
        t_t_team t_t_allies) :=
    Build t_t_apotheosis t_t_adventure t_t_threshold t_t_mentor t_t_wisdom
      t_t_state_machine t_t_event t_t_call t_t_recognition t_t_retry t_t_sword
      t_t_denied t_t_failure t_t_home t_t_challenge t_t_action t_t_decision
      t_t_being t_t_hero t_t_observation t_t_descent t_t_world t_t_journey
      t_t_team t_t_allies r.(handle_event) r.(recognise) r.(recieve) r.(begin0)
      r.(thrown) r.(join) r.(meet) r.(crossing) r.(observe) r.(descend)
      r.(raise) r.(decide) r.(act) r.(judge) r.(critique) r.(struggle)
      r.(transform) r.(take) r.(gain) r.(refusal) r.(succeed) return_to
      r.(resurrection).
  Definition with_resurrection
    {t_t_apotheosis t_t_adventure t_t_threshold t_t_mentor t_t_wisdom
      t_t_state_machine t_t_event t_t_call t_t_recognition t_t_retry t_t_sword
      t_t_denied t_t_failure t_t_home t_t_challenge t_t_action t_t_decision
      t_t_being t_t_hero t_t_observation t_t_descent t_t_world t_t_journey
      t_t_team t_t_allies} resurrection
    (r :
      record t_t_apotheosis t_t_adventure t_t_threshold t_t_mentor t_t_wisdom
        t_t_state_machine t_t_event t_t_call t_t_recognition t_t_retry t_t_sword
        t_t_denied t_t_failure t_t_home t_t_challenge t_t_action t_t_decision
        t_t_being t_t_hero t_t_observation t_t_descent t_t_world t_t_journey
        t_t_team t_t_allies) :=
    Build t_t_apotheosis t_t_adventure t_t_threshold t_t_mentor t_t_wisdom
      t_t_state_machine t_t_event t_t_call t_t_recognition t_t_retry t_t_sword
      t_t_denied t_t_failure t_t_home t_t_challenge t_t_action t_t_decision
      t_t_being t_t_hero t_t_observation t_t_descent t_t_world t_t_journey
      t_t_team t_t_allies r.(handle_event) r.(recognise) r.(recieve) r.(begin0)
      r.(thrown) r.(join) r.(meet) r.(crossing) r.(observe) r.(descend)
      r.(raise) r.(decide) r.(act) r.(judge) r.(critique) r.(struggle)
      r.(transform) r.(take) r.(gain) r.(refusal) r.(succeed) r.(return_to)
      resurrection.
End heros_journey_type.
Definition heros_journey_type := heros_journey_type.record.

Definition begin0 {A B C D E F G H I J K L M N O P Q R S T U V W X Y : Set}
  (heros_journey_type0 :
    heros_journey_type A B C D E F G H I J K L M N O P Q R S T U V W X Y)
  : W -> F := heros_journey_type0.(heros_journey_type.begin0).
