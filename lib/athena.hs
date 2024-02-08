module Athena where

import qualified Prelude

__ :: any
__ = Prelude.error "Logical or arity value used"

data Mythos t_author t_mythos t_archetypes t_authority t_authorization t_region t_epoch t_language t_emotions t_names t_prompt_type t_response_type =
   Build_mythos (t_author -> t_mythos) (t_prompt_type -> t_response_type) 
 (t_prompt_type -> t_emotions) (t_mythos -> t_archetypes)

data ArchetypeWarrior =
   Cadet
 | Warrior

data ArchetypeWoman =
   Girl
 | Woman

data ArchetypeWarriorWoman =
   WarriorWoman ArchetypeWarrior ArchetypeWoman

data GreekAuthors =
   OtherAuthor
 | Homer

data GreekMythos =
   OtherMythos
 | MythosOfAthena

data GreekKings =
   OtherKing
 | Pisistratus

data Authorization =
   Authorized
 | Unauthorized

data Emotions =
   Happy
 | Joy
 | Sad

greek_athena_mythos :: Mythos GreekAuthors GreekMythos
                       ArchetypeWarriorWoman GreekKings Authorization 
                       () () () Emotions () () ()
greek_athena_mythos =
  Build_mythos (\_ -> MythosOfAthena) __ (\_ -> Joy) (\_ -> WarriorWoman
    Warrior Woman)

