
type ('t_name, 't_attributes,
      't_attribute, 't_stories,
      't_story, 't_embodiments,
      't_embodiment, 't_identity) archetype_type = { 
attribute : ('t_identity -> 't_name
            -> 't_attributes);
pay_tribute : ('t_identity -> 't_name
              -> 't_attributes);
pay_homage : ('t_identity -> 't_name
             -> 't_attributes);
archetype_instance : ('t_identity ->
                     't_name ->
                     't_embodiment);
story : ('t_name -> 't_story) }

(** val archetype_instance :
    ('a1, 'a2, 'a3, 'a4, 'a5, 'a6,
    'a7, 'a8) archetype_type -> 'a8
    -> 'a1 -> 'a7 **)

let archetype_instance archetype_type0 =
  archetype_type0.archetype_instance
