
type ('t_apotheosis, 't_risk,
      't_adventure, 't_threshold,
      't_mentor, 't_road_of_trials,
      't_skills, 't_wisdom,
      't_perspective,
      't_state_machine, 't_event,
      't_call, 't_goal,
      't_fufillment, 't_reward,
      't_treasure, 't_recognition,
      't_elixer, 't_narrative,
      't_prophecy, 't_retry, 't_cave,
      't_sword, 't_denied,
      't_failure, 't_accepted,
      't_home, 't_challenge,
      't_enemies, 't_monsters,
      't_obstacles, 't_action,
      't_descent0, 't_decision,
      't_being, 't_hero,
      't_observation, 't_descent,
      't_world, 't_journey,
      't_situation, 't_critical,
      't_team, 't_opportunity,
      't_allies) heros_journey_type = { 
handle_event : 't_event;
recognise : 't_recognition;
recieve : ('t_call -> 't_adventure);
begin0 : ('t_journey ->
         't_state_machine);
thrown : ('t_world -> 't_being ->
         't_event);
join : ('t_team -> 't_allies);
meet : ('t_hero -> 't_mentor);
crossing : 't_threshold;
observe : 't_observation;
descend : 't_descent;
raise : 't_apotheosis;
decide : 't_decision;
act : 't_action; judge : 't_action;
critique : 't_action;
struggle : ('t_hero -> 't_challenge);
transform : ('t_hero -> 't_challenge);
take : ('t_hero -> 't_sword);
gain : ('t_hero -> 't_wisdom);
refusal : ('t_hero -> 't_call ->
          't_denied);
succeed : ('t_hero -> 't_sword);
return_to : ('t_hero -> 't_home);
resurrection : ('t_hero -> 't_failure
               -> 't_retry) }

(** val begin0 :
    ('a1, 'a2, 'a3, 'a4, 'a5, 'a6,
    'a7, 'a8, 'a9, 'a10, 'a11, 'a12,
    'a13, 'a14, 'a15, 'a16, 'a17,
    'a18, 'a19, 'a20, 'a21, 'a22,
    'a23, 'a24, 'a25, 'a26, 'a27,
    'a28, 'a29, 'a30, 'a31, 'a32,
    'a33, 'a34, 'a35, 'a36, 'a37,
    'a38, 'a39, 'a40, 'a41, 'a42,
    'a43, 'a44, 'a45)
    heros_journey_type -> 'a40 -> 'a10 **)

let begin0 heros_journey_type0 =
  heros_journey_type0.begin0
