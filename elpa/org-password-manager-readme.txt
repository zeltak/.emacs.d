Features
--------

1. Use Org mode as password manager.
2. Retrieve passwords in a practical and secure manner.
3. Generate secure passwords.
4. No configuration required.

Usage
-----

### Store passwords in Org mode files

Follow the example:

```org-mode
* [[http://example.com][My favorite website]]
  :PROPERTIES:
  :USERNAME: leandro
  :PASSWORD: chunky-tempeh
  :END:
* SSH key
  :PROPERTIES:
  :PASSWORD: tofu
  :END:
```

### Get username

Type `C-c C-p u` (`org-password-manager-get-username`) and search for the title
of the entry containing the `USERNAME` property (e.g. "My favorite
website"). Then it's going to be copied to your clipboard.

If the point is at an entry that contains the `USERNAME` property, it's copied
without querying you for the heading. If you still want to be queried (because
you want the username for a different entry) use the `C-u` argument typing `C-u
C-c C-p u`.

### Get password

Type `C-c C-p u` (`org-password-manager-get-password`) and search for the title
of the entry containing the `PASSWORD` property (e.g. "My favorite
website"). Then it's going to be copied to your clipboard. It tries to increase
the security by skipping the kill ring and copying the password directly to the
system's clipboard and by erasing it after 30 seconds (this period is
customizable, refer to the Configuration section on the README).

If the point is at an entry that contains the `PASSWORD` property, it's copied
without querying you for the heading. If you still want to be queried (because
you want the password for a different entry) use the `C-u` argument typing `C-u
C-c C-p u`.

### Generate password

Type `C-c C-p g` (`org-password-manager-generate-password`) and the generated
password will be inserted under the point on the buffer. It's also copied to
your clipboard. It tries to increase the security by skipping the kill ring
and copying the password directly to the system's clipboard and by erasing it
after 30 seconds (this period is customizable, refer to the Configuration
section on the README).

If you want to customize the `pwgen` command before running it (e.g. you want a
shorter password), use the `C-u` argument by typing `C-u C-c C-p g`.

Refer to `README.md' at https://github.com/leafac/org-password-manager for
more details.
