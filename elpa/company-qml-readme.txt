                             _____________

                              COMPANY-QML

                              Junpeng Qiu
                             _____________


Table of Contents
_________________

1 Config
2 *TODO*


A company-mode backend for QML files.


1 Config
========

  1. First, you need plugins.qmltypes files so that they can be parsed
     to get the completion information for QML objects. Usually these
     files are automatically generated when you install Qt5. In my Arch
     Linux, the generated plugins.qmltypes files for QML are:
     ,----
     | $ locate plugins.qmltypes | grep QtQuick
     | /usr/lib/qt/qml/QtQuick/Controls/plugins.qmltypes
     | /usr/lib/qt/qml/QtQuick/Dialogs/plugins.qmltypes
     | /usr/lib/qt/qml/QtQuick/Extras/plugins.qmltypes
     | /usr/lib/qt/qml/QtQuick/Layouts/plugins.qmltypes
     | /usr/lib/qt/qml/QtQuick/LocalStorage/plugins.qmltypes
     | /usr/lib/qt/qml/QtQuick/Particles.2/plugins.qmltypes
     | /usr/lib/qt/qml/QtQuick/PrivateWidgets/plugins.qmltypes
     | /usr/lib/qt/qml/QtQuick/Window.2/plugins.qmltypes
     | /usr/lib/qt/qml/QtQuick/XmlListModel/plugins.qmltypes
     | /usr/lib/qt/qml/QtQuick.2/plugins.qmltypes
     `----

     If you can't find these files, refer to [this page] for more
     information of generating qmltypes files.
  2. Set the variable `qmltypes-parser-file-list' to a list of
     plugins.qmltypes files. Here is my setting:
     ,----
     | (setq qmltypes-parser-file-list '("/usr/lib/qt/qml/QtQuick/Controls/plugins.qmltypes"
     |                                   "/usr/lib/qt/qml/QtQuick/Dialogs/plugins.qmltypes"
     |                                   "/usr/lib/qt/qml/QtQuick/Extras/plugins.qmltypes"
     |                                   "/usr/lib/qt/qml/QtQuick/Layouts/plugins.qmltypes"
     |                                   "/usr/lib/qt/qml/QtQuick/LocalStorage/plugins.qmltypes"
     |                                   "/usr/lib/qt/qml/QtQuick/Particles.2/plugins.qmltypes"
     |                                   "/usr/lib/qt/qml/QtQuick/PrivateWidgets/plugins.qmltypes"
     |                                   "/usr/lib/qt/qml/QtQuick/Window.2/plugins.qmltypes"
     |                                   "/usr/lib/qt/qml/QtQuick/XmlListModel/plugins.qmltypes"
     |                                   "/usr/lib/qt/qml/QtQuick.2/plugins.qmltypes"))
     `----

     If you `require' the `company-qml' in you init files, to make the
     backend work, you must set the variable `qmltypes-parser-file-list'
     before that `require' expression.
  3. Finally, add the backend:
     ,----
     | (add-to-list 'company-backends 'company-qml)
     `----
     Done!


  [this page]
  http://doc.qt.io/qtcreator/creator-qml-modules-with-plugins.html#generating-qmltypes-files


2 *TODO*
========

  - Support "as" in import statement.
  - Implement a better QML parser. So far we only support very simple
    completions.
  - Javascript completions.

    I'm not proficient in either QML or the development of company-mode
    extensions. Any improvements or suggestions are welcome!
