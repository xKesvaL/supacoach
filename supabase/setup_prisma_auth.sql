-- Prisma Auth setup for Supabase

-- This synchrnizes the Prisma Auth schema with the Supabase schema so you can 
-- use Supabase Auth alone and Prisma for your public schema tables without conflicts.

-- -- -- -- -- -- -- -- --
create or replace function public.handle_new_user()
returns trigger as $$
begin
        insert into public.profile (id)
        values (new.id);
        return new;
end;
$$ language plpgsql security definer;

        
-- -- -- -- -- -- -- -- --
create or replace trigger on_auth_user_created
        after insert on auth.users
        for each row execute procedure public.handle_new_user();

-- -- -- -- -- -- -- -- --
create or replace function public.handle_user_delete()
returns trigger as $$
begin
        delete from auth.users where id = old.id;
        return old;
end;
$$ language plpgsql security definer;

-- -- -- -- -- -- -- -- --
create or replace trigger on_profile_user_deleted
        after delete on public.profile
        for each row execute procedure public.handle_user_delete()
