# Gadget Defenders Books

Private multi-user bookkeeping for repair shops and resellers.

## Supabase setup

1. Open the Supabase SQL Editor.
2. Run `supabase-setup.sql` once.
3. In Authentication settings, keep email/password enabled.
4. Add the deployed app URL to Authentication > URL Configuration.

Each account is protected by Supabase Row Level Security. Users can only read and change their own bookkeeping state and receipt files.
