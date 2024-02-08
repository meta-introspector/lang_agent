
type __ = Obj.t

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

type archetypeWarrior =
| Cadet
| Warrior

type archetypeWoman =
| Girl
| Woman

type archetypeWarriorWoman =
| WarriorWoman of archetypeWarrior * archetypeWoman

type greekAuthors =
| OtherAuthor
| Homer

type greekMythos =
| OtherMythos
| MythosOfAthena

type greekKings =
| OtherKing
| Pisistratus

type authorization =
| Authorized
| Unauthorized

type emotions =
| Happy
| Joy
| Sad

val greek_athena_mythos :
  (greekAuthors, greekMythos, archetypeWarriorWoman, greekKings,
  authorization, __, __, __, emotions, __, __, __) mythos
