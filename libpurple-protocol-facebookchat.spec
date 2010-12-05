Summary:	Libpurple plug-in supporting facebook IM
Name:		libpurple-protocol-facebookchat
Version:	1.69
Release:	1
License:	GPL v3+
Group:		Applications/Networking
URL:		http://code.google.com/p/pidgin-facebookchat/
Source0:	http://pidgin-facebookchat.googlecode.com/files/pidgin-facebookchat-source-%{version}.tar.bz2
# Source0-md5:	e6855197f9cb3fc6540039b6d42841f6
Source1:	Makefile
BuildRequires:	json-glib-devel
BuildRequires:	libpurple-devel >= 2.5.8
Obsoletes:	pidgin-facebookchat < 1.35-3
Obsoletes:	purple-facebookchat
ExcludeArch:	s390x
BuildRoot:	%{tmpdir}/%{name}-%{version}-root-%(id -u -n)

%description
This is a Facebook chat plugin for Pidgin and libpurple messengers. It
connects to the new Facebook Chat IM service without the need for an
API key.

Currently the plugin can log into the Facebook servers, grab the buddy
list, send/receive messages, add/remove friends, receive
notifications, search for Facebook friends and set your Facebook
status.

%prep
%setup -q -n pidgin-facebookchat
# Upstream Makefile is totally horrible, use our own instead.
mv Makefile Makefile.orig
install -p %{SOURCE1} Makefile

%build
%{__make} \
	CC="%{__cc}" \
	CFLAGS="%{rpmcflags}"

%install
rm -rf $RPM_BUILD_ROOT
%{__make} install \
	LIBDIR=%{_libdir} \
	DESTDIR=$RPM_BUILD_ROOT

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(644,root,root,755)
%attr(755,root,root) %{_libdir}/purple-2/libfacebook.so
%{_pixmapsdir}/pidgin/protocols/*/facebook.png
