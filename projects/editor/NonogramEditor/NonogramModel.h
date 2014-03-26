#ifndef NONOGRAMMODEL_H
#define NONOGRAMMODEL_H

#include <QString>
#include <QVector>
#include <QAbstractTableModel>

class NonogramModel : public QAbstractTableModel
{
    Q_OBJECT
    Q_PROPERTY(QString title READ title WRITE setTitle)
    Q_PROPERTY(QString comment READ comment WRITE setComment)

public:
    explicit NonogramModel(QObject *parent = 0);
    ~NonogramModel();

    int rowCount(const QModelIndex &parent) const;
    int columnCount(const QModelIndex &parent) const;
    QVariant data(const QModelIndex &index, int role) const;

    QString title() const;
    void setTitle(const QString &title);

    QString comment() const;
    void setComment(const QString &comment);

private:
    QString m_title;
    QString m_comment;
    QVector< QVector<int> > m_matrix;
};

#endif // NONOGRAMMODEL_H
