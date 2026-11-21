RL BAZAR WEBSITE + ADMIN FILES

Included:
- index.html: customer storefront
- admin.html: admin login and order dashboard
- rlbazar_admin.html: duplicate admin page filename
- rlbazar_supabase_setup.sql: database tables and security policies

IMPORTANT:
Both HTML files require Supabase URL and public anon/publishable key configured.
Never place the Supabase service_role/secret key in website HTML.

SUPABASE SETUP:
1. Create/open your Supabase project.
2. Dashboard > Authentication > Users > Add user. Create your admin email/password.
3. Open rlbazar_supabase_setup.sql. Replace ADMIN_EMAIL with your exact admin email.
4. Open Supabase SQL Editor and paste/run the edited SQL script.
5. Supabase Dashboard > Project Settings > API: copy Project URL and public anon/publishable key.
6. In index.html, find SUPABASE_URL and SUPABASE_ANON_KEY and replace the placeholders.
7. In admin.html, find SUPABASE_URL and SUPABASE_ANON_KEY and replace the placeholders with the same values.
8. Upload index.html, admin.html and rlbazar_supabase_setup.sql into the ROOT of your GitHub repository (not a subfolder). Commit the changes.
9. Vercel should redeploy automatically. Open your site URL and add /admin.html to it to visit the admin login.
10. Log in with the Supabase admin email/password. COD orders submitted from the storefront should appear in the dashboard once configured.

GITHUB UPLOAD:
Keep filenames exactly index.html and admin.html. Upload the SQL file too so you can access it when setting up Supabase.
