abstract sig LocalDatabase {}

abstract sig UserType extends LocalDatabase {}
one sig Admin extends UserType {}
sig User, Lock, LockUser extends UserType {}

one sig Permissions extends LocalDatabase {
	var have: User -> LockUser -> Bool
}
one sig Accesses extends LocalDatabase {
	-- entry is not dynamic
	entry: User -> LockUser -> Bool
}

abstract sig ExternalDatabase {
	-- user must exist on external database
	exists: LockUser
}

abstract sig Bool {}
one sig True, False extends Bool {}

fact always_have_admin
{
	UserType in LocalDatabase
	Admin in UserType 
}

/*
sig LocalDatabase {
  users: set UserType,
  permissions: set LockUser -> Lock,
  accessTable: set LockUser -> Lock,
  entryTable: set LockUser -> Lock -> Bool
}
*/



/*fact BoolConstants { --not needed
  True != False
}*/

/*
fact Init {
  Admin in LocalDatabase.users
  all u: LocalDatabase.users - Admin | u not in ExternalDatabase.exists
}

fact AdminControl {
  all u: UserType | u in LocalDatabase.users implies u = Admin or u in ExternalDatabase.exists
  Admin in LocalDatabase.users
  no User + Lock + LockUser in LocalDatabase.users - Admin
}

fact ExternalDBConstraints {
  all lu: LockUser | lu in LocalDatabase.users implies lu in ExternalDatabase.exists
}

pred AddUser[u: UserType] {
  u not in LocalDatabase.users implies u in ExternalDatabase.exists
}

pred AddPermission[lu: LockUser, l: Lock] {
  (lu in Admin + User) and (l in Admin + User) and (lu -> l not in LocalDatabase.permissions)
}

pred ReadPermission[lu: LockUser, l: Lock] {
  (lu in LockUser + User) and (l in Lock + LockUser) and (lu -> l in LocalDatabase.permissions)
}

pred ValidateEntry[lu: LockUser, l: Lock, success: Bool] {
  (lu -> l -> success in LocalDatabase.entryTable) and
  (success implies lu in ExternalDatabase.exists)
}

pred ActivateLock[lu: LockUser, l: Lock, success: Bool] {
  ValidateEntry[lu, l, success] and (success implies l in ExternalDatabase.exists)
}

pred AdminControlsEntry {
  all lu: LockUser, l: Lock | (lu -> l -> true in LocalDatabase.entryTable) implies lu = Admin
}*/

run {}
