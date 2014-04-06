#ifndef NONOGRAMEDITOR_H
#define NONOGRAMEDITOR_H

#include <QObject>
#include <QString>

class NonogramEditor : public QObject
{
    Q_OBJECT
public:
    explicit NonogramEditor(QObject *parent = 0);

signals:

private:
    QString m_title;
};

#endif // NONOGRAMEDITOR_H
