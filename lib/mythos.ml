
type ('t_author, 't_mythos, 't_archetypes, 't_authority, 't_authorization,
      't_region, 't_epoch, 't_language, 't_emotions, 't_names,
      't_prompt_type, 't_response_type) mythos = { create : ('t_author ->
                                                            't_mythos);
                                                   invoke : ('t_prompt_type
                                                            ->
                                                            't_response_type);
                                                   evoke : ('t_prompt_type
                                                           -> 't_emotions);
                                                   reify : ('t_mythos ->
                                                           't_archetypes) }

(** val evoke :
    ('a1, 'a2, 'a3, 'a4, 'a5, 'a6, 'a7, 'a8, 'a9, 'a10, 'a11, 'a12) mythos
    -> 'a11 -> 'a9 **)

let evoke mythos0 =
  mythos0.evoke
