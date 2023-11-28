/*	The system are compost by Three elements: Locks, LockUsers, SystemUser
	At system execution there can be any number of these elements
	Alaways at system execution, will have one SystemUser of AdminUser, it will be granted by a fact
	Every Lock have it
	The components reside on a sig that is the system itself
	
*/
-- The main componnent, where all elements reside and operate on
one sig AccessSistem {
	var rooms: set Locks,
	--var users: set LockUsers,
	var management: set SystemUser
}

sig Locks {
	var state: LockState,
	var logMessages: set LockMessage,
	var authorized: set LockUsers
}
one abstract sig LockState {}
one sig Open extends LockState {}
one sig Closed extends LockState {}

-- A source of thuth about the validty of a LockUser, Locks will consult here
-- It will be as a property of LockUsers, that can be a Valid or Invalid
one abstract sig ExternalRegistry {}
one sig Valid extends ExternalRegistry {}
one sig Invalid extends ExternalRegistry {}

-- Users is a user that operate on Locks
sig LockUsers {
	valid: ExternalRegistry
}

-- SystemUser are users that can only operate on system adding or removing LockUser
-- So its better to define in a sig apart from LockUser, because they have not in common properties
-- RegularUser can only 
abstract sig SystemUser {}
one sig AdminUser extends SystemUser {}
sig SubAdminUser extends  SystemUser {}

-- A log for lock usage
abstract one sig LockMessage {
	tried: LockUser
}
one sig Granted extends LockMessage {}
one sig Denied extends LockMessage {}

/*
-- added for convenience, track operations on the system
abstract sig Operation {}
-- Try_Unlock, Grant_Access, 
one sig TU, GA extends Operation {}
-- Add_Permission, Remove_Permission 
one sig AP, RP extends Operation {}
-- Check_Valid_Lock_User
one sig CVU extends Operation {}
one sig Track {
	var op: lone Operation
}*/



run {}
