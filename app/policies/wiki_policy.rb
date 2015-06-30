class WikiPolicy < ApplicationPolicy

   class Scope
     attr_reader :user, :scope
 
     def initialize(user, scope)
       @user = user
       @scope = scope
     end
 
     def resolve
       wikis = []
       if  user
         if user.is_admin?
           wikis = scope.all # if the user is an admin, show them all the wikis
         elsif user.is_premium?
           all_wikis = scope.all
           all_wikis.each do |wiki|
             if wiki.is_public? || wiki.user == user || wiki.users.include?(user)
               wikis << wiki # if the user is premium, only show them public wikis, or private wikis they created, or private wikis they are a collaborator on
             end
           end
         else # this is the lowly standard user
           all_wikis = scope.all
           wikis = []
           all_wikis.each do |wiki|
             if wiki.is_public? || wiki.users.include?(user)
               wikis << wiki # only show standard users public wikis and private wikis they are a collaborator on
             end
           end
         end
       else #no user signed in
         all_wikis = scope.all
         wikis = []
         all_wikis.each do |wiki|
           if wiki.is_public?
             wikis << wiki # only show non-users public wikis
           end
         end
       end  
       wikis # return the wikis array we've built up
     end
   end
end

